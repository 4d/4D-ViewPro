//%attributes = {"invisible":true,"shared":true}
// paste the object passed as first parameter in the range pointed by parameter 2
// third parameter are options to tell what will be pasted (values, formulas, style)
#DECLARE($dest : Object; $obj : Object; $options : Integer)

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(2; Count parameters:C259))
		
		var $area : Text:=$dest.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($dest.ranges)=Is collection:K8:32)
				
				vp_runCommand($area; "paste-cells"; {obj: $obj; dest: $dest.ranges; options: $options})
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 