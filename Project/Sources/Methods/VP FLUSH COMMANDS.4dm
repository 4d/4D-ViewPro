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
#DECLARE($area : Text)

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(1; Count parameters:C259))
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_FLUSH($area)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 