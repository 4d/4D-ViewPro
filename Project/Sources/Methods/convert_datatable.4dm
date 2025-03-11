//%attributes = {"invisible":true}
/*
dataTable := ***convert_datatable*** ( d4 )
» d4 (Object)
<- dataTable (Object)
________________________________________________________
*/
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
#DECLARE($Obj_d4 : Object; $Obj_styleIgnored : Pointer; $Obj_styleForeColor : Pointer) : Object

var $Lon_i; $j; $indx; $pos : Integer
var $Txt_col; $Txt_format; $Txt_row; $Txt_timeSeparator : Text
var $keysIndx : Text
var $Obj_cell; $Obj_color; $Obj_dataTable; $Obj_key; $Obj_style : Object
var $col : Collection

var $dateFormat : Text
GET SYSTEM FORMAT:C994(System date short pattern:K60:7; $dateFormat)

GET SYSTEM FORMAT:C994(Time separator:K60:11; $Txt_timeSeparator)

ARRAY TEXT:C222($tTxt_ignoredProperties; 0)
ARRAY TEXT:C222($tTxt_keys; 0)

// MARK:Ignored keys
ARRAY TEXT:C222($_SKIPPED_PROPERTIES; 8)
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

ARRAY TEXT:C222($FOREGROUND_COLOR_PROPERTIES; 6)  // or replace by $Obj_styleForeColor
$FOREGROUND_COLOR_PROPERTIES{1}:="_normalColorEven"
$FOREGROUND_COLOR_PROPERTIES{2}:="_normalColorOdd"
$FOREGROUND_COLOR_PROPERTIES{3}:="_zeroColorOdd"
$FOREGROUND_COLOR_PROPERTIES{4}:="_zeroColorEven"
$FOREGROUND_COLOR_PROPERTIES{5}:="_minusColorOdd"
$FOREGROUND_COLOR_PROPERTIES{6}:="_minusColorEven"

ARRAY TEXT:C222($FONT_PROPERTIES; 4)
$FONT_PROPERTIES{1}:="_bold"
$FONT_PROPERTIES{2}:="_italic"
$FONT_PROPERTIES{3}:="_size"
$FONT_PROPERTIES{4}:="_font"

ARRAY TEXT:C222($BACKGROUND_COLOR_PROPERTIES; 2)
$BACKGROUND_COLOR_PROPERTIES{1}:="_backColorEven"
$BACKGROUND_COLOR_PROPERTIES{2}:="_backColorOdd"

ARRAY TEXT:C222($CELL_KINDS; 3)
$CELL_KINDS{1}:="value"
$CELL_KINDS{2}:="empty"
$CELL_KINDS{3}:="formula"


$Obj_dataTable:=New object:C1471

$Obj_d4.lastColumn:=0
$Obj_d4.lastRow:=0

For each ($col; $Obj_d4._cells)
	If ($col#Null:C1517)
		For each ($Obj_cell; $col)
			If ($Obj_cell#Null:C1517)
				
				// MARK:redmine:95674
				CLEAR VARIABLE:C89($Obj_style)
				COPY ARRAY:C226($_SKIPPED_PROPERTIES; $tTxt_ignoredProperties)
				
				// Keep the last used column & row
				$Obj_d4.lastColumn:=$Obj_cell.column>$Obj_d4.lastColumn ? $Obj_cell.column : $Obj_d4.lastColumn
				$Obj_d4.lastRow:=$Obj_cell.row>$Obj_d4.lastRow ? $Obj_cell.row : $Obj_d4.lastRow
				
				If ($Obj_cell.table#Null:C1517)\
					 | ($Obj_cell.field#Null:C1517)\
					 | ($Obj_cell.variableName#Null:C1517)\
					 | ($Obj_cell.controlType#Null:C1517)\
					 | ($Obj_cell.method#Null:C1517)\
					 | ($Obj_cell.command#Null:C1517)\
					 | ($Obj_cell.title#Null:C1517)
					
					// 4D database table or field that is dynamically bound to cell
					// 4D process variable that is dynamically linked to a cell with a button control (radioButton, checkBox, etc)
					// 4D method that is dynamically linked to a cell with a button control (radioButton, checkBox, etc)
					
					// Keep the information
					If ($Obj_cell.tag=Null:C1517)
						
						$Obj_cell.tag:=New object:C1471
						
					End if 
					
					For ($Lon_i; 1; Size of array:C274($tTxt_tags); 1)
						
						If ($Obj_cell[$tTxt_tags{$Lon_i}]#Null:C1517)
							
							$Obj_cell.tag[$tTxt_tags{$Lon_i}]:=$Obj_cell.table
							
						End if 
					End for 
				End if 
				
				If (Find in array:C230($CELL_KINDS; $Obj_cell.kind)>0)
					
					$Txt_row:=String:C10($Obj_cell.row-1)
					$Txt_col:=String:C10($Obj_cell.column-1)
					
					If ($Obj_dataTable[$Txt_row]=Null:C1517)
						
						$Obj_dataTable[$Txt_row]:=New object:C1471($Txt_col; New object:C1471())
					Else 
						If ($Obj_dataTable[$Txt_row][$Txt_col]=Null:C1517)
							$Obj_dataTable[$Txt_row][$Txt_col]:=New object:C1471
						End if 
					End if 
					
					Case of 
							
							//______________________________________________________
						: ($Obj_cell.kind="empty")
							
							// NOTHING MORE TO DO
							
							//______________________________________________________
						: ($Obj_cell.formulaPro#Null:C1517)
							
							// Keep the formula
							$Obj_dataTable[$Txt_row][$Txt_col].formula:=$Obj_cell.formulaPro="=" ? $Obj_cell.formula : $Obj_cell.formulaPro
							
							//______________________________________________________
						: ($Obj_cell.value=Null:C1517)
							
							// NOTHING MORE TO DO
							
							//______________________________________________________
							//: ($Obj_cell.valueType="hour") //#95992
							// Specific format
							//$Obj_dataTable[$Txt_row][$Txt_col].value:=Time string($Obj_cell.value)
							
							//______________________________________________________
						: ($Obj_cell.valueType="string")
							
							If (Length:C16($Obj_cell.value)>0)  // Don't put empty string
								
								$Obj_dataTable[$Txt_row][$Txt_col].value:=$Obj_cell.value
								
							End if 
							
							//______________________________________________________
						: ($Obj_cell.valueType="hour")
							
							$Obj_dataTable[$Txt_row][$Txt_col].value:="/OADate("+String:C10($Obj_cell.value; "&xml")+")/"
							
							
							//______________________________________________________
						: ($Obj_cell.valueType="date")
							
							C_LONGINT:C283($nbDays)
							$nbDays:=Date:C102($Obj_cell.value+"T00:00:00")-!1899-12-30!
							
							$Obj_dataTable[$Txt_row][$Txt_col].value:="/OADate("+String:C10($nbDays)+")/"
							
							// Mark:ACI0103752
							//______________________________________________________
						: ($Obj_cell.valueType="real")\
							 && ($Obj_cell.style#Null:C1517)\
							 && (Num:C11($Obj_cell.style.numericFormat)=7)
							
							$Obj_dataTable[$Txt_row][$Txt_col].value:=$Obj_cell.value/100
							
							//______________________________________________________
						Else 
							
							$Obj_dataTable[$Txt_row][$Txt_col].value:=$Obj_cell.value
							
							//______________________________________________________
					End case 
					
					If ($Obj_cell.style#Null:C1517)
						
						OB GET PROPERTY NAMES:C1232($Obj_cell.style; $tTxt_keys)
						C_BOOLEAN:C305($forceTextFormat)
						$forceTextFormat:=False:C215
						
						// If forceTextFormat, ignore other formats
						If ($Obj_cell.style.forceTextFormat#Null:C1517)\
							 && ($Obj_cell.style.forceTextFormat)
							
							$forceTextFormat:=True:C214
							
							If (Find in array:C230($tTxt_keys; "dateTimeFormat")>0)
								
								APPEND TO ARRAY:C911($tTxt_ignoredProperties; "dateTimeFormat")
								
							Else 
								
								$pos:=Find in array:C230($tTxt_ignoredProperties; "dateTimeFormat")
								
								If ($pos>0)
									
									DELETE FROM ARRAY:C228($tTxt_ignoredProperties; $pos)
									
								End if 
							End if 
							
							If (Find in array:C230($tTxt_keys; "numericFormat")>0)
								
								APPEND TO ARRAY:C911($tTxt_ignoredProperties; "numericFormat")
								
							Else 
								
								$pos:=Find in array:C230($tTxt_ignoredProperties; "numericFormat")
								
								If ($pos>0)
									
									DELETE FROM ARRAY:C228($tTxt_ignoredProperties; $pos)
									
								End if 
							End if 
						End if 
						
						If (Not:C34($forceTextFormat))\
							 && ($Obj_cell.valueType#Null:C1517)
							
							If ($Obj_cell.valueType="date")\
								 | ($Obj_cell.valueType="hour")
								
								If ($Obj_cell.style.dateTimeFormat=Null:C1517)
									
									$Obj_cell.style.dateTimeFormat:=$Obj_cell.valueType="date" ? 1 : 17
									APPEND TO ARRAY:C911($tTxt_keys; "dateTimeFormat")
									
								Else 
									
									APPEND TO ARRAY:C911($tTxt_ignoredProperties; "numericFormat")
									
								End if 
								
							Else 
								
								If ($Obj_cell.valueType="real")\
									 && ($Obj_cell.style.numericFormat#Null:C1517)
									
									APPEND TO ARRAY:C911($tTxt_ignoredProperties; "dateTimeFormat")
									
								End if 
							End if 
						End if 
						
						$Obj_style:=New object:C1471(\
							"parentName"; "cells"; \
							"font"; New object:C1471; \
							"foreColor"; New object:C1471; \
							"backColor"; New object:C1471)
						
						// For each property in the cell styles
						For ($indx; 1; Size of array:C274($tTxt_keys); 1)
							$keysIndx:=$tTxt_keys{$indx}
							
							If (Find in array:C230($tTxt_ignoredProperties; $keysIndx)=-1)
								
								$Obj_key:=convert_styleKey(New object:C1471(\
									"key"; $keysIndx; \
									"value"; $Obj_cell.style[$keysIndx]; \
									"source"; "cell"; \
									"type"; $Obj_cell.valueType); $Obj_d4; $Obj_styleIgnored; $Obj_styleForeColor)
								
								If ($Obj_key.type=Null:C1517)
									
									continue
									
								End if 
								
								Case of 
										
										//______________________________________________________
									: ($Obj_key.type="_styleSheet")  // StyleSheet reference
										
										If ($Obj_d4._styleSheets#Null:C1517)
											
											For ($j; 0; $Obj_d4._styleSheets.length-1; 1)
												
												If ($Obj_d4._styleSheets[$j].id=$Obj_key.value)
													
													$Obj_style.parentName:=$Obj_d4._styleSheets[$j].name
													
													break
													
												End if 
											End for 
											
										Else 
											
											ASSERT:C1129(Structure file:C489#Structure file:C489(*); "Missing \"_styleSheets\"")
											
										End if 
										
										//______________________________________________________
									: (Find in array:C230($FONT_PROPERTIES; $Obj_key.type)>0)
										
										// Temporary keep the result
										$Obj_style.font[$Obj_key.type]:=$Obj_key.value
										
										//______________________________________________________
									: (Find in array:C230($FOREGROUND_COLOR_PROPERTIES; $Obj_key.type)>0)
										
										// Temporary keep the result
										$Obj_style.foreColor[$Obj_key.type]:=$Obj_key.value
										
										//______________________________________________________
									: (Find in array:C230($BACKGROUND_COLOR_PROPERTIES; $Obj_key.type)>0)
										
										$Obj_style.backColor[$Obj_key.type]:=$Obj_key.value
										
										//______________________________________________________
									: ($keysIndx="numericFormat")\
										 && (String:C10($Obj_cell.valueType)="real")\
										 && (Position:C15("%"; String:C10($Obj_key.value))>0)
										
										// Compare with main stylesheet to not add common elements
										If ($Obj_d4._defaultStyle[$Obj_key.type]#Null:C1517)
											
											If ($Obj_key.value#$Obj_d4._defaultStyle[$Obj_key.type])
												
												$Obj_style[$Obj_key.type]:=$Obj_key.value
												
											End if 
											
										Else 
											
											$Obj_style[$Obj_key.type]:=$Obj_key.value
											
										End if 
										//]
										
										//______________________________________________________
									: ($Obj_key.type="locked")
										
										If (Bool:C1537($Obj_key.value))
											
											$Obj_style[$Obj_key.type]:=True:C214
											$Obj_d4.isProtected:=True:C214
											
										End if 
										
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
						
						If (($Obj_style.textOrientation#Null:C1517)\
							 & ($Obj_style.hAlign=Null:C1517)\
							 & ($Obj_cell.valueType#Null:C1517))
							
							If (($Obj_style.textOrientation=90)\
								 & ($Obj_cell.valueType="string"))
								
								$Obj_style.hAlign:=0
								
							End if 
							
							If (($Obj_style.textOrientation=-90)\
								 & ($Obj_cell.valueType#"string"))
								
								$Obj_style.hAlign:=2
								
							End if 
						End if 
						
						// Append the style to the data table element if any [
						
						If (OB Is empty:C1297($Obj_style.font))
							
							OB REMOVE:C1226($Obj_style; "font")
							
						Else 
							
							// Transform the font properties as a text description
							$Obj_style.font:=convert_fontObjectToText($Obj_style.font)
							
							If ($Obj_style.font#$Obj_d4._defaultStyle.font)
								
								$Obj_style.font:=convert_gatherFontStyle($Obj_style.font; $Obj_d4._defaultStyle.font)
								
							Else 
								
								OB REMOVE:C1226($Obj_style; "font")
								
							End if 
						End if 
						
						OB GET PROPERTY NAMES:C1232($Obj_d4._defaultStyle; $tTxt_keys)
						
						For ($indx; 1; Size of array:C274($tTxt_keys); 1)
							$keysIndx:=$tTxt_keys{$indx}
							Case of 
									
									//______________________________________________________
								: (Find in array:C230($FOREGROUND_COLOR_PROPERTIES; $keysIndx)>0)
									
									If ($Obj_style.foreColor[$keysIndx]=Null:C1517)
										
										$Obj_style.foreColor[$keysIndx]:=$Obj_d4._defaultStyle[$keysIndx]
										
									End if 
									
									//______________________________________________________
								: (Find in array:C230($BACKGROUND_COLOR_PROPERTIES; $keysIndx)>0)
									
									If ($Obj_style.backColor[$keysIndx]=Null:C1517)
										
										$Obj_style.backColor[$keysIndx]:=$Obj_d4._defaultStyle[$keysIndx]
										
									End if 
									
									//______________________________________________________
							End case 
						End for 
						
						If (OB Is empty:C1297($Obj_style.foreColor))
							
							OB REMOVE:C1226($Obj_style; "foreColor")
							
						Else 
							
							// Calculate the correct foreColor
							$Obj_style.foreColor:=convert_foreColor($Obj_style; $Obj_style.foreColor; $Obj_cell)
							
							If ($Obj_d4._defaultStyle.foreColor#Null:C1517)
								
								If ($Obj_style.foreColor=$Obj_d4._defaultStyle.foreColor)
									
									//OB REMOVE($Obj_style;"foreColor")
									
								End if 
								
							Else 
								
								If ($Obj_style.foreColor="black")
									
									OB REMOVE:C1226($Obj_style; "foreColor")
									
								End if 
							End if 
						End if 
						
						If (OB Is empty:C1297($Obj_style.backColor))
							
							OB REMOVE:C1226($Obj_style; "backColor")
							
						Else 
							
							// Calculate the correct backColor
							If (Num:C11($Obj_style.backColor._backColorEven)=Num:C11($Obj_style.backColor._backColorOdd))\
								 | ((($Obj_cell.row-1)%2)=0)  // Both or even line
								
								$Obj_style.backColor:=convert_color($Obj_style.backColor._backColorOdd; False:C215)
								
							Else 
								
								$Obj_style.backColor:=convert_color($Obj_style.backColor._backColorEven; False:C215)
								
							End if 
							
							If ($Obj_d4._defaultStyle.backColor#Null:C1517)
								
								If ($Obj_style.backColor=$Obj_d4._defaultStyle.backColor)
									
									OB REMOVE:C1226($Obj_style; "backColor")
									
								End if 
								
							Else 
								
								If ($Obj_style.backColor="white")
									
									OB REMOVE:C1226($Obj_style; "backColor")
									
								End if 
							End if 
						End if 
						
						If (Not:C34(OB Is empty:C1297($Obj_style)))
							
							$Obj_dataTable[$Txt_row][$Txt_col].style:=$Obj_style
							
						End if 
						//]
						
					Else 
						
						Case of 
								
								//______________________________________________________
							: ($Obj_cell.valueType=Null:C1517)
								
								// NOTHING MORE TO DO
								//______________________________________________________
							: ($Obj_cell.valueType="date")
								
								If (Position:C15("yy"; $dateFormat)=0)
									
									$Txt_format:=Replace string:C233($dateFormat; "y"; "yy")
									
								End if 
								
								$Obj_dataTable[$Txt_row][$Txt_col].style:=New object:C1471(\
									"parentName"; "cells"; \
									"formatter"; $Txt_format)
								
								//______________________________________________________
							: ($Obj_cell.valueType="hour")
								
								$Txt_format:="[hh]"+$Txt_timeSeparator+"mm"+$Txt_timeSeparator+"ss"
								
								$Obj_dataTable[$Txt_row][$Txt_col].style:=New object:C1471(\
									"parentName"; "cells"; \
									"formatter"; $Txt_format)
								
								
								//______________________________________________________
							: ($Obj_cell.valueType="long8")  //#96218 date+time
								
								$Txt_format:=$dateFormat+" "+"hh"+$Txt_timeSeparator+"mm"+$Txt_timeSeparator+"ss"
								
								$Obj_dataTable[$Txt_row][$Txt_col].style:=New object:C1471(\
									"parentName"; "cells"; \
									"formatter"; $Txt_format)
								
								//______________________________________________________
							Else 
								
								// ??
								
								//______________________________________________________
						End case 
						
						// Mark:Get the default style colors
						$Obj_style:=$Obj_style || New object:C1471
						$Obj_color:=New object:C1471
						
						OB GET PROPERTY NAMES:C1232($Obj_d4._defaultStyle; $tTxt_keys)
						
						For ($indx; 1; Size of array:C274($tTxt_keys); 1)
							$keysIndx:=$tTxt_keys{$indx}
							If (Position:C15("_"; $keysIndx)=1)
								
								$Obj_color[$keysIndx]:=$Obj_d4._defaultStyle[$keysIndx]
								
							End if 
						End for 
						
						If (Not:C34(OB Is empty:C1297($Obj_color)))
							
							$Obj_style.foreColor:=convert_foreColor($Obj_style; $Obj_color; $Obj_cell)
							
							If ($Obj_color._backColorEven#Null:C1517)\
								 | ($Obj_color._backColorOdd#Null:C1517)
								
								// Calculate the correct backColor
								If (Num:C11($Obj_color._backColorEven)=Num:C11($Obj_color._backColorOdd))\
									 | ((($Obj_cell.row-1)%2)=0)  // Both or even line
									
									If (Num:C11($Obj_color._backColorOdd)#0)
										
										$Obj_style.backColor:=convert_color(Num:C11($Obj_color._backColorOdd); False:C215)
										
									End if 
									
								Else 
									
									If (Num:C11($Obj_color._backColorEven)#0)
										
										$Obj_style.backColor:=convert_color(Num:C11($Obj_color._backColorEven); False:C215)
										
									End if 
								End if 
							End if 
						End if 
					End if 
					
					// If there are some carriage returns in the string applies the wordWrap
					// Style to be sure they are correctly displayed
					If ($Obj_cell.valueType#Null:C1517)\
						 && ($Obj_cell.valueType="string")\
						 && (Position:C15(Char:C90(13); $Obj_cell.value)>0)
						
						$Obj_style.wordWrap:=True:C214
						
					End if 
					
					If (OB Is empty:C1297($Obj_style))
						
						continue
						
					End if 
					
					// mark:#redmine:95674
					If ($Obj_style.foreColor=$Obj_d4._defaultStyle.foreColor)
						
						OB REMOVE:C1226($Obj_style; "foreColor")
						
					End if 
					
					If ($Obj_d4._defaultStyle._backColorEven#Null:C1517)\
						 | ($Obj_d4._defaultStyle._backColorOdd#Null:C1517)
						
						// mark:Calculate the correct backColor
						If (Num:C11($Obj_d4._defaultStyle._backColorEven)=Num:C11($Obj_d4._defaultStyle._backColorOdd))\
							 | ((($Obj_cell.row-1)%2)=0)  // Both or even line
							
							If (Num:C11($Obj_d4._defaultStyle._backColorOdd)#0)\
								 && ($Obj_style.backColor#Null:C1517)\
								 && ($Obj_style.backColor=convert_color(Num:C11($Obj_d4._defaultStyle._backColorOdd); False:C215))
								
								OB REMOVE:C1226($Obj_style; "backColor")
								
							End if 
							
						Else 
							
							If (Num:C11($Obj_color._backColorEven)#0)\
								 && ($Obj_style.backColor=convert_color(Num:C11($Obj_color._backColorEven); False:C215))
								
								OB REMOVE:C1226($Obj_style; "backColor")
								
							End if 
						End if 
					End if 
					
					If (OB Is empty:C1297($Obj_style))
						
						continue
						
					End if 
					
					If ($Obj_dataTable[$Txt_row][$Txt_col].style=Null:C1517)
						
						$Obj_dataTable[$Txt_row][$Txt_col].style:=$Obj_style
						
					Else 
						
						OB GET PROPERTY NAMES:C1232($Obj_style; $tTxt_keys)
						
						For ($j; 1; Size of array:C274($tTxt_keys); 1)
							
							$Obj_dataTable[$Txt_row][$Txt_col].style[$tTxt_keys{$j}]:=$Obj_style[$tTxt_keys{$j}]
							
						End for 
					End if 
					
				Else 
					
					// Keep the information
					If ($Obj_cell.tag=Null:C1517)
						$Obj_cell.tag:=New object:C1471("kind"; $Obj_cell.kind)
					Else 
						$Obj_cell.tag.kind:=$Obj_cell.kind
					End if 
					
				End if 
			End if 
		End for each 
	End if 
End for each 

return $Obj_dataTable