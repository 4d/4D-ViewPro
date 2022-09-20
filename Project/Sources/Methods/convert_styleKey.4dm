//%attributes = {"invisible":true}
/*
out := ***convert_styleKey*** ( in ; d4 )
 -> in (Object)
 -> d4 (Object)
 <- out (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_styleKey
// Database: Convert4DView
// ID[57355EA8CB6E467A95E4E7C64CEBB21C]
// Created #6-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 11:01:10
// ----------------------------------------------------
// Description:
// Convert 4D View styles to SpreadJS styles
// "style": {
//    "locked": false,
//    "visible": true,
//    "showGrid": true,
//    "spellCheck": false,
//    "pictHeights": false,
//    "inputFilter": 0,
//    "backColorEven": 16777215,
//    "backColorOdd": 16777215,
//    "fontID": 3,
//    "fontSize": 12,
//    "bold": false,
//    "italic": false,
//    "underline": false,
//    "outline": false,
//    "shadow": false,
//    "condensed": false,
//    "extended": false,
//    "normalColorEven": 0,
//    "normalColorOdd": 0,
//    "zeroColorEven": 255,
//    "zeroColorOdd": 255,
//    "minusColorEven": 16711680,
//    "minusColorOdd": 16711680,
//    "hAlign": 0,
//    "vAlign": 2,
//    "rotation": 0,
//    "wordWrap": false,
//    "forceTextFormat": false,
//    "numericFormat": 0,
//    "stringFormat": 0,
//    "boolFormat": 0,
//    "dateTimeFormat": 0,
//    "pictureFormat": 0
//}
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($Lon_i; $nbParameters)
C_TEXT:C284($Txt_key)
C_OBJECT:C1216($Obj_d4; $Obj_in; $Obj_out)

If (False:C215)
	C_OBJECT:C1216(convert_styleKey; $0)
	C_OBJECT:C1216(convert_styleKey; $1)
	C_OBJECT:C1216(convert_styleKey; $2)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=2; "Missing parameter"))
	
	// Required parameters
	$Obj_in:=$1
	
	// Optional parameters
	If ($nbParameters>=2)
		
		$Obj_d4:=$2
		
	End if 
	
	$Txt_key:=$Obj_in.key
	
	$Obj_out:=New object:C1471(\
		"value"; New object:C1471)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//________________________________________
	: ($Txt_key="outline")\
		 | ($Txt_key="shadow")\
		 | ($Txt_key="condensed")\
		 | ($Txt_key="extended")
		
		// Obsolete
		
		//________________________________________
	: ($Txt_key="showGrid")\
		 | ($Txt_key="spellCheck")\
		 | ($Txt_key="pictHeights")\
		 | ($Txt_key="inputFilter")\
		 | ($Txt_key="stringFormat")\
		 | ($Txt_key="boolFormat")\
		 | ($Txt_key="pictureFormat")
		
		//#TO_DO ??
		//________________________________________
	: ($Txt_key="rotation")
		
		// Default is False
		Case of 
			: (($Obj_in.value=0) | ($Obj_in.value=2))
				$Obj_out.type:="textOrientation"
				$Obj_out.value:=0
				
			: ($Obj_in.value=1)
				$Obj_out.type:="textOrientation"
				$Obj_out.value:=-90
				
			: ($Obj_in.value=3)
				$Obj_out.type:="textOrientation"
				$Obj_out.value:=90
				
		End case 
		
		//________________________________________
	: ($Txt_key="locked")
		
		// Default is False
		If ($Obj_in.value)
			
			$Obj_out.type:=$Txt_key
			$Obj_out.value:=$Obj_in.value
			
		End if 
		
		//________________________________________
	: ($Txt_key="visible")
		
		// no visible attribute in ssjson
		// Default is True
		//If (Not($Obj_in.value))
		//$Obj_out.type:=$Txt_key
		//$Obj_out.value:=$Obj_in.value
		//End if 
		
		//________________________________________
	: ($Txt_key="baseStyle")  // Stylesheet
		
		$Obj_out.type:="_styleSheet"
		
		// Store the id, the name will be retrieved later
		$Obj_out.value:=$Obj_in.value
		
		//________________________________________
	: ($Txt_key="bold")
		
		// Default is false
		If ($Obj_in.value)
			
			$Obj_out.type:="_bold"
			$Obj_out.value:=$Obj_in.value
			
		End if 
		
		//________________________________________
	: ($Txt_key="italic")
		
		// Default is false
		If ($Obj_in.value)
			
			$Obj_out.type:="_italic"
			$Obj_out.value:=$Obj_in.value
			
		End if 
		
		//________________________________________
	: ($Txt_key="fontSize")
		
		$Obj_out.type:="_size"
		$Obj_out.value:=String:C10($Obj_in.value)+"pt"  // "px"
		
		//________________________________________
	: ($Txt_key="fontID")
		
		$Obj_out.type:="_font"
		
		// Find the correspondent font name
		For ($Lon_i; 0; $Obj_d4.fontNames.length-1; 1)
			
			If ($Obj_d4.fontNames[$Lon_i].id=$Obj_in.value)
				
				$Obj_out.value:=$Obj_d4.fontNames[$Lon_i].name
				$Lon_i:=$Obj_d4.fontNames.length
				
			End if 
		End for 
		
		//________________________________________
	: ($Txt_key="forceTextFormat")
		
		If ($Obj_in.value)
			
			$Obj_out.type:="formatter"
			$Obj_out.value:="@"
			
		End if 
		
		//________________________________________
	: (($Txt_key="backColorEven")\
		 | ($Txt_key="backColorOdd"))
		
		If ($Obj_in.source="cell")\
			 | ($Obj_in.source="range")
			
			//If ($Obj_in.value#0x00FFFFFF)  // Default is white
			
			$Obj_out.type:="_"+$Txt_key
			$Obj_out.value:=$Obj_in.value
			
			//End if 
			
		Else 
			
			If ($Obj_in.value#0x00FFFFFF)  // Default is white
				
				$Obj_out.type:="backColor"
				$Obj_out.value:=convert_color($Obj_in.value; False:C215)
				
			End if 
		End if 
		
		//________________________________________
	: (($Txt_key="normalColorEven")\
		 | ($Txt_key="normalColorOdd")\
		 | ($Txt_key="zeroColorOdd")\
		 | ($Txt_key="zeroColorEven")\
		 | ($Txt_key="minusColorOdd")\
		 | ($Txt_key="minusColorEven"))
		
		// For the cells must be compared to default style or the associated stylesheet
		If ($Obj_in.source="cell")\
			 | ($Obj_in.source="range")
			
			$Obj_out.type:="_"+$Txt_key
			$Obj_out.value:=$Obj_in.value
			
		Else 
			
			$Obj_out.type:="foreColor"
			$Obj_out.value:=convert_color($Obj_in.value; False:C215)
			
		End if 
		
		//________________________________________
	: ($Txt_key="hAlign")
		
		// Indicates the horizontal alignment. left:0, center:1, right:2, general:3.
		
		$Obj_out.type:=$Txt_key
		
		Case of 
				
				//…………………………………………………………………
			: ($Obj_in.source="headers")
				
				// Always center
				$Obj_out.value:=1
				
				//…………………………………………………………………
			: ($Obj_in.source="cell")
				
				$Obj_out.value:=Choose:C955($Obj_in.value=0; 3; $Obj_in.value-1)
				
				//…………………………………………………………………
			Else 
				
				$Obj_out.value:=Choose:C955($Obj_in.value=0; 3; $Obj_in.value-1)
				
				//…………………………………………………………………
		End case 
		
		//________________________________________
	: ($Txt_key="vAlign")
		
		// Indicates the vertical alignment. top:0, center:1, bottom:2.
		
		$Obj_out.type:=$Txt_key
		
		Case of 
				
				//…………………………………………………………………
			: ($Obj_in.source="cell")
				
				// Default is bottom
				$Obj_out.value:=Choose:C955($Obj_in.value=0; 2; $Obj_in.value-1)
				
				//…………………………………………………………………
			: ($Obj_in.source="headers")
				
				// Always center
				$Obj_out.value:=1
				
				//…………………………………………………………………
			Else 
				
				$Obj_out.value:=Choose:C955($Obj_in.value=0; 0; $Obj_in.value-1)
				
				//…………………………………………………………………
		End case 
		
		//________________________________________
	: ($Txt_key="wordWrap")
		
		Case of 
				
				//…………………………………………………………………
			: ($Obj_in.source="cell") & False:C215
				
				// Default is False
				$Obj_out.type:=$Txt_key
				$Obj_out.value:=True:C214
				
				//…………………………………………………………………
			Else 
				
				// Default is False
				If ($Obj_in.value)
					
					$Obj_out.type:=$Txt_key
					$Obj_out.value:=$Obj_in.value
					
				End if 
				
				//…………………………………………………………………
		End case 
		
		//________________________________________
	: ($Txt_key="underline")
		
		// Default is False
		If ($Obj_in.value)
			
			$Obj_out.type:="textDecoration"
			$Obj_out.value:=Num:C11($Obj_in.value)
			
		End if 
		
		//________________________________________
	: ($Txt_key="numericFormat")
		
		$Obj_out.type:="formatter"
		$Obj_out.value:=convert_numericFormat($Obj_in.value; $Obj_d4.customFormats)
		
		//________________________________________
	: ($Txt_key="dateTimeFormat")
		
		
		$Obj_out.type:="formatter"
		$Obj_out.value:=convert_dateTimeFormat($Obj_in.value; $Obj_d4.customFormats)
		
		
		//________________________________________
	Else 
		
		ASSERT:C1129(Structure file:C489#Structure file:C489(*); "Unknown entry point: \""+$Txt_key+"\"")
		
		//________________________________________
End case 

// ----------------------------------------------------
// Return
$0:=$Obj_out

// ----------------------------------------------------
// End