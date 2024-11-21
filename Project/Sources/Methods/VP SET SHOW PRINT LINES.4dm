//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $visible : Boolean; $sheetIndex : Integer)

If (vp_initStorage)
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$visible:=True:C214
		End if 
		
		If ($nbParameters<3)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "set-show-print-lines"; {visible: $visible; sheetIndex: $sheetIndex})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 