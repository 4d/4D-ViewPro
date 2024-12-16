//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $name : Text; $theme : Object; $sheet : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters<4)
				$sheet:=-1
			End if 
			
			If ($sheet<-1)
				err_THROW({code: 17 /*Sheet must be greater or equal than -2*/})
			Else 
				If ($sheet>=VP Get sheet count($area))
					err_THROW({code: 19 /*Sheet index should not be greater than or equal to the number of sheets*/})
				Else 
					
					var $params:=New object:C1471()
					
					$params.name:=$name
					$params.theme:=$theme
					$params.sheet:=$sheet
					
					var $ret:=vp_runFunction($area; "set-table-theme"; $params)
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 