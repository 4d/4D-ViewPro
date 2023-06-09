//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($0)
C_OBJECT:C1216($1)

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($params; $ranges)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$ranges:=$1
		
		$area:=$ranges.area
		
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