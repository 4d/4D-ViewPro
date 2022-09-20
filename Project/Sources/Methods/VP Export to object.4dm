//%attributes = {"invisible":true,"shared":true}
// The VP Export to object command returns the 4D View Pro object attached to the given 4D View Pro area.

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($areaName)
C_OBJECT:C1216($viewProObject; $params)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$areaName:=$1
		
		If ($nbParameters>=2)
			
			$params:=$2
			
		Else 
			
			$params:=New object:C1471
			
		End if 
		
		If (vp_isReady($areaName; Current method name:C684))
			
			$viewProObject:=vp_runFunction($areaName; "export-json"; $params)
			
			If (vp_continue)
				Case of 
						
						//………………………………………………………………………………………
					: ($viewProObject=Null:C1517)
						
						THROW(New object:C1471(\
							"code"; 2; \
							"message"; "'export-json'"))
						
						//………………………………………………………………………………………
					: (vp_continue)
						
						vp_METADATA($viewProObject)
						
						//………………………………………………………………………………………
					Else 
						
						//………………………………………………………………………………………
				End case 
			End if 
		End if 
	End if 
	
	FINALLY
	
	// ----------------------------------------------------
	// Return
	$0:=$viewProObject
	
	// ----------------------------------------------------
	// End
	
End if 