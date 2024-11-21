//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : VP PASTE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: recompute formulas
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $toPaste : Object; $pasteOption : Integer)

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(2; Count parameters:C259))
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "paste-data"; {text: $toPaste.text; html: $toPaste.html; pasteOption: $pasteOption})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
