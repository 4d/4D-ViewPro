//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($0)
C_OBJECT:C1216($1)


C_OBJECT:C1216($params; $ranges)


If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$ranges:=$1
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			$params:=New object:C1471()
			
			$params.ranges:=$ranges.ranges
			
			C_OBJECT:C1216($ret)
			$ret:=vp_runFunction($area; "find-table"; $params)
			$0:=$ret.table
			
		End if 
	End if 
	
	err_FINALLY
	
End if 