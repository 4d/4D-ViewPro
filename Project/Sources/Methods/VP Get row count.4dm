//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get row count
// Database: 4D ViewPro
// ID[5101BAB9E3104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get sheet row count
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $sheetIndex : Integer)->$result : Integer

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $Obj_result:=vp_runFunction($area; "get-row-count"; {sheetIndex: $sheetIndex})
			$result:=$Obj_result.result
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
