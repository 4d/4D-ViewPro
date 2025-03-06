//%attributes = {"invisible":true}
/*
style := ***convert_headerStyles*** ( d4 )
 -> d4 (Object)
 <- style (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_headerStyles
// Database: Convert4DView
// ID[09C5A9535E494B7BA6F5B2F99D838352]
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

ARRAY TEXT:C222($tTxt_ignoredProperties; 24)
ARRAY TEXT:C222($tTxt_keys; 0)

If (False:C215)
	C_OBJECT:C1216(convert_headerStyles; $0)
	C_OBJECT:C1216(convert_headerStyles; $1)
End if 

// ----------------------------------------------------
// Initialisations

// Required parameters
$Obj_d4:=$1

// Ignored keys [
$tTxt_ignoredProperties{1}:="locked"
$tTxt_ignoredProperties{2}:="visible"
$tTxt_ignoredProperties{3}:="showGrid"
$tTxt_ignoredProperties{4}:="spellCheck"
$tTxt_ignoredProperties{5}:="pictHeights"
$tTxt_ignoredProperties{6}:="inputFilter"
$tTxt_ignoredProperties{7}:="backColorEven"
$tTxt_ignoredProperties{8}:="backColorOdd"
$tTxt_ignoredProperties{9}:="outline"
$tTxt_ignoredProperties{10}:="shadow"
$tTxt_ignoredProperties{11}:="condensed"
$tTxt_ignoredProperties{12}:="extended"
$tTxt_ignoredProperties{13}:="normalColorOdd"
$tTxt_ignoredProperties{14}:="zeroColorEven"
$tTxt_ignoredProperties{15}:="zeroColorOdd"
$tTxt_ignoredProperties{16}:="minusColorEven"
$tTxt_ignoredProperties{17}:="minusColorOdd"
//$tTxt_ignoredProperties{18}:="hAlign"
//$tTxt_ignoredProperties{19}:="vAlign"
//$tTxt_ignoredProperties{20}:="rotation"
$tTxt_ignoredProperties{18}:="wordWrap"
$tTxt_ignoredProperties{19}:="forceTextFormat"
$tTxt_ignoredProperties{20}:="numericFormat"
$tTxt_ignoredProperties{21}:="stringFormat"
$tTxt_ignoredProperties{22}:="boolFormat"
$tTxt_ignoredProperties{23}:="dateTimeFormat"
$tTxt_ignoredProperties{24}:="pictureFormat"
//]

// Create a new style
$Obj_style:=New object:C1471(\
"name"; "headers"; \
"font"; New object:C1471)


// ----------------------------------------------------
OB GET PROPERTY NAMES:C1232($Obj_d4.headerStyle; $tTxt_keys)

// For each properties
For ($Lon_key; 1; Size of array:C274($tTxt_keys); 1)
	
	If (Find in array:C230($tTxt_ignoredProperties; $tTxt_keys{$Lon_key})=-1)
		
		$Obj_key:=convert_styleKey(New object:C1471(\
			"key"; $tTxt_keys{$Lon_key}; \
			"value"; $Obj_d4.headerStyle[$tTxt_keys{$Lon_key}]; \
			"source"; "header"); \
			$Obj_d4)
		
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