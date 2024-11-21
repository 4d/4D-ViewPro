//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $name : Text; $sheet : Integer)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters<3)
				$sheet:=-1
			End if 
			
			If ($sheet<-1)
				err_THROW(New object:C1471("code"; 17))
			Else 
				If ($sheet>=VP Get sheet count($area))
					err_THROW(New object:C1471("code"; 19))
				Else 
					
					$result:=vp_runFunction($area; "get-table-theme"; {name: $name; sheet: $sheet})
					
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 