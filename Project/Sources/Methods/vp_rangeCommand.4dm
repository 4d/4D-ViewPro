//%attributes = {"invisible":true}
#DECLARE($ranges : Object; $command : Text; $caller : Text)

If (Not:C34(vp_initStorage))
	return 
End if 

err_TRY

If (Check_parameters_count(1; Count parameters:C259))
	
	var $area : Text:=$ranges.area
	
	If (vp_isReady($area; $caller))
		
		If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
			
			vp_runCommand($area; $command; {ranges: $ranges.ranges})
			
		End if 
		
	End if 
End if 

err_FINALLY
