//%attributes = {"invisible":true,"shared":true}
C_OBJECT:C1216($1)
C_TEXT:C284($2)
C_VARIANT:C1683($3)
C_OBJECT:C1216($4)

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($params; $ranges; $options)
C_TEXT:C284($Var_dataSource)
C_TEXT:C284($name; $area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$ranges:=$1
		$name:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters=3)
				If (Value type:C1509($3)=Is text:K8:3)
					$Var_dataSource:=$3
				End if 
				If (Value type:C1509($3)=Is object:K8:27)
					$options:=$3
				End if 
			End if 
			
			If ($nbParameters>3)
				If (Value type:C1509($3)=Is text:K8:3)
					$Var_dataSource:=$3
				End if 
				$options:=$4
			End if 
			
			$params:=New object:C1471()
			
			$params.ranges:=$ranges.ranges
			$params.name:=$name
			$params.source:=$Var_dataSource
			$params.options:=$options
			
			C_OBJECT:C1216($ret)
			$ret:=vp_runFunction($area; "create-table"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 