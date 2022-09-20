//%attributes = {"invisible":true,"shared":true}
// copy the cells in the range sent as parameter into an object
// while there is no direct function to do that in SpreadJS
// creates a temporary sheet and copy the range into this sheet
// then save the sheet into the returned object
// the second parameters are options to tell what to copy (values, styles, formulas)

C_OBJECT:C1216($0; $1; $2)

C_OBJECT:C1216($from; $params; $options)
C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$from:=$1
		$area:=$from.area
		
		If ($nbParameters>1)
			$options:=$2
		Else 
			$options:=New object:C1471("copy"; True:C214; "copyOptions"; 0)
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($from.ranges)=Is collection:K8:32)
				$params:=New object:C1471
				$params.from:=$from.ranges
				$params.options:=$options
				
				$0:=vp_runFunction($area; "copy-cells"; $params)
				
			End if 
		End if 
	End if 
	
	FINALLY
	
End if 