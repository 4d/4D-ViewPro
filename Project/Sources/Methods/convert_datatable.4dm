//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : convert_datatable
// Database: Convert4DView
// ID[AA90D1C28BA04E838FCCE6E270EAE7C6]
// Created #21-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Create the dataTable object and copy content from the collections cell
// For each object in the collection cells, a new cell in the dataTable is created if it doesn't exist
// For each cell added in the dataTable, the styles are automatically applied
// ----------------------------------------------------
#DECLARE($in : Object) : Object

var $i; $j; $indx; $pos : Integer
var $column; $format; $row; $timeSeparator : Text
var $cell; $color; $dataTable; $key; $style : Object
var $col : Collection

var $BASE_DATE : Date:=Storage:C1525.ViewPro.BASE_DATE

var $dateFormat : Text
GET SYSTEM FORMAT:C994(System date short pattern:K60:7; $dateFormat)

GET SYSTEM FORMAT:C994(Time separator:K60:11; $timeSeparator)

ARRAY TEXT:C222($_SKIPPED_PROPERTIES; 8)
ARRAY TEXT:C222($_ignoredProperties; 0)
ARRAY TEXT:C222($_keys; 0)


// MARK:Ignored keys
$_SKIPPED_PROPERTIES{1}:="showGrid"
$_SKIPPED_PROPERTIES{2}:="spellCheck"
$_SKIPPED_PROPERTIES{3}:="pictHeights"
$_SKIPPED_PROPERTIES{4}:="inputFilter"
$_SKIPPED_PROPERTIES{5}:="outline"
$_SKIPPED_PROPERTIES{6}:="shadow"
$_SKIPPED_PROPERTIES{7}:="condensed"
$_SKIPPED_PROPERTIES{8}:="extended"

ARRAY TEXT:C222($tTxt_tags; 7)

$tTxt_tags{1}:="table"
$tTxt_tags{2}:="field"
$tTxt_tags{3}:="variableName"
$tTxt_tags{4}:="controlType"
$tTxt_tags{5}:="method"
$tTxt_tags{6}:="command"
$tTxt_tags{7}:="title"


$dataTable:=New object:C1471

$in.lastColumn:=0
$in.lastRow:=0

For each ($col; $in._cells)
	
	If ($col=Null:C1517)
		continue
		
	End if 
	
	For each ($cell; $col)
		
		If ($cell#Null:C1517)
			
			// MARK:redmine:95674
			CLEAR VARIABLE:C89($style)
			COPY ARRAY:C226($_SKIPPED_PROPERTIES; $_ignoredProperties)
			
			// Keep the last used column & row
			$in.lastColumn:=$cell.column>$in.lastColumn ? $cell.column : $in.lastColumn
			$in.lastRow:=$cell.row>$in.lastRow ? $cell.row : $in.lastRow
			
			If ($cell.table#Null:C1517)\
				 | ($cell.field#Null:C1517)\
				 | ($cell.variableName#Null:C1517)\
				 | ($cell.controlType#Null:C1517)\
				 | ($cell.method#Null:C1517)\
				 | ($cell.command#Null:C1517)\
				 | ($cell.title#Null:C1517)
				
				// 4D database table or field that is dynamically bound to cell
				// 4D process variable that is dynamically linked to a cell with a button control (radioButton, checkBox, etc)
				// 4D method that is dynamically linked to a cell with a button control (radioButton, checkBox, etc)
				
				// Keep the information
				$cell.tag:=$cell.tag || New object:C1471

				For ($i; 1; Size of array:C274($tTxt_tags); 1)
					
					If ($cell[$tTxt_tags{$i}]#Null:C1517)
						
						$cell.tag[$tTxt_tags{$i}]:=$cell.table
						
					End if 
				End for 
			End if 
			
			If (($cell.kind="value")\
				 | ($cell.kind="empty")\
				 | ($cell.kind="formula"))
				
				$row:=String:C10($cell.row-1)
				$column:=String:C10($cell.column-1)
				$dataTable[$row]:=$dataTable[$row] || New object:C1471
				$dataTable[$row][$column]:=$dataTable[$row][$column] || New object:C1471
				
				Case of 
						
						//______________________________________________________
					: ($cell.kind="empty")
						
						// NOTHING MORE TO DO
						
						//______________________________________________________
					: ($cell.formulaPro#Null:C1517)
						
						// Keep the formula
						$dataTable[$row][$column].formula:=$cell.formulaPro="=" ? $cell.formula : $cell.formulaPro
						
						//______________________________________________________
					: ($cell.value=Null:C1517)
						
						// NOTHING MORE TO DO
						
						//______________________________________________________
					: ($cell.valueType="string")
						
						If (Length:C16($cell.value)>0)  // Don't put empty string
							
							$dataTable[$row][$column].value:=$cell.value
							
						End if 
						
						//______________________________________________________
					: ($cell.valueType="hour")
						
						$dataTable[$row][$column].value:="/OADate("+String:C10($cell.value; "&xml")+")/"
						
						//______________________________________________________
					: ($cell.valueType="date")
						
						var $nbDays : Integer
						$nbDays:=Date:C102($cell.value+"T00:00:00")-$BASE_DATE
						
						$dataTable[$row][$column].value:="/OADate("+String:C10($nbDays)+")/"
						
						// Mark:ACI0103752
						//______________________________________________________
					: ($cell.valueType="real")\
						 && ($cell.style#Null:C1517)\
						 && (Num:C11($cell.style.numericFormat)=7)
						
						$dataTable[$row][$column].value:=$cell.value/100
						
						//______________________________________________________
					Else 
						
						$dataTable[$row][$column].value:=$cell.value
						
						//______________________________________________________
				End case 
				
				If ($cell.style#Null:C1517)
					
					OB GET PROPERTY NAMES:C1232($cell.style; $_keys)
					var $forceTextFormat : Boolean
					$forceTextFormat:=False:C215
					
					// If forceTextFormat, ignore other formats
					If ($cell.style.forceTextFormat#Null:C1517)\
						 && ($cell.style.forceTextFormat)
						
						$forceTextFormat:=True:C214
						
						If (Find in array:C230($_keys; "dateTimeFormat")>0)
							
							APPEND TO ARRAY:C911($_ignoredProperties; "dateTimeFormat")
							
						Else 
							
							$pos:=Find in array:C230($_ignoredProperties; "dateTimeFormat")
							
							If ($pos>0)
								
								DELETE FROM ARRAY:C228($_ignoredProperties; $pos)
								
							End if 
						End if 
						
						If (Find in array:C230($_keys; "numericFormat")>0)
							
							APPEND TO ARRAY:C911($_ignoredProperties; "numericFormat")
							
						Else 
							
							$pos:=Find in array:C230($_ignoredProperties; "numericFormat")
							
							If ($pos>0)
								
								DELETE FROM ARRAY:C228($_ignoredProperties; $pos)
								
							End if 
						End if 
					End if 
					
					If (Not:C34($forceTextFormat))\
						 && ($cell.valueType#Null:C1517)
						
						If ($cell.valueType="date")\
							 | ($cell.valueType="hour")
							
							If ($cell.style.dateTimeFormat=Null:C1517)
								
								$cell.style.dateTimeFormat:=$cell.valueType="date" ? 1 : 17
								APPEND TO ARRAY:C911($_keys; "dateTimeFormat")
								
							Else 
								
								APPEND TO ARRAY:C911($_ignoredProperties; "numericFormat")
								
							End if 
							
						Else 
							
							If ($cell.valueType="real")\
								 && ($cell.style.numericFormat#Null:C1517)
								
								APPEND TO ARRAY:C911($_ignoredProperties; "dateTimeFormat")
								
							End if 
						End if 
					End if 
					
					$style:=New object:C1471(\
						"parentName"; "cells"; \
						"font"; New object:C1471; \
						"foreColor"; New object:C1471; \
						"backColor"; New object:C1471)
					
					// For each property in the cell styles
					For ($indx; 1; Size of array:C274($_keys); 1)
						
						If (Find in array:C230($_ignoredProperties; $_keys{$indx})=-1)
							
							$key:=convert_styleKey(New object:C1471(\
								"key"; $_keys{$indx}; \
								"value"; $cell.style[$_keys{$indx}]; \
								"source"; "cell"; \
								"type"; $cell.valueType); $in)
							
							If ($key.type=Null:C1517)
								
								continue
								
							End if 
							
							Case of 
									
									//______________________________________________________
								: ($key.type="_styleSheet")  // StyleSheet reference
									
									If ($in._styleSheets#Null:C1517)
										
										For ($j; 0; $in._styleSheets.length-1; 1)
											
											If ($in._styleSheets[$j].id=$key.value)
												
												$style.parentName:=$in._styleSheets[$j].name
												
												break
												
											End if 
										End for 
										
									Else 
										
										ASSERT:C1129(Structure file:C489#Structure file:C489(*); "Missing \"_styleSheets\"")
										
									End if 
									
									//______________________________________________________
									
								: ($key.type="_bold")\
									 | ($key.type="_italic")\
									 | ($key.type="_size")\
									 | ($key.type="_font")
									
									// Temporary keep the result
									$style.font[$key.type]:=$key.value
									
									//______________________________________________________
								: ($key.type="_normalColorEven")\
									 | ($key.type="_normalColorOdd")\
									 | ($key.type="_zeroColorOdd")\
									 | ($key.type="_zeroColorEven")\
									 | ($key.type="_minusColorOdd")\
									 | ($key.type="_minusColorEven")
									
									// Temporary keep the result
									$style.foreColor[$key.type]:=$key.value
									
									//______________________________________________________
								: ($key.type="_backColorEven")\
									 | ($key.type="_backColorOdd")
									
									$style.backColor[$key.type]:=$key.value
									
									//______________________________________________________
								: ($_keys{$indx}="numericFormat")\
									 & (String:C10($cell.valueType)="real")\
									 & (Position:C15("%"; String:C10($key.value))>0)
									
									// Compare with main stylesheet to not add common elements
									If ($in._defaultStyle[$key.type]#Null:C1517)
										
										If ($key.value#$in._defaultStyle[$key.type])
											
											$style[$key.type]:=$key.value
											
										End if 
										
									Else 
										
										$style[$key.type]:=$key.value
										
									End if 
									
									//______________________________________________________
								: ($key.type="locked")
									
									If (Bool:C1537($key.value))
										
										$style[$key.type]:=True:C214
										$in.isProtected:=True:C214
										
									End if 
									
									//______________________________________________________
								Else 
									
									// Compare with main stylesheet to not add common elements
									If ($in._defaultStyle[$key.type]#Null:C1517)
										
										If ($key.value#$in._defaultStyle[$key.type])
											
											$style[$key.type]:=$key.value
											
										End if 
										
									Else 
										
										$style[$key.type]:=$key.value
										
									End if 
									
									//______________________________________________________
							End case 
						End if 
					End for 
					
					If (($style.textOrientation#Null:C1517)\
						 & ($style.hAlign=Null:C1517)\
						 & ($cell.valueType#Null:C1517))
						
						If (($style.textOrientation=90)\
							 & ($cell.valueType="string"))
							
							$style.hAlign:=0
							
						End if 
						
						If (($style.textOrientation=-90)\
							 & ($cell.valueType#"string"))
							
							$style.hAlign:=2
							
						End if 
					End if 
					
					// Append the style to the data table element if any 
					
					If (OB Is empty:C1297($style.font))
						
						OB REMOVE:C1226($style; "font")
						
					Else 
						
						// Transform the font properties as a text description
						$style.font:=convert_fontObjectToText($style.font)
						
						If ($style.font#$in._defaultStyle.font)
							
							$style.font:=convert_gatherFontStyle($style.font; $in._defaultStyle.font)
							
						Else 
							
							OB REMOVE:C1226($style; "font")
							
						End if 
					End if 
					
					OB GET PROPERTY NAMES:C1232($in._defaultStyle; $_keys)
					
					For ($indx; 1; Size of array:C274($_keys); 1)
						
						Case of 
								
								//______________________________________________________
							: (Position:C15("_normalColorEven"; $_keys{$indx})=1)\
								 | (Position:C15("_normalColorOdd"; $_keys{$indx})=1)\
								 | (Position:C15("_zeroColorEven"; $_keys{$indx})=1)\
								 | (Position:C15("_zeroColorOdd"; $_keys{$indx})=1)\
								 | (Position:C15("_minusColorEven"; $_keys{$indx})=1)\
								 | (Position:C15("_minusColorOdd"; $_keys{$indx})=1)
								
								If ($style.foreColor[$_keys{$indx}]=Null:C1517)
									
									$style.foreColor[$_keys{$indx}]:=$in._defaultStyle[$_keys{$indx}]
									
								End if 
								
								//______________________________________________________
							: (Position:C15("_backColorEven"; $_keys{$indx})=1)\
								 | (Position:C15("_backColorOdd"; $_keys{$indx})=1)
								
								If ($style.backColor[$_keys{$indx}]=Null:C1517)
									
									$style.backColor[$_keys{$indx}]:=$in._defaultStyle[$_keys{$indx}]
									
								End if 
								
								//______________________________________________________
						End case 
					End for 
					
					If (OB Is empty:C1297($style.foreColor))
						
						OB REMOVE:C1226($style; "foreColor")
						
					Else 
						
						// Calculate the correct foreColor
						$style.foreColor:=convert_foreColor($style; $style.foreColor; $cell)
						
						If ($in._defaultStyle.foreColor#Null:C1517)
							
							If ($style.foreColor=$in._defaultStyle.foreColor)
								
								// OB REMOVE($Obj_style;"foreColor")
								
							End if 
							
						Else 
							
							If ($style.foreColor="black")
								
								OB REMOVE:C1226($style; "foreColor")
								
							End if 
						End if 
					End if 
					
					If (OB Is empty:C1297($style.backColor))
						
						OB REMOVE:C1226($style; "backColor")
						
					Else 
						
						// Calculate the correct backColor
						If (Num:C11($style.backColor._backColorEven)=Num:C11($style.backColor._backColorOdd))\
							 | ((($cell.row-1)%2)=0)  // Both or even line
							
							$style.backColor:=convert_color($style.backColor._backColorOdd; False:C215)
							
						Else 
							
							$style.backColor:=convert_color($style.backColor._backColorEven; False:C215)
							
						End if 
						
						If ($in._defaultStyle.backColor#Null:C1517)
							
							If ($style.backColor=$in._defaultStyle.backColor)
								
								OB REMOVE:C1226($style; "backColor")
								
							End if 
							
						Else 
							
							If ($style.backColor="white")
								
								OB REMOVE:C1226($style; "backColor")
								
							End if 
						End if 
					End if 
					
					If (Not:C34(OB Is empty:C1297($style)))
						
						$dataTable[$row][$column].style:=$style
						
					End if 
					
				Else 
					
					Case of 
							
							//______________________________________________________
						: ($cell.valueType=Null:C1517)
							
							// NOTHING MORE TO DO
							
							//______________________________________________________
						: ($cell.valueType="date")
							
							If (Position:C15("yy"; $dateFormat)=0)
								
								$format:=Replace string:C233($dateFormat; "y"; "yy")
								
							End if 
							
							$dataTable[$row][$column].style:=New object:C1471(\
								"parentName"; "cells"; \
								"formatter"; $format)
							
							//______________________________________________________
						: ($cell.valueType="hour")
							
							$format:="[hh]"+$timeSeparator+"mm"+$timeSeparator+"ss"
							
							$dataTable[$row][$column].style:=New object:C1471(\
								"parentName"; "cells"; \
								"formatter"; $format)
							
							//______________________________________________________
						: ($cell.valueType="long8")  // #96218 date+time
							
							$format:=$dateFormat+" "+"hh"+$timeSeparator+"mm"+$timeSeparator+"ss"
							
							$dataTable[$row][$column].style:=New object:C1471(\
								"parentName"; "cells"; \
								"formatter"; $format)
							
							//______________________________________________________
						Else 
							
							// ??
							
							//______________________________________________________
					End case 
					
					// Mark:Get the default style colors
					$style:=$style || New object:C1471
					$color:=New object:C1471
					
					OB GET PROPERTY NAMES:C1232($in._defaultStyle; $_keys)
					
					For ($indx; 1; Size of array:C274($_keys); 1)
						
						If (Position:C15("_"; $_keys{$indx})=1)
							
							$color[$_keys{$indx}]:=$in._defaultStyle[$_keys{$indx}]
							
						End if 
					End for 
					
					If (Not:C34(OB Is empty:C1297($color)))
						
						$style.foreColor:=convert_foreColor($style; $color; $cell)
						
						If ($color._backColorEven#Null:C1517)\
							 | ($color._backColorOdd#Null:C1517)
							
							// Calculate the correct backColor
							If (Num:C11($color._backColorEven)=Num:C11($color._backColorOdd))\
								 | ((($cell.row-1)%2)=0)  // Both or even line
								
								If (Num:C11($color._backColorOdd)#0)
									
									$style.backColor:=convert_color(Num:C11($color._backColorOdd); False:C215)
									
								End if 
								
							Else 
								
								If (Num:C11($color._backColorEven)#0)
									
									$style.backColor:=convert_color(Num:C11($color._backColorEven); False:C215)
									
								End if 
							End if 
						End if 
					End if 
				End if 
				
				// If there are some carriage returns in the string applies the wordWrap
				// Style to be sure they are correctly displayed
				If ($cell.valueType#Null:C1517)\
					 && ($cell.valueType="string")\
					 && (Position:C15(Char:C90(13); $cell.value)>0)
					
					$style.wordWrap:=True:C214
					
				End if 
				
				If (OB Is empty:C1297($style))
					
					continue
					
				End if 
				
				// mark:#redmine:95674
				If ($style.foreColor=$in._defaultStyle.foreColor)
					
					OB REMOVE:C1226($style; "foreColor")
					
				End if 
				
				If ($in._defaultStyle._backColorEven#Null:C1517)\
					 | ($in._defaultStyle._backColorOdd#Null:C1517)
					
					// mark:Calculate the correct backColor
					If (Num:C11($in._defaultStyle._backColorEven)=Num:C11($in._defaultStyle._backColorOdd))\
						 | ((($cell.row-1)%2)=0)  // Both or even line
						
						If (Num:C11($in._defaultStyle._backColorOdd)#0)\
							 && ($style.backColor#Null:C1517)\
							 && ($style.backColor=convert_color(Num:C11($in._defaultStyle._backColorOdd); False:C215))
							
							OB REMOVE:C1226($style; "backColor")
							
						End if 
						
					Else 
						
						If (Num:C11($color._backColorEven)#0)\
							 && ($style.backColor=convert_color(Num:C11($color._backColorEven); False:C215))
							
							OB REMOVE:C1226($style; "backColor")
							
						End if 
					End if 
				End if 
				
				If (OB Is empty:C1297($style))
					
					continue
					
				End if 
				
				If ($dataTable[$row][$column].style=Null:C1517)
					
					$dataTable[$row][$column].style:=$style
					
				Else 
					
					OB GET PROPERTY NAMES:C1232($style; $_keys)
					
					For ($j; 1; Size of array:C274($_keys); 1)
						
						$dataTable[$row][$column].style[$_keys{$j}]:=$style[$_keys{$j}]
						
					End for 
				End if 
				
			Else 
				
				// Keep the information
				$cell.tag:=$cell.tag || New object:C1471
				$cell.tag.kind:=$cell.kind
				
			End if 
		End if 
	End for each 
End for each 

return $dataTable