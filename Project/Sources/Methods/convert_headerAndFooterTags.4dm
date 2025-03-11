//%attributes = {"invisible":true}
/*
out := ***convert_headerAndFooterTags*** ( in )
 -> in (Text)
 <- out (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_headerAndFooterTags
// Database: Convert4DView
// ID[2957A02FDA8046948DA014117EEB6140]
// Created #2-10-2017 by Vincent de Lachaux
// ----------------------------------------------------
// http://help.grapecity.com/spread/SpreadSheets10/webframe.html#printsheet.html
// ----------------------------------------------------
// Description:
// P: current page number.
// N: total page count.
// D: current date (today).
// T: current time.
// G: image, related url is set with corresponding ***Image.
// S: strikethrough.
// U: underline.
// B: bold.
// I: italic.
// ": (double quote), used to set font-family.
// F: spread name.
// A: sheet name.
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($Txt_in; $Txt_out)

If (False:C215)
	C_TEXT:C284(convert_headerAndFooterTags; $0)
	C_TEXT:C284(convert_headerAndFooterTags; $1)
End if 

// ----------------------------------------------------
// Initialisations

// Required parameters
$Txt_in:=$1

// ----------------------------------------------------
//
//#d Current date abbreviatedWed, Apr 3, 1996
//#∂ (Macintosh)Current date in short form, 04/03/1996
//#c (Windows)Forced special, 04/03/1996
//#D Current date in long form, Wednesday, April 3, 1996
$Txt_out:=Replace string:C233($Txt_in; "#d"; "&D"; *)
$Txt_out:=Replace string:C233($Txt_out; "#∂"; "&D"; *)
$Txt_out:=Replace string:C233($Txt_out; "#c"; "&D"; *)
$Txt_out:=Replace string:C233($Txt_out; "#D"; "&D"; *)

//#p Page number
$Txt_out:=Replace string:C233($Txt_out; "#p"; "&P"; *)

//#P Total page number
$Txt_out:=Replace string:C233($Txt_out; "#P"; "&N"; *)

//#h Time without seconds, 09:42
//#H Time with seconds, 09:42:47
$Txt_out:=Replace string:C233($Txt_out; "#h"; "&T"; *)
$Txt_out:=Replace string:C233($Txt_out; "#H"; "&T"; *)

//#F Table or area nameForecast (SP) or _Forecast
$Txt_out:=Replace string:C233($Txt_out; "#F"; "&F"; *)

// ----------------------------------------------------
// Return
$0:=$Txt_out

// ----------------------------------------------------
// End