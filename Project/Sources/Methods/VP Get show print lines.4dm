//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $sheetIndex : Integer)->$result : Boolean

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $res:=vp_runFunction($area; "get-show-print-lines"; {sheetIndex: $sheetIndex})
			$result:=$res.result
			
		End if 
	End if 
	
	err_FINALLY
	
End if 