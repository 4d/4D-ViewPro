//%attributes = {"invisible":true,"shared":true}
// The VP EXPORT TO BLOB command returns in the callback the 4D View Pro blob attached to the given 4D View Pro area.

C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($areaName)
C_OBJECT:C1216($callback; $options; $areaVariable)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$areaName:=$1
		$options:=$2
		
		If (vp_isReady($areaName; Current method name:C684))
			
			// We must keep parameters for later use
			// when the asynchronous export will be ending
			
			// Keep the export file destination pathname
			$callback:=New object:C1471
			$callback.areaName:=$areaName
			
			// Is there a user callback method to execute ?
			If ($options.formula=Null:C1517)
				
				err_THROW(New object:C1471(\
					"code"; 2; \
					"message"; "export-blob"))
				
			Else 
				
				// Get an UUID to associate with the callback method
				$callback.uuid:=Generate UUID:C1066
				$callback.command:="export-blob"
				$callback.sjsOptions:=OB Copy:C1225($options)
				OB REMOVE:C1226($callback.sjsOptions; "formula")
				
				// Keep the callback method
				
				$areaVariable:=vp_getAreaVariable($areaName)
				If ($areaVariable#Null:C1517)
					If (Value type:C1509($areaVariable.callbacks)=Is object:K8:27)
						
						$areaVariable.callbacks[$callback.uuid]:=$options
					End if 
				End if 
				
				vp_runFunction($areaName; "export-sjs"; $callback)
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 