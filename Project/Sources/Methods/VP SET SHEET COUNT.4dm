//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET SHEET COUNT
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the number of sheets
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $count : Integer)

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(2; Count parameters:C259))
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "set-sheet-count"; {count: $count})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 