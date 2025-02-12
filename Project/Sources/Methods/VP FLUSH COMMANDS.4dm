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
#DECLARE($area : Text; $formula : Object)

If (Not:C34(vp_initStorage))
	return 
End if 

If (Not:C34(Check_parameters_count(1; Count parameters:C259)))
	return 
End if 

err_TRY

If (vp_isReady($area; Current method name:C684))
	
	If ($formula=Null:C1517)
		
		vp_FLUSH($area)
		
	Else 
		
		If (OB Instance of:C1731($formula; 4D:C1709.Function))
			$formula:={formula: $formula}
		End if 
		
		var $callback:=vp_newCallback("asyncflush"; $area; $formula)
		
		vp_runFunction($area; "asyncflush"; $callback)  // will vp_FLUSH
		
	End if 
	
	
End if 

err_FINALLY
