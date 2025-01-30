//%attributes = {"invisible":true,"shared":true}
// The VP IMPORT FROM BLOB command imports and displays the viewPro 4D View Pro blob in the vpAreaName 4D View Pro area. The imported object contents replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In viewPro, pass a valid 4D View Pro blob. This object can have been created using VP Export to blob or manually from a blob that holds a .sjs file content.
// An error is returned if the viewPro object is invalid.
#DECLARE($areaName : Text; $viewProBlobObject : 4D:C1709.Blob; $options : Object)

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(2; Count parameters:C259))
		
		
		If ($options=Null:C1517)
			
			$options:={}
			
		End if 
		
		If (vp_isReady($areaName; Current method name:C684))
			If (($viewProBlobObject=Null:C1517) || (OB Is empty:C1297($viewProBlobObject)))
				VP NEW DOCUMENT($areaName)
			Else 
				
				If (OB Instance of:C1731($viewProBlobObject; 4D:C1709.Blob))
					
					$options.blob:=$viewProBlobObject
					
					var $textBuffer : Text
					BASE64 ENCODE:C895($viewProBlobObject; $textBuffer)
					
					var $callback:=vp_newCallback("import-blob"; $areaName; $options)
					$callback.content:=$textBuffer
					$callback.sjsOptions:=$options
					
					vp_runFunction($areaName; "import-sjs"; $callback)
					
				Else 
					
					err_THROW({code: 1})  // invalid object
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 