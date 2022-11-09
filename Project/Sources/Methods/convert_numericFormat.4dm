//%attributes = {"invisible":true}
/*
format := ***convert_numericFormat*** ( formatID ; customFormats )
 -> formatID (Long Integer)
 -> customFormats (Collection)
 <- format (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_numericFormat
// Database: Convert4DView
// ID[BC7A400F90ED4BC0A62ACBC056CF193B]
// Created #27-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 10:59:07
// ----------------------------------------------------
// Description:
// The cell uses the number display format whose number is passed in the value
// parameter. Associated values: display format numbers.
//
// Note: Default display format numbers correspond to their position in the menu
// used for selecting formats in the cell Format dialog box.
//
// 01 - ###0
// 02 - #####0
// 03 - ###,##0.00
// 04 - $ ###,##0.00
// 05 - $ ###,###,##0.00
// 06 - ###,###,##0
// 07 - ##0.00 %
// 08 - 0000
// 09 - 00000000
// 10 - 00 00 00 00
// 11 - ###,##0;(###,##0)
// 12 - $ ###,##0.00;$ (###,##0.00)
// 13 - ^^^,^^0.00
// 14 - $ ^^^,^^0.00
// 15 - ^^^^^^^0
// 16 - ^^^,^^0
// 17 - Positive;Negative;Zero
// 18 - ##_##_##_##
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_COLLECTION:C1488($2)

C_LONGINT:C283($Lon_formatID; $Lon_i; $nbParameters)
C_TEXT:C284($Txt_char; $Txt_currency; $Txt_decimal; $Txt_format; $Txt_thousand)
C_COLLECTION:C1488($Col_customFormats)

If (False:C215)
	C_TEXT:C284(convert_numericFormat; $0)
	C_LONGINT:C283(convert_numericFormat; $1)
	C_COLLECTION:C1488(convert_numericFormat; $2)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Lon_formatID:=$1
	
	// Optional parameters
	If ($nbParameters>=2)
		
		$Col_customFormats:=$2
		
	End if 
	
	GET SYSTEM FORMAT:C994(Currency symbol:K60:3; $Txt_currency)
	GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $Txt_decimal)
	GET SYSTEM FORMAT:C994(Thousand separator:K60:2; $Txt_thousand)
	
	$Txt_char:=Char:C90(NBSP ASCII CODE:K15:43)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formatID=0)
		
		$Txt_format:="General"  // Default
		
		//______________________________________________________
	: ($Lon_formatID<=18)  // View formats
		
		If ($Lon_formatID=0)
			$Txt_format:=""
		Else 
			$Txt_format:=Get localized string:C991("FORMAT_4DVIEW_NUMERIC_"+String:C10($Lon_formatID))
		End if 
		//ARRAY TEXT($tTxt_formats;18)
		//$tTxt_formats{0}:="General"
		//$tTxt_formats{1}:="###0"
		//$tTxt_formats{2}:="#####0"
		//$tTxt_formats{3}:="###"+$Txt_thousand+"##0"+$Txt_decimal+"00"
		//$tTxt_formats{4}:=$Txt_currency+" ###"+$Txt_thousand+"##0"+$Txt_decimal+"00"
		//$tTxt_formats{5}:=$Txt_currency+" ######"+$Txt_thousand+"##0"+$Txt_decimal+"00"
		//$tTxt_formats{6}:="###"+$Txt_thousand+"###"+$Txt_thousand+"##0"
		
		//  //#97698 - Checked with FM [
		//  //$tTxt_formats{7}:="###"+$Txt_thousand+"##0"+$Txt_decimal+"00 '%"
		//$tTxt_formats{7}:="###"+$Txt_thousand+"##0"+$Txt_decimal+"00 \"%\""
		//  //]
		
		//$tTxt_formats{8}:="0000"
		//$tTxt_formats{9}:="00000000"
		//$tTxt_formats{10}:="00 00 00 00"
		//$tTxt_formats{11}:="###"+$Txt_thousand+"##0;(###"+$Txt_thousand+"##0)"
		//$tTxt_formats{12}:=$Txt_currency+" ###"+$Txt_thousand+"##0"+$Txt_decimal+"00;"+$Txt_currency+" (###"+$Txt_thousand+"##0"+$Txt_decimal+"00)"
		
		//  //#ACI0098085- Checked with FM [
		//  //$tTxt_formats{13}:=Replace string("^^^"+$Txt_thousand+"^^0"+$Txt_decimal+"00";"^";$Txt_char)
		//  //$tTxt_formats{14}:=Replace string($Txt_currency+" ^^^"+$Txt_thousand+"^^0"+$Txt_decimal+"00";"^";$Txt_char)
		//  //$tTxt_formats{15}:=Replace string("^^^^^^^0";"^";$Txt_char)
		//  //$tTxt_formats{16}:=Replace string("^^^"+$Txt_thousand+"^^0";"^";$Txt_char)
		//$tTxt_formats{13}:="???"+$Txt_thousand+"??0"+$Txt_decimal+"00"
		//$tTxt_formats{14}:=$Txt_currency+" ???"+$Txt_thousand+"??0"+$Txt_decimal+"00"
		//$tTxt_formats{15}:="???????0"
		//$tTxt_formats{16}:="???"+$Txt_thousand+"??0"
		//  //]
		
		//$tTxt_formats{17}:="General"  // "Positive;Negative;Zero"
		//$tTxt_formats{18}:="##\\_##\\_##\\_##"
		
		//$Txt_format:=$tTxt_formats{$Lon_formatID}
		
		//______________________________________________________
	Else   // Custom formats
		
		For ($Lon_i; 0; $Col_customFormats.length-1; 1)
			
			If ($Col_customFormats[$Lon_i].id=$Lon_formatID)
				
				// #29-1-2018 - Checked with Hamza - In some cases (how?) the format can be empty
				If (Length:C16(String:C10($Col_customFormats[$Lon_i].format))>0)
					
					If (String:C10($Col_customFormats[$Lon_i].format)[[1]]#"|")
						
						$Txt_format:=$Col_customFormats[$Lon_i].format
						
						C_BOOLEAN:C305($found)
						C_LONGINT:C283($len; $pos; $start)
						$start:=1
						
						$Txt_format:=Replace string:C233($Txt_format; "#"+$Txt_thousand+"#"; "%_TS#_%")
						$Txt_format:=Replace string:C233($Txt_format; "^"+$Txt_thousand+"^"; "%_TS^_%")
						$Txt_format:=Replace string:C233($Txt_format; $Txt_decimal; "%_DS_%")
						
						$Txt_format:=Replace string:C233($Txt_format; "%_TS#_%"; "#,#")
						$Txt_format:=Replace string:C233($Txt_format; "%_TS^_%"; "^,^")
						$Txt_format:=Replace string:C233($Txt_format; "%_DS_%"; ".")
						
						Repeat 
							$found:=Match regex:C1019("(?m-si)([^\\d\\s#_^,;().]+)"; $Txt_format; $start; $pos; $len)
							If ($found)
								$Txt_format:=Insert string:C231($Txt_format; "\""; $pos)
								$Txt_format:=Insert string:C231($Txt_format; "\""; $pos+1+$len)
								$start:=$pos+1+$len+1
							End if 
						Until ($found=False:C215)
						
						// Escape % symbol
						//#97698 - Checked with FM [
						//$Txt_format:=Replace string($Txt_format;"%";"'%")
						//$Txt_format:=Replace string($Txt_format;"%";"\"%\"")
						//]
						
						$Txt_format:=Replace string:C233($Txt_format; "_"; "\\_")
						
						//#97723 - Checked with FM [
						$Txt_format:=Replace string:C233($Txt_format; "^"; "?")
						//]
						
						$Txt_format:=Replace string:C233($Txt_format; ".#"; ".0")
						
					Else 
						
						//#TO_DO - Reference à un style de la base
						// Note: by language uniquely
						
					End if 
				End if 
				
				$Lon_i:=$Col_customFormats.length  // Break
				
			End if 
		End for 
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
$0:=$Txt_format

// ----------------------------------------------------
// End