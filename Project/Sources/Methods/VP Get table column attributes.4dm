//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $name : Text; $index : Integer; $sheet : Integer)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters<4)
				$sheet:=-1
			End if 
			
			If ($sheet<-1)
				err_THROW(New object:C1471("code"; 17))
			Else 
				If ($sheet>=VP Get sheet count($area))
					err_THROW(New object:C1471("code"; 19))
				Else 
					
					var $params:=New object:C1471()
					
					$params.name:=$name
					$params.index:=$index
					$params.sheet:=$sheet
					
					$result:=vp_runFunction($area; "get-table-column-attributes"; $params)
					
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 