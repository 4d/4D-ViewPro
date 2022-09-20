//%attributes = {"invisible":true}
/*
namedStyles := ***convert_styleRanges*** ( d4 ; viewPro ; Param_3 )
» d4 (Object)
» viewPro (Object)
» Param_3 (Collection)
<- namedStyles (Collection)
________________________________________________________
*/

C_COLLECTION:C1488($0)
C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($column; $Lon_ii; $Lon_key; $nbParameters; $Lon_range; $row)
C_TEXT:C284($Txt_column; $Txt_row)
C_OBJECT:C1216($Obj_d4; $Obj_data; $Obj_dataTable; $Obj_key; $Obj_style; $Obj_styleRange)
C_OBJECT:C1216($Obj_viewPro)
C_COLLECTION:C1488($Coll_namedStyles)
C_OBJECT:C1216($cell)
C_TEXT:C284($color)

ARRAY TEXT:C222($tTxt_ignoredProperties; 0)
ARRAY TEXT:C222($tTxt_keys; 0)

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Obj_d4:=$1
	
	// Optional parameters
	If ($nbParameters>=2)
		
		$Obj_viewPro:=$2
		$Obj_data:=$Obj_viewPro.spreadJS.sheets.Sheet1.data
		$Obj_dataTable:=$Obj_data.dataTable
		
	End if 
	
	// Ignored keys
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "showGrid")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "spellCheck")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "pictHeights")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "inputFilter")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "outline")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "shadow")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "condensed")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "extended")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "zeroColorEven")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "zeroColorOdd")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "minusColorEven")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "minusColorOdd")
	
	$Coll_namedStyles:=New collection:C1472
	
Else 
	
	ABORT:C156
	
End if 

For each ($Obj_styleRange; $Obj_d4.styleRanges)
	
	$Lon_range:=$Lon_range+1
	
	$Obj_style:=New object:C1471(\
		"parentName"; "cells"; \
		"name"; "range_"+String:C10($Lon_range); \
		"font"; New object:C1471; \
		"foreColor"; New object:C1471; \
		"backColor"; New object:C1471)
	
	OB GET PROPERTY NAMES:C1232($Obj_styleRange.style; $tTxt_keys)
	
	For ($Lon_key; 1; Size of array:C274($tTxt_keys); 1)
		
		If (Find in array:C230($tTxt_ignoredProperties; $tTxt_keys{$Lon_key})=-1)
			
			$Obj_key:=convert_styleKey(New object:C1471(\
				"key"; $tTxt_keys{$Lon_key}; \
				"value"; $Obj_styleRange.style[$tTxt_keys{$Lon_key}]; \
				"source"; "range"; \
				"type"; $Obj_styleRange.valueType); \
				$Obj_d4)
			
			Case of 
					
					//______________________________________________________
				: ($Obj_key.type=Null:C1517)
					
					// NOTHING MORE TO DO
					
					//______________________________________________________
				: ($Obj_key.type="_styleSheet")  // StyleSheet reference
					
					If ($Obj_d4._styleSheets#Null:C1517)
						
						For ($Lon_ii; 0; $Obj_d4._styleSheets.length-1; 1)
							
							If ($Obj_d4._styleSheets[$Lon_ii].id=$Obj_key.value)
								
								$Obj_style.parentName:=$Obj_d4._styleSheets[$Lon_ii].name
								$Lon_ii:=$Obj_d4._styleSheets.length  // Break
								
							End if 
						End for 
						
					Else 
						
						ASSERT:C1129(Structure file:C489#Structure file:C489(*); "Missing \"_styleSheets\"")
						
					End if 
					
					//______________________________________________________
				: ($Obj_key.type="_bold")\
					 | ($Obj_key.type="_italic")\
					 | ($Obj_key.type="_size")\
					 | ($Obj_key.type="_font")
					
					// Temporary keep the result
					$Obj_style.font[$Obj_key.type]:=$Obj_key.value
					
					//______________________________________________________
				: ($Obj_key.type="_normalColorEven")\
					 | ($Obj_key.type="_normalColorOdd")\
					 | ($Obj_key.type="_zeroColorOdd")\
					 | ($Obj_key.type="_zeroColorEven")\
					 | ($Obj_key.type="_minusColorOdd")\
					 | ($Obj_key.type="_minusColorEven")
					
					// Temporary keep the result
					$Obj_style.foreColor[$Obj_key.type]:=$Obj_key.value
					
					//______________________________________________________
				: ($Obj_key.type="_backColorEven")\
					 | ($Obj_key.type="_backColorOdd")
					
					$Obj_style.backColor[$Obj_key.type]:=$Obj_key.value
					
					//______________________________________________________
				Else 
					
					// Compare with main stylesheet to not add common elements [
					If ($Obj_d4._defaultStyle[$Obj_key.type]#Null:C1517)
						
						If ($Obj_key.value#$Obj_d4._defaultStyle[$Obj_key.type])
							
							$Obj_style[$Obj_key.type]:=$Obj_key.value
							
						End if 
						
					Else 
						
						$Obj_style[$Obj_key.type]:=$Obj_key.value
						
					End if 
					//]
					
					//______________________________________________________
			End case 
		End if 
	End for 
	
	// Append the style to the data table element if any
	If (Not:C34(OB Is empty:C1297($Obj_style)))
		
		$Obj_style.imeMode:=1
		
		$Coll_namedStyles[$Coll_namedStyles.length]:=$Obj_style
		
		If ($Obj_style.foreColor#Null:C1517)
			
			If (Value type:C1509($Obj_style.foreColor)=Is object:K8:27)
				
				If (Not:C34(OB Is empty:C1297($Obj_style.foreColor)))
					
					If ($obj_style.foreColor._normalColorEven=$Obj_style.foreColor._normalColorOdd)
						
						$Obj_style.foreColor:=convert_foreColor($Obj_style.foreColor; New object:C1471)
						
						If ($obj_style.foreColor="black")
							
							OB REMOVE:C1226($Obj_style; "foreColor")
						End if 
						
					End if 
				End if 
			End if 
		End if 
		
		If ($Obj_style.backColor#Null:C1517)
			
			If (Value type:C1509($Obj_style.backColor)=Is object:K8:27)
				
				If (Not:C34(OB Is empty:C1297($Obj_style.backColor)))
					
					If ($obj_style.backColor._backColorEven=$Obj_style.backColor._backColorOdd)
						
						$Obj_style.backColor:=convert_color($Obj_style.backColor._backColorEven; False:C215)
						
						If ($Obj_style.backColor="#FFFFFF")
							
							OB REMOVE:C1226($Obj_style; "backColor")
						End if 
					End if 
				End if 
			End if 
		End if 
		
		If (Not:C34(OB Is empty:C1297($Obj_style.font)))
			
			// Transform the font properties as a text description
			$Obj_style.font:=convert_fontObjectToText($Obj_style.font)
			
		Else 
			
			OB REMOVE:C1226($Obj_style; "font")
			
		End if 
		
		Case of 
				
				//______________________________________________________
			: ($Obj_styleRange.bottom=2147483647)\
				 & ($Obj_styleRange.right=2147483647)  // Modify the style for the sheet
				
				$Obj_data.defaultDataNode.style:=$Obj_style.name
				
				//______________________________________________________
			: ($Obj_styleRange.bottom=2147483647)  // Apply style to the column
				
				If ($Obj_data.columnDataArray=Null:C1517)
					
					$Obj_data.columnDataArray:=New collection:C1472
					
				End if 
				
				For ($column; $Obj_styleRange.left; $Obj_styleRange.right; 1)
					
					$Obj_data.columnDataArray[$column-1]:=New object:C1471(\
						"style"; $Obj_style.name)
					
				End for 
				
				//______________________________________________________
			: ($Obj_styleRange.right=2147483647)  // Apply style to the row
				
				If ($Obj_data.rowDataArray=Null:C1517)
					
					$Obj_data.rowDataArray:=New collection:C1472
					
				End if 
				
				For ($row; $Obj_styleRange.top; $Obj_styleRange.bottom; 1)
					
					$Obj_data.rowDataArray[$row-1]:=New object:C1471(\
						"style"; $Obj_style.name)
					
				End for 
				
				//______________________________________________________
			Else 
				
				// Set the style for all cells in the range
				If ($Obj_dataTable#Null:C1517)
					
					For ($row; $Obj_styleRange.top; $Obj_styleRange.bottom; 1)
						
						$Txt_row:=String:C10($row-1)
						
						For ($column; $Obj_styleRange.left; $Obj_styleRange.right; 1)
							
							$Txt_column:=String:C10($column-1)
							
							If ($Obj_dataTable[$Txt_row]=Null:C1517)
								
								$Obj_dataTable[$Txt_row]:=New object:C1471
								
							End if 
							
							If ($Obj_dataTable[$Txt_row][$Txt_column]=Null:C1517)
								
								$Obj_dataTable[$Txt_row][$Txt_column]:=New object:C1471
								
							End if 
							
							If ($Obj_dataTable[$Txt_row][$Txt_column].style=Null:C1517)
								
								$Obj_dataTable[$Txt_row][$Txt_column].style:=New object:C1471
								
							End if 
							
							If (Length:C16(String:C10($Obj_dataTable[$Txt_row][$Txt_column].style.parentName))=0)\
								 | (String:C10($Obj_dataTable[$Txt_row][$Txt_column].style.parentName)="cells")
								
								$Obj_dataTable[$Txt_row][$Txt_column].style.parentName:=$Obj_style.name
								
								If ($Obj_style.foreColor#Null:C1517)
									
									If (Value type:C1509($Obj_style.foreColor)=Is object:K8:27)
										
										If (Not:C34(OB Is empty:C1297($Obj_style.foreColor)))
											$cell:=$Obj_dataTable[$Txt_row][$Txt_column]
											$cell.row:=Num:C11($row)
											
											$color:=convert_foreColor($Obj_style.foreColor; $cell)
											
											If ($color#"black")
												If ($Obj_dataTable[$Txt_row][$Txt_column].style.foreColor=Null:C1517)
													
													$Obj_dataTable[$Txt_row][$Txt_column].style.foreColor:=$color
												End if 
											End if 
											
										Else 
											
											OB REMOVE:C1226($Obj_style; "foreColor")
											
										End if 
										
									End if 
									
								End if 
								
								If ($Obj_style.backColor#Null:C1517)
									
									If (Value type:C1509($Obj_style.backColor)=Is object:K8:27)
										
										If (Not:C34(OB Is empty:C1297($Obj_style.backColor)))
											
											// Calculate the correct backColor
											If (Num:C11($Obj_style.backColor._backColorEven)=Num:C11($Obj_style.backColor._backColorOdd))\
												 | ((($row-1)%2)=0)  // Both or even line
												
												$color:=convert_color($Obj_style.backColor._backColorOdd; False:C215)
												
											Else 
												
												$color:=convert_color($Obj_style.backColor._backColorEven; False:C215)
												
											End if 
											
											If ($color#"#FFFFFF")
												If ($Obj_dataTable[$Txt_row][$Txt_column].style.backColor=Null:C1517)
													
													$Obj_dataTable[$Txt_row][$Txt_column].style.backColor:=$color
												End if 
											End if 
											
											
										Else 
											
											OB REMOVE:C1226($Obj_style; "backColor")
											
										End if 
										
									End if 
									
									
								End if 
								
							Else 
								
								ASSERT:C1129(Structure file:C489#Structure file:C489(*))
								
							End if 
							
							
							//#ACI0097857 [
							//If ($Obj_dataTable[$Txt_row][$Txt_column].style.font#Null)\
																																																																																& ($Obj_style.font#Null)
							//If ($Obj_dataTable[$Txt_row][$Txt_column].style.font#$Obj_style.font)
							//$Obj_dataTable[$Txt_row][$Txt_column].style.font:=mergeFontStyleDefinition ($Obj_dataTable[$Txt_row][$Txt_column].style.font;$Obj_style.font)
							//End if
							//End if
							
							If ($Obj_style.font#Null:C1517)
								If ($Obj_style.font#"")
									// Merge range style with default font
									$Obj_style.font:=convert_mergeFontStyle($Obj_d4._defaultStyle.font; $Obj_style.font)
									
									If ($Obj_dataTable[$Txt_row][$Txt_column].style.font#Null:C1517)
										
										C_TEXT:C284($cellFont)
										$cellFont:=convert_mergeFontStyle($Obj_dataTable[$Txt_row][$Txt_column].style.font; $Obj_style.font)
										
										If ($cellFont#$Obj_style.font)
											$Obj_dataTable[$Txt_row][$Txt_column].style.font:=$cellFont
										Else 
											OB REMOVE:C1226($Obj_dataTable[$Txt_row][$Txt_column].style; "font")
										End if 
									End if 
								End if 
								//]
							End if 
						End for 
					End for 
				End if 
				
				//______________________________________________________
		End case 
	End if 
	
	// End for
	If (Value type:C1509($Obj_style.backColor)=Is object:K8:27)
		OB REMOVE:C1226($Obj_style; "backColor")
	End if 
	
	If (Value type:C1509($Obj_style.foreColor)=Is object:K8:27)
		OB REMOVE:C1226($Obj_style; "foreColor")
	End if 
	
	
End for each 


// ----------------------------------------------------
// Return
$0:=$Coll_namedStyles

// ----------------------------------------------------
// End