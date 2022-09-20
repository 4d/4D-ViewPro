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

C_LONGINT:C283($Lon_key; $nbParameters)
C_OBJECT:C1216($Obj_d4; $Obj_key; $Obj_style)

ARRAY TEXT:C222($tTxt_ignoredProperties; 0)
ARRAY TEXT:C222($tTxt_keys; 0)

If (False:C215)
	C_OBJECT:C1216(convert_defaultStyle; $0)
	C_OBJECT:C1216(convert_defaultStyle; $1)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Obj_d4:=$1
	
	// Optional parameters
	If ($nbParameters>=4)
		
		// <NONE>
		
	End if 
	
	// Ignored keys [
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "showGrid")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "spellCheck")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "pictHeights")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "inputFilter")
	
	//APPEND TO ARRAY($tTxt_ignoredProperties;"backColorEven")
	//APPEND TO ARRAY($tTxt_ignoredProperties;"backColorOdd")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "outline")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "shadow")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "condensed")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "extended")
	
	//APPEND TO ARRAY($tTxt_ignoredProperties;"normalColorOdd")
	//APPEND TO ARRAY($tTxt_ignoredProperties;"zeroColorEven")
	//APPEND TO ARRAY($tTxt_ignoredProperties;"zeroColorOdd")
	//APPEND TO ARRAY($tTxt_ignoredProperties;"minusColorEven")
	//APPEND TO ARRAY($tTxt_ignoredProperties;"minusColorOdd")
	//APPEND TO ARRAY($tTxt_ignoredProperties;"rotation")
	
	//APPEND TO ARRAY($tTxt_ignoredProperties;"wordWrap")
	//APPEND TO ARRAY($tTxt_ignoredProperties;"forceTextFormat")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "numericFormat")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "stringFormat")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "boolFormat")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "dateTimeFormat")
	APPEND TO ARRAY:C911($tTxt_ignoredProperties; "pictureFormat")
	//]
	
	// Create a new style
	$Obj_style:=New object:C1471(\
		"name"; "cells"; \
		"themeFont"; "Body"; \
		"font"; New object:C1471; \
		"formatter"; "General"; \
		"multiLine"; True:C214; \
		"locked"; False:C215)
	
Else 
	
	ABORT:C156
	
End if 

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