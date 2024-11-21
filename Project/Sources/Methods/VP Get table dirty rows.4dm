//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $table : Text; $reset : Boolean; $sheet : Integer)->$result : Collection

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters<3)
				$reset:=True:C214
			End if 
			
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
					
					$params.name:=$table
					$params.reset:=$reset
					$params.sheet:=$sheet
					
					var $ret:=vp_runFunction($area; "get-table-dirty-rows"; $params)
					$result:=$ret.dirtyRows
					
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 