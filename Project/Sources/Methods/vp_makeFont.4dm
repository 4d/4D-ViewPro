//%attributes = {"invisible":true}
C_OBJECT:C1216($1)  // object with font list
C_TEXT:C284($2)  // font css shorthand ex : "10px bold helvetica"

C_TEXT:C284($style)
C_OBJECT:C1216($font)
C_LONGINT:C283($fontFace)

$fontFace:=0

$font:=VP Font to object($2)

If (($font.family#"Courier")\
 & ($font.family#"Times")\
 & ($font.family#"Helvetica")\
 & ($font.family#"Symbol")\
 & ($font.family#"ZapfDingbats"))
	
	
	If (OB Is defined:C1231($font; "weight"))
		$style:="bold"
		$fontFace:=Bold:K14:2
	End if 
	
	If (OB Is defined:C1231($font; "style"))
		If ($font.style="italic")
			If ($style="")
				$style:="italic"
			Else 
				$style:="boldItalic"
			End if 
			$fontFace:=$fontFace+Italic:K14:3
		End if 
	End if 
	
	If ($style="")
		$style:="normal"
	End if 
	
	C_BOOLEAN:C305($alreadyInObject)
	$alreadyInObject:=False:C215
	
	If (OB Is defined:C1231($1; $font.family))
		If (OB Is defined:C1231($1[$font.family]; $style))
			$alreadyInObject:=True:C214
		End if 
	End if 
	
	If (Not:C34($alreadyInObject))
		C_OBJECT:C1216($file; $file2)
		C_BLOB:C604($blob)
		
		$file:=Font file:C1700($font.family; $fontFace)
		
		If ($file#Null:C1517)
			
			If (($file.file.extension=".ttf") | ($file.file.extension=".otf") | ($file.file.extension=".ttc") | ($file.file.extension=".otc"))
				
				// if bold or italic font file is the same then only store the normal font
				If ($fontFace#0)
					$file2:=Font file:C1700($font.family; 0)
					If ($file.file.platformPath=$file2.file.platformPath)
						$style:="normal"
					End if 
				End if 
				
				If (($file.file.extension=".ttc") | ($file.file.extension=".otc"))
					var $extractor : cs:C1710._TTC_extractor
					
					$extractor:=cs:C1710._TTC_extractor.new()
					$blob:=$extractor.extractTTF($file.file.platformPath; $file.ttfIndex)
					
				Else 
					DOCUMENT TO BLOB:C525($file.file.platformPath; $blob)
				End if 
				
				If (ok=1)
					
					C_LONGINT:C283($nbTables; $nbEncodingTables)
					C_LONGINT:C283($encodingID; $platformID)
					C_BOOLEAN:C305($cmap_found; $has_unicodeMap)
					C_LONGINT:C283($i; $j; $offset; $cmap_offset)
					C_TEXT:C284($table)
					
					// we need to parse the font file to check in the "cmap" table
					// if the font has a Unicode map, if not, the font can't be embedded in pdf
					// see https://docs.microsoft.com/en-us/typography/opentype/spec/otff#font-tables
					// for informations about browsing an OpenType font file
					
					$offset:=4
					$nbTables:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $offset)
					$cmap_found:=False:C215
					$has_unicodeMap:=False:C215
					
					If ($nbTables>0)
						
						// beginning of tables headers
						$offset:=12
						$i:=1
						
						Repeat 
							$table:=BLOB to text:C555($blob; UTF8 text without length:K22:17; $offset; 4)
							If (Position:C15("cmap"; $table; *)=1)
								$cmap_found:=True:C214
								
								// skip table checksum
								$offset:=$offset+4
								
								// read offset of cmap in blob
								$cmap_offset:=BLOB to longint:C551($blob; Macintosh byte ordering:K22:2; $offset)
								
								// skip version of Table in 'cmap' header
								$cmap_offset:=$cmap_offset+2
								
								// read number of encoding tables in 'cmap' header
								$nbEncodingTables:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $cmap_offset)
								
								// parse the EncodingRecords to check their platformID and encodingID
								If ($nbEncodingTables>0)
									$j:=1
									
									Repeat 
										
										$platformID:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $cmap_offset)
										$encodingID:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $cmap_offset)
										
										If ((($platformID=0) & ($encodingID=5)) | (($platformID=3) & ($encodingID=1)))
											$has_unicodeMap:=True:C214
										Else 
											$j:=$j+1
											$cmap_offset:=$cmap_offset+4
										End if 
										
									Until ($has_unicodeMap | ($j>$nbEncodingTables))
									
								End if 
								
							Else 
								$i:=$i+1
								$offset:=$offset+12
							End if 
						Until ($cmap_found | ($i>$nbTables))
						
					End if 
					
					If ($has_unicodeMap)
						
						C_TEXT:C284($encoded)
						BASE64 ENCODE:C895($blob; $encoded)
						
						If ($1[$font.family]=Null:C1517)
							$1[$font.family]:=New object:C1471
						End if 
						
						$1[$font.family][$style]:=$encoded
						
					End if 
				End if 
			End if 
		End if 
	End if 
End if 