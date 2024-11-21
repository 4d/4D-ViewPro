//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : VP Copy
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: copy
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text) : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			return vp_runFunction($area; "copy-data"; Null:C1517)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 