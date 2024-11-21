//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get frozen panes
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get frozen panes
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $sheetIndex : Integer) : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			return vp_runFunction($area; "get-frozen-panes"; {sheetIndex: $sheetIndex})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 