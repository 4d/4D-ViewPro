//%attributes = {"invisible":true}
/*
style := ***convert_defaultStyle*** ( d4 )
 -> d4 (Object)
 <- style (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_defaultStyle
// Database: Convert4DView
// ID[EEB48D66260547B180109D3B64B48F43]
// Created #4-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_LONGINT:C283($Lon_key)
C_OBJECT:C1216($Obj_d4; $Obj_key; $Obj_style)

ARRAY TEXT:C222($tTxt_ignoredProperties; 13)
ARRAY TEXT:C222($tTxt_keys; 0)

If (False:C215)
	C_OBJECT:C1216(convert_defaultStyle; $0)
	C_OBJECT:C1216(convert_defaultStyle; $1)
End if 

// ----------------------------------------------------
// Initialisations

// Required parameters
$Obj_d4:=$1

// Ignored keys [
$tTxt_ignoredProperties{1}:="showGrid"
$tTxt_ignoredProperties{2}:="spellCheck"
$tTxt_ignoredProperties{3}:="pictHeights"
$tTxt_ignoredProperties{4}:="inputFilter"

//$tTxt_ignoredProperties{5}:="backColorEven"
//$tTxt_ignoredProperties{6}:="backColorOdd"
$tTxt_ignoredProperties{5}:="outline"
$tTxt_ignoredProperties{6}:="shadow"
$tTxt_ignoredProperties{7}:="condensed"
$tTxt_ignoredProperties{8}:="extended"

//$tTxt_ignoredProperties{9}:="normalColorOdd"
//$tTxt_ignoredProperties{10}:="zeroColorEven"
//$tTxt_ignoredProperties{11}:="zeroColorOdd"
//$tTxt_ignoredProperties{12}:="minusColorEven"
//$tTxt_ignoredProperties{13}:="minusColorOdd"
//$tTxt_ignoredProperties{14}:="rotation"

//$tTxt_ignoredProperties{15}:="wordWrap"
//$tTxt_ignoredProperties{16}:="forceTextFormat"
$tTxt_ignoredProperties{9}:="numericFormat"
$tTxt_ignoredProperties{10}:="stringFormat"
$tTxt_ignoredProperties{11}:="boolFormat"
$tTxt_ignoredProperties{12}:="dateTimeFormat"
$tTxt_ignoredProperties{13}:="pictureFormat"
//]

// Create a new style
$Obj_style:=New object:C1471(\
"name"; "cells"; \
"themeFont"; "Body"; \
"font"; New object:C1471; \
"formatter"; "General"; \
"multiLine"; True:C214; \
"locked"; False:C215)


// ----------------------------------------------------
OB GET PROPERTY NAMES:C1232($Obj_d4.defaultStyle; $tTxt_keys)

// For each properties
For ($Lon_key; 1; Size of array:C274($tTxt_keys); 1)
	
	If (Find in array:C230($tTxt_ignoredProperties; $tTxt_keys{$Lon_key})=-1)
		
		$Obj_key:=convert_styleKey(New object:C1471(\
			"key"; $tTxt_keys{$Lon_key}; \
			"value"; $Obj_d4.defaultStyle[$tTxt_keys{$Lon_key}]; \
			"source"; "cell"); $Obj_d4)
		
		Case of 
				
				//______________________________________________________
			: ($Obj_key.type=Null:C1517)
				
				// NOTHING MORE TO DO
				
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
				$Obj_style[$Obj_key.type]:=$Obj_key.value
				
				If ($Obj_key.type="_normalColorEven")
					
					$Obj_style.foreColor:=convert_color($Obj_key.value; False:C215)
					
				End if 
				
				//______________________________________________________
			: ($Obj_key.type="_backColorEven")\
				 | ($Obj_key.type="_backColorOdd")
				
				$Obj_style[$Obj_key.type]:=$Obj_key.value
				
				If ($Obj_key.type="_backColorEven")\
					 & ($Obj_key.value#0x00FFFFFF)  // Default is white
					
					$Obj_style.backColor:=convert_color($Obj_key.value; False:C215)
					
				End if 
				
				//______________________________________________________
			Else 
				
				$Obj_style[$Obj_key.type]:=$Obj_key.value
				
				//______________________________________________________
		End case 
	End if 
End for 

// Transform the font properties as a text description
$Obj_style.font:=convert_fontObjectToText($Obj_style.font)

$Obj_style.imeMode:=1

// ----------------------------------------------------
// Return
$0:=$Obj_style

// ----------------------------------------------------
// End