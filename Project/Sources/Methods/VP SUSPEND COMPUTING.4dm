//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SUSPEND COMPUTING
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: recompute formulas
// ----------------------------------------------------
// ----- Declarations 
#DECLARE($area : Text)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; Count parameters:C259))
		
		If (vp_isReady($area; Current method name:C684))
			vp_runCommand($area; "suspend-calculation"; Null:C1517)
		End if 
	End if 
	
	err_FINALLY
	
End if 