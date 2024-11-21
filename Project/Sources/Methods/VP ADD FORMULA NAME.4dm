//%attributes = {"invisible":true,"shared":true}
// The VP ADD FORMULA NAME command creates or modifies a named formula in the open document.
#DECLARE($area : Text; $formula : Text; $name : Text; $options : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		If ($nbParameters<4)
			$options:=New object:C1471("scope"; -1)
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $params:={\
				formula: $formula; \
				name: $name; \
				options: $options}
			
			vp_runCommand($area; "add-formula-name"; $params)
			
		End if 
		
	End if 
	
	err_FINALLY
	
End if 