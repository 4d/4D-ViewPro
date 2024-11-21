//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $sheet : Integer)->$result : Collection

$result:=[]

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
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
					
					var $ret:=vp_runFunction($area; "get-tables"; {sheet: $sheet})
					$result:=$ret.collection
					
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
