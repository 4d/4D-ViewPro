//%attributes = {"invisible":true,"shared":true}
// The VP IMPORT FROM OBJECT command imports and displays the viewPro 4D View Pro object in the vpAreaName 4D View Pro area. The imported object contents replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In viewPro, pass a valid 4D View Pro object. This object can have been created using VP Export to object or manually. For more information on 4D View Pro objects, please refer to XXX.
// An error is returned if the viewPro object is invalid.

C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($areaName)
C_OBJECT:C1216($viewProObject)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$areaName:=$1
		$viewProObject:=$2
		
		If (vp_isReady($areaName; Current method name:C684))
			If (($viewProObject=Null:C1517) | (OB Is empty:C1297($viewProObject)))
				VP NEW DOCUMENT($areaName)
			Else 
				
				
				vp_UPDATE_SJS($viewProObject.spreadJS)
				
				Case of 
						
						//______________________________________________________
					: ($viewProObject=Null:C1517)
						
						// Invalid object
						err_THROW(New object:C1471(\
							"code"; 1))
						
						//______________________________________________________
					: ($viewProObject.version=Null:C1517)
						
						// Invalid object
						err_THROW(New object:C1471(\
							"code"; 1))
						
						//______________________________________________________
					: ($viewProObject.spreadJS.version#Storage:C1525.ViewPro.spreadJSVersion)
						
						// Invalid object
						err_THROW(New object:C1471(\
							"code"; 1))
						
						//______________________________________________________
					Else 
						
						If (vp_isDocumentValid($viewProObject))
							
							vp_runFunction($areaName; "import-json"; New object:C1471("doc"; $viewProObject; "new"; False:C215))
							
						Else 
							
							// Invalid object
							err_THROW(New object:C1471(\
								"code"; 1))
							
						End if 
						
						//______________________________________________________
				End case 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 