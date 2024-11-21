//%attributes = {"invisible":true,"shared":true}
// The VP Get binding path command returns the name of the attribute
// bound to the cell specified in the cell range passed as parameter
#DECLARE($range : Object)->$result : Text

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				
				var $obj:=vp_runFunction($area; "get-binding-path"; {ranges: $range.ranges})
				$result:=$obj.value
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 