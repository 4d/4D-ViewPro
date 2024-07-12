//%attributes = {"invisible":true}
// (object with font list,  font css shorthand ex : "10px bold helvetica")
#DECLARE($fontList : Object; $shorthand : Text)

var $style : Text:=""
var $fontFace : Integer:=0
var $font : Object:=VP Font to object($shorthand)

If (($font.family="Courier")\
 || ($font.family="Times")\
 || ($font.family="Helvetica")\
 || ($font.family="Symbol")\
 || ($font.family="ZapfDingbats"))
	return   // font already supported by SpreadJS export
End if 


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


If (OB Is defined:C1231($fontList; $font.family))
	If (OB Is defined:C1231($fontList[$font.family]; $style))
		return   // already InObject
	End if 
End if 

var $blob : Blob

var $file : Object:=Font file:C1700($font.family; $fontFace)
If ($file=Null:C1517)
	// font not found (maybe not installed)
	return 
End if 

If (($file.file.extension#".ttf") && ($file.file.extension#".otf") && ($file.file.extension#".ttc") && ($file.file.extension#".otc"))
	// not supported font
	return 
End if 


// if bold or italic font file is the same then only store the normal font
If ($fontFace#0)
	var $file2 : Object:=Font file:C1700($font.family; 0)
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

If (Not:C34(ok=1))
	return 
End if 

// we need to parse the font file to check in the "cmap" table
// if the font has a Unicode map, if not, the font can't be embedded in pdf
// see https://docs.microsoft.com/en-us/typography/opentype/spec/otff#font-tables
// for informations about browsing an OpenType font file

var $offset:=4
var $nbTables:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $offset)
If ($nbTables=0)
	return 
End if 

var $cmap_found:=False:C215
var $has_unicodeMap:=False:C215

// beginning of tables headers
$offset:=12

var $i:=1
Repeat 
	var $table : Text:=BLOB to text:C555($blob; UTF8 text without length:K22:17; $offset; 4)
	If (Position:C15("cmap"; $table; *)=1)
		$cmap_found:=True:C214
		
		// skip table checksum
		$offset+=4
		
		// read offset of cmap in blob
		var $cmap_offset:=BLOB to longint:C551($blob; Macintosh byte ordering:K22:2; $offset)
		
		// skip version of Table in 'cmap' header
		$cmap_offset+=2
		
		// read number of encoding tables in 'cmap' header
		var $nbEncodingTables:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $cmap_offset)
		
		// parse the EncodingRecords to check their platformID and encodingID
		If ($nbEncodingTables>0)
			
			var $j:=1
			Repeat 
				
				var $platformID:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $cmap_offset)
				var $encodingID:=BLOB to integer:C549($blob; Macintosh byte ordering:K22:2; $cmap_offset)
				
				If ((($platformID=0) && ($encodingID=5)) || (($platformID=3) && ($encodingID=1)))
					$has_unicodeMap:=True:C214
				Else 
					$j+=1
					$cmap_offset+=4
				End if 
				
			Until ($has_unicodeMap || ($j>$nbEncodingTables))
			
		End if 
		
	Else 
		
		$i+=1
		$offset+=12
		
	End if 
	
Until ($cmap_found || ($i>$nbTables))


If ($has_unicodeMap)
	
	var $encoded : Text
	BASE64 ENCODE:C895($blob; $encoded)
	
	If ($fontList[$font.family]=Null:C1517)
		$fontList[$font.family]:={}
	End if 
	
	$fontList[$font.family][$style]:=$encoded
	
End if 