//%attributes = {"invisible":true}
/*
Long Integer := ***Rgx_SplitText*** ( Param_1 ; Target ; Param_3 ; Options )
 -> Param_1 (Text)
 -> Target (Text)
 -> Param_3 (Pointer)
 -> Options (Long Integer)
-
Splits the target into segments separated by matches of the specified regular expression.
If grouping parentheses are used in the pattern, then the text of all matched groups in the pattern are also added to the segment list.
Parameter patternText is the regular expression to be matched.
Parameter targetText is the target text variable.
Split segments are returned in the splitSegments array.
Parameter regexFlags specifies a set of flags that control the matching operation.
Use the regex options constants by combining them with bitwise "or".
*/
  // ----------------------------------------------------
  // Method : Rgx_SplitText
  // Created 27/09/07 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description
  // Alias "QF_SplitText"
  // ----------------------------------------------------
  // Paramètres
  // $1 = Regular expression
  // $2 = Target text
  // $3 = Array of text segments
  // $4 = Regular expression flags
  // $0 = Error result
  // ----------------------------------------------------
var $0 : Integer
var $1 : Text
var $2 : Text
var $3 : Pointer
var $4 : Integer
var $Boo_OK : Boolean
var $Lon_Error : Integer
var $Lon_i : Integer
var $Lon_Options : Integer
var $nbParameters : Integer
var $Lon_Start : Integer
var $Txt_Buffer : Text
var $Txt_Error_Method : Text
var $Txt_Pattern : Text
var $Txt_Target : Text
ARRAY LONGINT:C221($tLon_Lengths;0)
ARRAY LONGINT:C221($tLon_Positions;0)

If (False:C215)
	C_LONGINT:C283(Rgx_SplitText ;$0)
	C_TEXT:C284(Rgx_SplitText ;$1)
	C_TEXT:C284(Rgx_SplitText ;$2)
	C_POINTER:C301(Rgx_SplitText ;$3)
	C_LONGINT:C283(Rgx_SplitText ;$4)
End if 

var rgx_Lon_Error : Integer
$nbParameters:=Count parameters:C259

If ($nbParameters<3)
	
	rgx_Lon_Error:=-50  //Parameter error
	
Else 
	
	If ($nbParameters>=4)
		
		$Lon_Options:=$4
		
	End if 
	
	$Txt_Pattern:=rgx_Options ($Lon_Options)+$1
	$Txt_Target:=$2
	
	CLEAR VARIABLE:C89($3->)
	
	$Txt_Error_Method:=Method called on error:C704
	ON ERR CALL:C155("rgx_NO_ERROR")
	
	$Lon_Start:=1
	
	Repeat 
		
		$Boo_OK:=Match regex:C1019($Txt_Pattern;$Txt_Target;$Lon_Start;$tLon_Positions;$tLon_Lengths)
		  // & (Size of array($tLon_Positions)>0)
		
		If ($Boo_OK)
			
			If (Size of array:C274($tLon_Positions)>0)
				
				For ($Lon_i;0;Size of array:C274($tLon_Positions);1)
					
					If ($Lon_i=0)
						
						  //zz
						$Txt_Buffer:=Substring:C12($Txt_Target;$Lon_Start;$tLon_Positions{$Lon_i}-$Lon_Start)
						
					Else 
						
						  //xx
						$Txt_Buffer:=Substring:C12($Txt_Target;$tLon_Positions{$Lon_i-1};$tLon_Positions{$Lon_i}-1)
						
					End if 
					
					If ($Lon_Options ?? 11)\
						 & (Length:C16($Txt_Buffer)>0)  //Trim unnecessary whitespace or tab from the start and the end of a string.
						
						$Lon_Error:=Rgx_SubstituteText ("^\\s*";"";->$Txt_Buffer)
						$Lon_Error:=Rgx_SubstituteText ("\\s*$";"";->$Txt_Buffer)
						
					End if 
					
					Case of 
							
							  //______________________________________________________
						: (Length:C16($Txt_Buffer)=0)\
							 & ($Lon_Options ?? 10)  //Skeep empty lines
							
							  //______________________________________________________
						Else 
							
							APPEND TO ARRAY:C911($3->;$Txt_Buffer)
							
							  //______________________________________________________
					End case 
					
					If ($tLon_Positions{$Lon_i}>0)
						
						$Lon_Start:=$tLon_Positions{$Lon_i}+$tLon_Lengths{$Lon_i}
						
					End if 
				End for 
				
			Else 
				
				$Boo_OK:=False:C215
				
			End if 
		Else 
			
			$Txt_Buffer:=Substring:C12($Txt_Target;$Lon_Start)
			
			If ($Lon_Options ?? 11)  //Trim unnecessary whitespace or tab from the start and the end of a string.
				
				$Lon_Error:=Rgx_SubstituteText ("^\\s*";"";->$Txt_Buffer)
				$Lon_Error:=Rgx_SubstituteText ("\\s*$";"";->$Txt_Buffer)
				
			End if 
			
			Case of 
					
					  //______________________________________________________
				: (Length:C16($Txt_Buffer)=0)\
					 & ($Lon_Options ?? 10)  //Skeep empty lines
					
					  //______________________________________________________
				Else 
					
					APPEND TO ARRAY:C911($3->;$Txt_Buffer)
					
					  //______________________________________________________
			End case 
		End if 
	Until (Not:C34($Boo_OK))
	
	ON ERR CALL:C155($Txt_Error_Method)
	
End if 

$0:=rgx_Lon_Error

rgx_Lon_Error:=0