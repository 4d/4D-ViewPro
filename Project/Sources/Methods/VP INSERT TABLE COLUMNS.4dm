//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $name : Text; $column : Integer; $count : Integer; $insertAfter : Integer; $sheet : Integer)

var $isInsertAfter : Boolean

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters<4)
				$count:=1
			End if 
			
			If ($nbParameters>4)
				$isInsertAfter:=($insertAfter#0)  // TODO: maybe use vk table insert before / vs table insert after
			Else 
				$isInsertAfter:=False:C215
			End if 
			
			If ($nbParameters<6)
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
					$params.column:=$column
					$params.count:=$count
					$params.isInsertAfter:=$isInsertAfter
					$params.sheet:=$sheet
					
					var $ret:=vp_runFunction($area; "insert-table-columns"; $params)
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 