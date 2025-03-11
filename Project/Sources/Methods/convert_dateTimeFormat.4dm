//%attributes = {"invisible":true}
/*
format := ***convert_dateTimeFormat*** ( format ; customFormats )
 -> format (Long Integer)
 -> customFormats (Collection)
 <- format (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_dateTimeFormat
// Database: Convert4DView
// ID[F97FB761C2FF484A968FC210881865F0]
// Created #21-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 10:55:37
// ----------------------------------------------------
// Description:
// Convert dateTimeFormat to SpreadJS formatter
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_COLLECTION:C1488($2)

C_LONGINT:C283($Lon_format; $Lon_i)
C_TEXT:C284($Txt_dateSeparator; $Txt_dayPosition; $Txt_format; $Txt_monthPosition)
C_TEXT:C284($Txt_timeSeparator; $Txt_yearPosition)
C_COLLECTION:C1488($Col_customFormats)

If (False:C215)
	C_TEXT:C284(convert_dateTimeFormat; $0)
	C_LONGINT:C283(convert_dateTimeFormat; $1)
	C_COLLECTION:C1488(convert_dateTimeFormat; $2)
End if 

// ----------------------------------------------------
// Initialisations

// Required parameters
$Lon_format:=$1

// Optional parameters
If (Count parameters:C259>=2)
	
	$Col_customFormats:=$2
	
End if 

// Default value
GET SYSTEM FORMAT:C994(System date short pattern:K60:7; $Txt_format)


C_TEXT:C284($hours; $minutes; $seconds; $and)

$hours:=Localized string:C991("hours")
$minutes:=Localized string:C991("minutes")
$seconds:=Localized string:C991("seconds")
$and:=Localized string:C991("FORMAT_4D_VIEW_CONJONCTION_5")

// ----------------------------------------------------
Case of 
		
		//________________________________________
	: ($Lon_format=1)  // pv Short: 02/21/02
		
		GET SYSTEM FORMAT:C994(System date short pattern:K60:7; $Txt_format)
		
		If (Position:C15("yy"; $Txt_format)=0)
			
			$Txt_format:=Replace string:C233($Txt_format; "y"; "yy")
			
		End if 
		
		//________________________________________
	: ($Lon_format=2)  // pv Abbreviated: Thu 21 Feb 2002
		
		$Txt_format:="ddd d mmm yyyy"
		
		//________________________________________
	: ($Lon_format=3)  // pv Long: Thursday 21 February 2002
		
		GET SYSTEM FORMAT:C994(System date long pattern:K60:9; $Txt_format)
		
		If (Position:C15("yyyy"; $Txt_format)=0)
			
			$Txt_format:=Replace string:C233($Txt_format; "yyy"; "y")
			$Txt_format:=Replace string:C233($Txt_format; "yy"; "y")
			$Txt_format:=Replace string:C233($Txt_format; "y"; "yyyy")
			
		End if 
		
		//________________________________________
	: ($Lon_format=4)  // pv Short2: 02/21/2002
		
		GET SYSTEM FORMAT:C994(Date separator:K60:10; $Txt_dateSeparator)
		GET SYSTEM FORMAT:C994(Short date day position:K60:12; $Txt_dayPosition)
		GET SYSTEM FORMAT:C994(Short date month position:K60:13; $Txt_monthPosition)
		GET SYSTEM FORMAT:C994(Short date year position:K60:14; $Txt_yearPosition)
		
		$Txt_format:=Replace string:C233("1/2/3"; "/"; $Txt_dateSeparator)
		$Txt_format:=Replace string:C233($Txt_format; $Txt_dayPosition; "dd")
		$Txt_format:=Replace string:C233($Txt_format; $Txt_monthPosition; "mm")
		$Txt_format:=Replace string:C233($Txt_format; $Txt_yearPosition; "yyyy")
		
		//________________________________________
	: ($Lon_format=5)  // pv Month Day Year: 21 February, 2002
		
		GET SYSTEM FORMAT:C994(Short date day position:K60:12; $Txt_dayPosition)
		GET SYSTEM FORMAT:C994(Short date month position:K60:13; $Txt_monthPosition)
		
		$Txt_format:="1 2"
		$Txt_format:=Replace string:C233($Txt_format; $Txt_dayPosition; "d")
		$Txt_format:=Replace string:C233($Txt_format; $Txt_monthPosition; "mmmm")
		
		If ($Txt_monthPosition="1")
			
			$Txt_format:=$Txt_format+","
			
		End if 
		
		$Txt_format:=$Txt_format+" yyyy"
		
		//________________________________________
	: ($Lon_format=6)  // pv Abbr Month Day Year: 21 Feb, 2002
		
		GET SYSTEM FORMAT:C994(Short date day position:K60:12; $Txt_dayPosition)
		GET SYSTEM FORMAT:C994(Short date month position:K60:13; $Txt_monthPosition)
		
		$Txt_format:="1 2"
		$Txt_format:=Replace string:C233($Txt_format; $Txt_dayPosition; "d")
		$Txt_format:=Replace string:C233($Txt_format; $Txt_monthPosition; "mmm")
		
		If ($Txt_monthPosition="1")
			
			$Txt_format:=$Txt_format+","
			
		End if 
		
		$Txt_format:=$Txt_format+" yyyy"
		
		//________________________________________
	: ($Lon_format=7)  // pv Day Name: Thursday
		
		$Txt_format:="dddd"
		
		//________________________________________
	: ($Lon_format=8)  // pv Day Number: 21
		
		$Txt_format:="d"
		
		//________________________________________
	: ($Lon_format=9)  // pv Month Name: February
		
		$Txt_format:="mmmm"
		
		//________________________________________
	: ($Lon_format=10)  // pv Month Number: 2
		
		$Txt_format:="m"
		
		//________________________________________
	: ($Lon_format=11)  // pv Year Number: 2002
		
		$Txt_format:="yyyy"
		
		//________________________________________
	: ($Lon_format=12)  // pv Long H MM AM PM: Thursday 21 February 2002 at 12:30 PM
		
		GET SYSTEM FORMAT:C994(System time long pattern:K60:6; $Txt_format)
		$Txt_format:=Replace string:C233($Txt_format; "hh"; "[hh]")
		If (Position:C15("[hh]"; $Txt_format)=0)
			$Txt_format:=Replace string:C233($Txt_format; "h"; "[h]")
		End if 
		//________________________________________
	: ($Lon_format=13)  // pv Abbreviated H MM AM PM: Thu 21Feb 2002 at 12:30 PM
		
		GET SYSTEM FORMAT:C994(System time medium pattern:K60:5; $Txt_format)
		$Txt_format:=Replace string:C233($Txt_format; "hh"; "[hh]")
		If (Position:C15("[hh]"; $Txt_format)=0)
			$Txt_format:=Replace string:C233($Txt_format; "h"; "[h]")
		End if 
		
		//________________________________________
	: ($Lon_format=14)  // pv Short HH MM SS: 02/21/02 at 12:30:00
		
		GET SYSTEM FORMAT:C994(System time short pattern:K60:4; $Txt_format)
		$Txt_format:=Replace string:C233($Txt_format; "hh"; "[hh]")
		If (Position:C15("[hh]"; $Txt_format)=0)
			$Txt_format:=Replace string:C233($Txt_format; "h"; "[h]")
		End if 
		
		//________________________________________
	: ($Lon_format=15)  // pv Month Day Year H MM AM PM: 21 February, 2002 at 12:30 PM
		
		If (False:C215)
			GET SYSTEM FORMAT:C994(Short date day position:K60:12; $Txt_dayPosition)
			GET SYSTEM FORMAT:C994(Short date month position:K60:13; $Txt_monthPosition)
			GET SYSTEM FORMAT:C994(Short date year position:K60:14; $Txt_yearPosition)
			
			$Txt_format:="1 2 3 "
			$Txt_format:=Replace string:C233($Txt_format; $Txt_dayPosition; "d")
			$Txt_format:=Replace string:C233($Txt_format; $Txt_monthPosition; "mmm")
			$Txt_format:=Replace string:C233($Txt_format; $Txt_yearPosition; "yyyy")
		End if 
		
		GET SYSTEM FORMAT:C994(Time separator:K60:11; $Txt_timeSeparator)
		//GET SYSTEM FORMAT(System time AM label;$Txt_AM)
		//GET SYSTEM FORMAT(System time PM label;$Txt_PM)
		
		$Txt_format:=$Txt_format+"h"+$Txt_timeSeparator+"mm AM/PM"
		
		//________________________________________
	: ($Lon_format=16)  // pv Short2 Hour Min Sec: 21/02/2002 and 12 hours 30 minutes 0 second
		
		$Txt_format:="h:mm:ss"
		
		GET SYSTEM FORMAT:C994(Date separator:K60:10; $Txt_dateSeparator)
		GET SYSTEM FORMAT:C994(Short date day position:K60:12; $Txt_dayPosition)
		GET SYSTEM FORMAT:C994(Short date month position:K60:13; $Txt_monthPosition)
		GET SYSTEM FORMAT:C994(Short date year position:K60:14; $Txt_yearPosition)
		
		$Txt_format:=Replace string:C233("1/2/3"; "/"; $Txt_dateSeparator)
		$Txt_format:=Replace string:C233($Txt_format; $Txt_dayPosition; "d")
		$Txt_format:=Replace string:C233($Txt_format; $Txt_monthPosition; "m")
		$Txt_format:=Replace string:C233($Txt_format; $Txt_yearPosition; "yy")
		
		$Txt_format:=$Txt_format+"\""+$and+"\"h \""+$hours+"\" m \""+$minutes+"\" s \""+$seconds+"\""
		
		//________________________________________
	: ($Lon_format=17)  // pv HH MM SS: 12:30:00
		
		GET SYSTEM FORMAT:C994(Time separator:K60:11; $Txt_timeSeparator)
		
		$Txt_format:="[hh]"+$Txt_timeSeparator+"mm"+$Txt_timeSeparator+"ss"
		
		//________________________________________
	: ($Lon_format=18)  // pv HH MM: 12:30
		
		GET SYSTEM FORMAT:C994(Time separator:K60:11; $Txt_timeSeparator)
		
		$Txt_format:="[hh]"+$Txt_timeSeparator+"mm"
		
		//________________________________________
	: ($Lon_format=19)  // pv Hour Min Sec: 12 hours 30 minutes 0 second
		
		$Txt_format:="[h] \""+$hours+"\" m \""+$minutes+"\" s \""+$seconds+"\""
		
		//________________________________________
	: ($Lon_format=20)  // pv Hour Min: 12 hours 30 minutes
		
		$Txt_format:="[h] \""+$hours+"\" m \""+$minutes+"\""
		
		//________________________________________
	: ($Lon_format=21)  // pv HH MM AM PM: 12:30 PM
		
		GET SYSTEM FORMAT:C994(Time separator:K60:11; $Txt_timeSeparator)
		//GET SYSTEM FORMAT(System time AM label;$Txt_AM)
		//GET SYSTEM FORMAT(System time PM label;$Txt_PM)
		
		$Txt_format:="[h]"+$Txt_timeSeparator+"mm AM/PM"
		
		//________________________________________
	: ($Lon_format>255)  // Custom formats
		
		// Default [
		GET SYSTEM FORMAT:C994(System date short pattern:K60:7; $Txt_format)
		
		If (Position:C15("yyyy"; $Txt_format)=0)
			
			$Txt_format:=Replace string:C233($Txt_format; "yyy"; "y")
			$Txt_format:=Replace string:C233($Txt_format; "yy"; "y")
			$Txt_format:=Replace string:C233($Txt_format; "y"; "yyyy")
			
		End if 
		//]
		
		For ($Lon_i; 0; $Col_customFormats.length-1; 1)
			
			If ($Col_customFormats[$Lon_i].id=$Lon_format)
				
				$Txt_format:=$Col_customFormats[$Lon_i].format
				$Lon_i:=$Col_customFormats.length
				
			End if 
		End for 
		
		//________________________________________
End case 

If ($Lon_format<255)
	
	$Txt_format:=$Txt_format
	
End if 

// ----------------------------------------------------
// Return
$0:=$Txt_format

// ----------------------------------------------------
// End