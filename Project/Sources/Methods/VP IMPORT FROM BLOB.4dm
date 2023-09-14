//%attributes = {"invisible":true,"shared":true}
// The VP IMPORT FROM BLOB command imports and displays the viewPro 4D View Pro blob in the vpAreaName 4D View Pro area. The imported object contents replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In viewPro, pass a valid 4D View Pro blob. This object can have been created using VP Export to blob or manually from a blob that holds a .sjs file content.
// An error is returned if the viewPro object is invalid.

C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($areaName; $textBuffer)
C_OBJECT:C1216($viewProBlobObject; $callback; $options; $areaVariable)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$areaName:=$1
		$viewProBlobObject:=$2
		
		If ($nbParameters>=3)
			
			$options:=$3
			
		Else 
			
			$options:=New object:C1471
			
		End if 
		
		If (vp_isReady($areaName; Current method name:C684))
			If (($viewProBlobObject=Null:C1517) | (OB Is empty:C1297($viewProBlobObject)))
				VP NEW DOCUMENT($areaName)
			Else 
				
				If (OB Instance of:C1731($viewProBlobObject; 4D:C1709.Blob))
					
					$options.blob:=$viewProBlobObject
					
					BASE64 ENCODE:C895($viewProBlobObject; $textBuffer)
					
					$callback:=New object:C1471
					$callback.content:=$textBuffer
					$callback.command:="import-blob"
					$callback.areaName:=$areaName
					$callback.sjsOptions:=$options
					
					// Is there a user callback method to execute ?
					If ($options.formula#Null:C1517)
						
						// Get an UUID to associate with the callback method
						$callback.uuid:=Generate UUID:C1066
						
						// Keep the callback method
						
						$areaVariable:=vp_getAreaVariable($areaName)
						
						If ($areaVariable#Null:C1517)
							If (Value type:C1509($areaVariable.callbacks)=Is object:K8:27)
								$areaVariable.callbacks[$callback.uuid]:=$options
							End if 
						End if 
						
					End if 
					
					vp_runFunction($areaName; "import-sjs"; $callback)
					
				Else 
					
					// Invalid object
					err_THROW(New object:C1471("code"; 1))
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 