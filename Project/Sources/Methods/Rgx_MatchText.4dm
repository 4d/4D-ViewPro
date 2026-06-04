//%attributes = {"invisible":true}
/*
Long Integer := ***Rgx_MatchText*** ( Param_1 ; Target ; Array ; Options )
 -> Param_1 (Text)
 -> Target (Text)
 -> Array (Pointer)
 -> Options (Long Integer)
-
*/
  // ----------------------------------------------------
  // Method : Rgx_MatchText
  // Created 28/09/07 by Vincent
  // ----------------------------------------------------
  // Description
  // Alias "QF_REMatchText"
  // ----------------------------------------------------
  // Paramètres
  // $1 = Regular expression
  // $2 = Target text
  // $3 = {Array of matches (Pointer)}
  // $4 = {Regular expression flags}
  // $0 = Error result
  // ----------------------------------------------------
var $0 : Integer
var $1 : Text
var $2 : Text
var $3 : Pointer
var $4 : Integer
var $Boo_OK : Boolean
var $Lon_i : Integer
var $Lon_Options : Integer
var $nbParameters : Integer
var $Lon_Size : Integer
var $Lon_Start : Integer
var $Ptr_Array : Pointer
var $Txt_Buffer : Text
var $Txt_Error_Method : Text
var $Txt_Pattern : Text
var $Txt_Target : Text
ARRAY LONGINT:C221($tLon_Lengths;0)
ARRAY LONGINT:C221($tLon_Positions;0)

If (False:C215)
	C_LONGINT:C283(Rgx_MatchText ;$0)
	C_TEXT:C284(Rgx_MatchText ;$1)
	C_TEXT:C284(Rgx_MatchText ;$2)
	C_POINTER:C301(Rgx_MatchText ;$3)
	C_LONGINT:C283(Rgx_MatchText ;$4)
End if 

$nbParameters:=Count parameters:C259

If ($nbParameters<2)
	
	rgx_Lon_Error:=-50  //Parameter error
	
Else 
	
	rgx_Lon_Error:=-1
	
	If ($nbParameters>=3)
		$Ptr_Array:=$3
		If ($nbParameters>=4)
			$Lon_Options:=$4
		End if 
	End if 
	
	$Txt_Pattern:=rgx_Options ($Lon_Options)+$1
	$Txt_Target:=$2
	
	If (Not:C34(Is nil pointer:C315($Ptr_Array)))
		
		CLEAR VARIABLE:C89($Ptr_Array->)
		
	End if 
	
	$Txt_Error_Method:=Method called on error:C704
	ON ERR CALL:C155("rgx_NO_ERROR")
	
	$Lon_Start:=1
	
	Repeat 
		
		$Boo_OK:=Match regex:C1019($Txt_Pattern;$Txt_Target;$Lon_Start;$tLon_Positions;$tLon_Lengths)
		
		If ($Boo_OK)
			
			rgx_Lon_Error:=0
			
			$Lon_Size:=Size of array:C274($tLon_Positions)
			
			For ($Lon_i;0;$Lon_Size;1)
				
				$Txt_Buffer:=Substring:C12($Txt_Target;$tLon_Positions{$Lon_i};$tLon_Lengths{$Lon_i})
				
				If ($tLon_Lengths{$Lon_i}=0)
					
					$Boo_OK:=($Lon_i>0)
					
					If ($Boo_OK)
						
						$Boo_OK:=($tLon_Positions{$Lon_i}#$tLon_Positions{$Lon_i-1})
						
					End if 
					
				End if 
				
				If ($Boo_OK)
					
					If (Not:C34(Is nil pointer:C315($Ptr_Array)))
						
						If ($Lon_i=0)
							
							$Ptr_Array->{0}:=$Txt_Buffer
							
						Else 
							
							APPEND TO ARRAY:C911($Ptr_Array->;$Txt_Buffer)
							
						End if 
						
					End if 
					
					If ($tLon_Positions{$Lon_i}>0)
						$Lon_Start:=$tLon_Positions{$Lon_i}+$tLon_Lengths{$Lon_i}
					End if 
					
				Else 
					
					$Lon_i:=$Lon_Size+1
					
				End if 
				
			End for 
			
			$Boo_OK:=False:C215
			
		End if 
		
	Until (Not:C34($Boo_OK))
	
	ON ERR CALL:C155($Txt_Error_Method)
End if 

$0:=rgx_Lon_Error

rgx_Lon_Error:=0