//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET FROZEN PANES
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: set frozen panes
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $panes : Object; $sheetIndex : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "set-frozen-panes"; {sheetIndex: $sheetIndex; panes: $panes})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 