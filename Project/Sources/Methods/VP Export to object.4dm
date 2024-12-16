//%attributes = {"invisible":true,"shared":true}
// The VP Export to object command returns the 4D View Pro object attached to the given 4D View Pro area.
#DECLARE($area : Text; $params : Object)->$viewProObject : Object

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(1; Count parameters:C259))
		
		If ($params=Null:C1517)
			
			$params:={}
			
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			$viewProObject:=vp_runFunction($area; "export-json"; $params)
			
			If (err_continue)
				Case of 
						
						//………………………………………………………………………………………
					: ($viewProObject=Null:C1517)
						
						err_THROW({code: 2; message: "'export-json'"})
						
						//………………………………………………………………………………………
					: (err_continue)
						
						vp_METADATA($viewProObject)
						
						//………………………………………………………………………………………
					Else 
						
						//………………………………………………………………………………………
				End case 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 