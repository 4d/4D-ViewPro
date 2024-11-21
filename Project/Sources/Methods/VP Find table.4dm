//%attributes = {"invisible":true,"shared":true}
#DECLARE($ranges : Object)->$result : Text

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			var $params:=New object:C1471()
			
			$params.ranges:=$ranges.ranges
			
			var $ret:=vp_runFunction($area; "find-table"; $params)
			$result:=$ret.table
			
		End if 
	End if 
	
	err_FINALLY
	
End if 