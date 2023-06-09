//%attributes = {"invisible":true,"shared":true}
C_OBJECT:C1216($1)
C_TEXT:C284($2)

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($params; $ranges)
C_TEXT:C284($name; $area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$ranges:=$1
		$name:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			$params:=New object:C1471()
			
			$params.ranges:=$ranges.ranges
			$params.name:=$name
			
			C_OBJECT:C1216($ret)
			$ret:=vp_runFunction($area; "resize-table"; $params)
		End if 
	End if 
	
	
	err_FINALLY
	
End if 