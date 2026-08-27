//%attributes = {"invisible":true}
/*
color := ***convert_color*** ( color )
 -> color (Long Integer)
 <- color (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_color
// Database: Convert4DView
// ID[CDF8200AC93048FAADD0EF74C7335994]
// Created #19-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Use a known color name or HEX style color value.
// The default value is black.
// ----------------------------------------------------
// Declarations
#DECLARE($Lon_color : Integer; $withName : Boolean) : Text
var $Txt_color : Text

// ----------------------------------------------------
// Initialisations

// ----------------------------------------------------
If ($withName)
	Case of 
			
		: ($Lon_color=0x0000)
			$Txt_color:="Black"
			
		: ($Lon_color=0x00FF)
			$Txt_color:="Blue"
			
		: ($Lon_color=0xFF00)
			$Txt_color:="Green"
			
		: ($Lon_color=0x00FF0000)
			$Txt_color:="Red"
			
		: ($Lon_color=0x00FFFF00)
			$Txt_color:="Yellow"
			
		: ($Lon_color=0x00FFFFFF)
			$Txt_color:="White"
			
		: ($Lon_color=0xFFFF)
			$Txt_color:="Cyan"
			
		: ($Lon_color=0x00FF00FF)
			$Txt_color:="Magenta"
			
			//……………………………………………………………………………
		Else 
			
			$Txt_color:="#"+Substring:C12(String:C10($Lon_color+0x01000000; "&x"); 5)
			
			//……………………………………………………………………………
	End case 
Else 
	
	Case of 
			
		: ($Lon_color=0x0000)
			$Txt_color:="Black"
			
		Else 
			
			$Txt_color:="#"+Substring:C12(String:C10($Lon_color+0x01000000; "&x"); 5)
			
	End case 
	
End if 

// ----------------------------------------------------
// Return
$0:=$Txt_color

// ----------------------------------------------------
// End