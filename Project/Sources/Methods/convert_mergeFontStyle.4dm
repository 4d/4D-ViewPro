//%attributes = {"invisible":true}
/*
gatherFont := ***mergeFontStyleDefinition*** ( targetFont ; srcFont )
» targetFont (Text)
» srcFont (Text)
<- gatherFont (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : mergeFontStyleDefinition
// Database: Convert4DView
// ID[2C4FC489790B4757B28C229B23C58084]
// Created #28-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_i)
C_TEXT:C284($Txt_gatherFont; $Txt_pattern; $Txt_srcFont; $Txt_targetFont)

If (False:C215)
	C_TEXT:C284(convert_mergeFontStyle; $0)
	C_TEXT:C284(convert_mergeFontStyle; $1)
	C_TEXT:C284(convert_mergeFontStyle; $2)
End if 

ARRAY TEXT:C222($tTxt_default; 0x0000; 0x0000)
ARRAY TEXT:C222($tTxt_current; 0x0000; 0x0000)

// ----------------------------------------------------
// Initialisations

// Required parameters
$Txt_targetFont:=$1
$Txt_srcFont:=$2


$Txt_pattern:="(?m-si)^(italic)*\\s?(bold)*\\s?(\\d+pt)*\\s?([^$]*)$"


// ----------------------------------------------------
If (Rgx_ExtractText($Txt_pattern; $Txt_srcFont; "1 2 3 4"; ->$tTxt_default)=0)
	
	If (Size of array:C274($tTxt_default{1})>=4)
		
		If (Rgx_ExtractText($Txt_pattern; $Txt_targetFont; "1 2 3 4"; ->$tTxt_current)=0)
			
			If (Size of array:C274($tTxt_current{1})>=4)
				
				If (Length:C16($tTxt_default{1}{1})>0)
					
					$tTxt_current{1}{1}:=$tTxt_default{1}{1}
					
				End if 
				
				If (Length:C16($tTxt_default{1}{2})>0)  // Italic
					
					$tTxt_current{1}{2}:=$tTxt_default{1}{2}
					
				End if 
				
				If (Length:C16($tTxt_default{1}{3})#0)  // Font size
					
					$tTxt_current{1}{3}:=$tTxt_default{1}{3}
					
				End if 
				
				If (Length:C16($tTxt_default{1}{4})>0)  // Font name
					
					$tTxt_current{1}{4}:=$tTxt_default{1}{4}
					
				End if 
				
				$Txt_gatherFont:=""
				
				For ($Lon_i; 1; Size of array:C274($tTxt_current{1}); 1)
					
					$Txt_gatherFont:=$Txt_gatherFont+(" "*Num:C11(Length:C16($Txt_gatherFont)>0))+$tTxt_current{1}{$Lon_i}
					
				End for 
				
				//$Obj_dataTable[$Txt_row][$Txt_column].style.font:=$Txt_gatherFont
				
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