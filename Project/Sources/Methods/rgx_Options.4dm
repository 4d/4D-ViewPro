//%attributes = {"invisible":true}
/*
Pattern := ***rgx_Options*** ( Options )
 -> Options (Long Integer)
 <- Pattern (Text)
-
*/
  // ----------------------------------------------------
  // Method : rgx_Options
  // Created 28/09/07 by Vincent
  // ----------------------------------------------------
  // Description
  //
  // ----------------------------------------------------
#DECLARE($Lon_Options : Integer) : Text
var $Txt_Pattern : Text


If ($Lon_Options ?? 0)\
 | ($Lon_Options ?? 1)\
 | ($Lon_Options ?? 2)\
 | ($Lon_Options ?? 3)
	
	$Txt_Pattern:="(?"
	$Txt_Pattern:=$Txt_Pattern+("i"*Num:C11($Lon_Options ?? 0))
	$Txt_Pattern:=$Txt_Pattern+("m"*Num:C11($Lon_Options ?? 1))
	$Txt_Pattern:=$Txt_Pattern+("s"*Num:C11($Lon_Options ?? 2))
	$Txt_Pattern:=$Txt_Pattern+("x"*Num:C11($Lon_Options ?? 3))
	$Txt_Pattern:=$Txt_Pattern+")"
	
End if 

$0:=$Txt_Pattern