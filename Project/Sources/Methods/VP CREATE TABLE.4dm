//%attributes = {"invisible":true,"shared":true}
#DECLARE($ranges : Object; $name : Text; $p3 : Variant; $p4 : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			var $options : Object
			var $Var_dataSource : Text
			If ($nbParameters=3)
				If (Value type:C1509($p3)=Is text:K8:3)
					$Var_dataSource:=$p3
				End if 
				If (Value type:C1509($p3)=Is object:K8:27)
					$options:=$p3
				End if 
			End if 
			
			If ($nbParameters>3)
				If (Value type:C1509($p3)=Is text:K8:3)
					$Var_dataSource:=$p3
				End if 
				$options:=$p4
			End if 
			
			var $params:=New object:C1471()
			
			$params.ranges:=$ranges.ranges
			$params.name:=$name
			$params.source:=$Var_dataSource
			$params.options:=$options
			
			var $ret:=vp_runFunction($area; "create-table"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 