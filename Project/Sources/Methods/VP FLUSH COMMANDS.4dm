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
#DECLARE($area : Text; $options : Integer)

If (Not:C34(vp_initStorage))
	return 
End if 

If (Not:C34(Check_parameters_count(1; Count parameters:C259)))
	return 
End if 

err_TRY

If (vp_isReady($area; Current method name:C684))
	
	vp_FLUSH($area; $options=vk flush wait asynchronous calls:K89:160)
	
End if 

err_FINALLY
