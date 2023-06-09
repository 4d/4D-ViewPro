//%attributes = {"invisible":true,"shared":true}
// The VP SET BINDING PATH command binds an attribute from a sheet's data context
// to a given cell range

C_OBJECT:C1216($1)
C_TEXT:C284($2)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($path; $area)
C_OBJECT:C1216($params; $range)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$range:=$1
		$path:=$2
		
		$area:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			$params:=New object:C1471
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				$params.ranges:=$range.ranges
				$params.path:=$path
				
				vp_runCommand($area; "set-binding-path"; $params)
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 