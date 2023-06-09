//%attributes = {"invisible":true,"shared":true}
// paste the object passed as first parameter in the range pointed by parameter 2
// third parameter are options to tell what will be pasted (values, formulas, style)

C_OBJECT:C1216($1)
C_OBJECT:C1216($2)
C_LONGINT:C283($3)

C_OBJECT:C1216($obj; $dest; $params)
C_LONGINT:C283($nbParameters; $options)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$dest:=$1
		$obj:=$2
		$area:=$dest.area
		
		If ($nbParameters>2)
			$options:=$3
		Else 
			$options:=0
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($dest.ranges)=Is collection:K8:32)
				$params:=New object:C1471
				$params.obj:=$obj
				$params.dest:=$dest.ranges
				$params.options:=$options
				
				vp_runCommand($area; "paste-cells"; $params)
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 