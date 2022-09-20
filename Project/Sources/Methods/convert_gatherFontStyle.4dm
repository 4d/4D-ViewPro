//%attributes = {"invisible":true}
/*
gatherFont := ***convert_gatherFontStyles*** ( targetFont ; srcFont )
» targetFont (Text)
» srcFont (Text)
<- gatherFont (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : gatherFontStyleDefinition
// Database: Convert4DView
// ID[6E31452F798B4574A5DCCBE761157117]
// Created #28-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_i; $nbParameters)
C_TEXT:C284($Txt_gatherFont; $Txt_pattern; $Txt_srcFont; $Txt_targetFont)

If (False:C215)
	C_TEXT:C284(convert_gatherFontStyle; $0)
	C_TEXT:C284(convert_gatherFontStyle; $1)
	C_TEXT:C284(convert_gatherFontStyle; $2)
End if 

ARRAY TEXT:C222($tTxt_default; 0x0000; 0x0000)
ARRAY TEXT:C222($tTxt_current; 0x0000; 0x0000)

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=2; "Missing parameter"))
	
	// Required parameters
	$Txt_targetFont:=$1
	$Txt_srcFont:=$2
	
	// Optional parameters
	If ($nbParameters>=3)
		
		// <NONE>
		
	End if 
	
	//$Txt_pattern:="(?-msi)^(bold)*\\s?(italic)*\\s?(\\d+pt)*\\s?([^$]*)$"
	$Txt_pattern:="(?m-si)^(italic)*\\s?(bold)*\\s?(\\d+pt)*\\s?([^$]*)$"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Rgx_ExtractText($Txt_pattern; $Txt_srcFont; "1 2 3 4"; ->$tTxt_default)=0)
	
	If (Size of array:C274($tTxt_default{1})>=4)
		
		If (Length:C16($Txt_targetFont)#0)
			
			If (Rgx_ExtractText($Txt_pattern; $Txt_targetFont; "1 2 3 4"; ->$tTxt_current)=0)
				
				If (Size of array:C274($tTxt_current{1})>=4)
					
					If (Length:C16($tTxt_default{1}{1})>0)\
						 & (Length:C16($tTxt_current{1}{1})=0)  // Bold
						
						$tTxt_current{1}{1}:=$tTxt_default{1}{1}
						
					End if 
					
					If (Length:C16($tTxt_default{1}{2})>0)\
						 & (Length:C16($tTxt_current{1}{2})=0)  // Italic
						
						$tTxt_current{1}{2}:=$tTxt_default{1}{2}
						
					End if 
					
					If (Length:C16($tTxt_default{1}{3})>0)\
						 & (Length:C16($tTxt_current{1}{3})=0)  // Font size
						
						$tTxt_current{1}{3}:=$tTxt_default{1}{3}
						
					End if 
					
					If (Length:C16($tTxt_default{1}{4})>0)\
						 & (Length:C16($tTxt_current{1}{4})=0)  // Font name
						
						$tTxt_current{1}{4}:=$tTxt_default{1}{4}
						
					End if 
					
					For ($Lon_i; 1; Size of array:C274($tTxt_current{1}); 1)
						
						If (Length:C16($tTxt_current{1}{$Lon_i})#0)
							
							$Txt_gatherFont:=$Txt_gatherFont+(" "*Num:C11(Length:C16($Txt_gatherFont)>0))+$tTxt_current{1}{$Lon_i}
							
						End if 
					End for 
				End if 
			End if 
		End if 
	End if 
End if 

If (Length:C16($Txt_gatherFont)=0)
	
	$Txt_gatherFont:=$Txt_targetFont
	
End if 

// ----------------------------------------------------
// Return
$0:=$Txt_gatherFont

// ----------------------------------------------------
// End