//%attributes = {"invisible":true}
/*
namedStyles := ***convert_styleSheets*** ( d4 )
 -> d4 (Object)
 <- namedStyles (Collection)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_styleSheets
// Database: Convert4DView
// ID[3B1DECEDEFF84EBEA8D2BD7847055357]
// Created #18-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 11:01:30
// ----------------------------------------------------
// Description:
// Convert all styleSheets as a collection
// ----------------------------------------------------
// Declarations
C_COLLECTION:C1488($0)
C_OBJECT:C1216($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_LONGINT:C283($Lon_i; $Lon_key; $Lon_styleSheet)
C_OBJECT:C1216($Obj_d4; $Obj_key; $Obj_style; $Obj_styleSheet)
C_COLLECTION:C1488($Coll_styleSheets)

ARRAY TEXT:C222($tTxt_ignoredProperties; 15)
ARRAY TEXT:C222($tTxt_keys; 0)

If (False:C215)
	C_COLLECTION:C1488(convert_styleSheets; $0)
	C_OBJECT:C1216(convert_styleSheets; $1)
	C_POINTER:C301(convert_styleSheets; $2)
	C_POINTER:C301(convert_styleSheets; $3)
End if 

// ----------------------------------------------------
// Initialisations 

// Required parameters
$Obj_d4:=$1

// Ignored keys [
$tTxt_ignoredProperties{1}:="showGrid"
$tTxt_ignoredProperties{2}:="spellCheck"
$tTxt_ignoredProperties{3}:="backColorOdd"
$tTxt_ignoredProperties{4}:="outline"
$tTxt_ignoredProperties{5}:="shadow"
$tTxt_ignoredProperties{6}:="condensed"
$tTxt_ignoredProperties{7}:="extended"
$tTxt_ignoredProperties{8}:="normalColorOdd"
$tTxt_ignoredProperties{9}:="zeroColorEven"
$tTxt_ignoredProperties{10}:="zeroColorOdd"
$tTxt_ignoredProperties{11}:="minusColorEven"
$tTxt_ignoredProperties{12}:="minusColorOdd"
//$tTxt_ignoredProperties{13}:="rotation"
//$tTxt_ignoredProperties{14}:="numericFormat"
$tTxt_ignoredProperties{13}:="stringFormat"
$tTxt_ignoredProperties{14}:="boolFormat"
//$tTxt_ignoredProperties{15}:="dateTimeFormat"
$tTxt_ignoredProperties{15}:="pictureFormat"
//]

// Create the style-sheet collection
$Coll_styleSheets:=New collection:C1472

// Create a style-sheets id/name correspondence array  into d4 object for later use
$Obj_d4._styleSheets:=New collection:C1472


// ----------------------------------------------------
// For each style-sheet
For ($Lon_styleSheet; 0; $Obj_d4.styleSheets.length-1; 1)
	
	$Obj_styleSheet:=$Obj_d4.styleSheets[$Lon_styleSheet]
	
	// Create a new style
	$Obj_style:=New object:C1471(\
		"name"; $Obj_styleSheet.name; \
		"parentName"; "cells"; \
		"font"; New object:C1471)
	
	OB GET PROPERTY NAMES:C1232($Obj_styleSheet.style; $tTxt_keys)
	
	// For each properties
	For ($Lon_key; 1; Size of array:C274($tTxt_keys); 1)
		
		If (Find in array:C230($tTxt_ignoredProperties; $tTxt_keys{$Lon_key})=-1)
			
			$Obj_key:=convert_styleKey(New object:C1471(\
				"key"; $tTxt_keys{$Lon_key}; \
				"value"; $Obj_styleSheet.style[$tTxt_keys{$Lon_key}]; \
				"source"; "style_sheet"); \
				$Obj_d4; $2; $3)
			
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
	
	// Populate missing font values with default values
	If ($Obj_style.font._font=Null:C1517)
		
		For ($Lon_i; 0; $Obj_d4.fontNames.length-1; 1)
			
			If ($Obj_d4.fontNames[$Lon_i].id=$Obj_d4.defaultStyle.fontID)
				
				$Obj_style.font._font:=$Obj_d4.fontNames[$Lon_i].name
				$Lon_i:=$Obj_d4.fontNames.length
				
			End if 
		End for 
	End if 
	
	If ($Obj_style.font._size=Null:C1517)
		
		$Obj_style.font._size:=String:C10($Obj_d4.defaultStyle.fontSize)+"pt"
		
	End if 
	//]
	
	// Transform the font properties as a text description
	$Obj_style.font:=convert_fontObjectToText($Obj_style.font)
	
	
	// Compare with main stylesheet font to not add identique elements [
	If ($Obj_style.font=$Obj_d4._defaultStyle.font)
		
		OB REMOVE:C1226($Obj_style; "font")
		
	End if 
	//]
	
	//If ($Obj_style._zeroColorEven#Null)
	
	//If ($Obj_style._zeroColorEven#String($Obj_style.foreColor))
	
	//$Obj_tempo:=OB Copy($Obj_style)
	
	//$Obj_tempo.foreColor:=$Obj_style._zeroColorEven
	//$Obj_tempo.name:=$Obj_style.name+"_0"
	//OB REMOVE($Obj_tempo;"_zeroColorEven")
	
	//$Coll_styleSheets[$Obj_viewStyleSheet.id-1]:=$Obj_tempo
	
	//End if 
	
	//OB REMOVE($Obj_style;"_zeroColorEven")
	
	//End if 
	
	$Obj_style.imeMode:=1
	
	// Append the style to the styleSheet collection
	$Coll_styleSheets[$Obj_styleSheet.id-1]:=$Obj_style
	
	// Append the id/name corresponding to d4 object
	$Obj_d4._styleSheets[$Obj_d4._styleSheets.length]:=New object:C1471(\
		"id"; $Obj_styleSheet.id; \
		"name"; $Obj_styleSheet.name)
	
End for 

// ----------------------------------------------------
// Return
$0:=$Coll_styleSheets

// ----------------------------------------------------
// End