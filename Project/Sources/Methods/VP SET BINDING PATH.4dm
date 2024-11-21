//%attributes = {"invisible":true,"shared":true}
// The VP SET BINDING PATH command binds an attribute from a sheet's data context
// to a given cell range
#DECLARE($range : Object; $path : Text)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area : Text:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				
				vp_runCommand($area; "set-binding-path"; {ranges: $range.ranges; path: $path})
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 