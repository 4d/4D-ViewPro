//%attributes = {"invisible":true,"shared":true}
// The VP Get binding path command returns the name of the attribute 
// bound to the cell specified in the cell range passed as parameter

C_TEXT:C284($0)
C_OBJECT:C1216($1)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_OBJECT:C1216($params; $range; $obj)

If (False:C215)
	C_TEXT:C284(VP Get binding path; $0)
	C_OBJECT:C1216(VP Get binding path; $1)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$range:=$1
		
		$area:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			$params:=New object:C1471
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				$params.ranges:=$range.ranges
				
				$obj:=vp_runFunction($area; "get-binding-path"; $params)
				$0:=$obj.value
			End if 
		End if 
	End if 
	
	FINALLY
	
End if 