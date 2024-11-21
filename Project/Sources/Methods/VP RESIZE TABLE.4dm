//%attributes = {"invisible":true,"shared":true}
#DECLARE($ranges : Object; $name : Text)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			var $ret:=vp_runFunction($area; "resize-table"; {ranges: $ranges.ranges; name: $name})
			
		End if 
	End if 
	
	
	err_FINALLY
	
End if 