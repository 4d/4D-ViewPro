//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP FLUSH COMMANDS
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: plays all recorded commands
// ----------------------------------------------------
// ----- Declarations

C_TEXT:C284($1)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)

If (False:C215)
	C_TEXT:C284(VP FLUSH COMMANDS; $1)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		$area:=$1
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_flush($area)
		End if 
	End if 
	
	err_FINALLY
	
End if 