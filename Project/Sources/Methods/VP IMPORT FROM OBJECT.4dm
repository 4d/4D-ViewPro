//%attributes = {"invisible":true,"shared":true}
// The VP IMPORT FROM OBJECT command imports and displays the viewPro 4D View Pro object in the vpAreaName 4D View Pro area. The imported object contents replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In viewPro, pass a valid 4D View Pro object. This object can have been created using VP Export to object or manually. For more information on 4D View Pro objects, please refer to XXX.
// An error is returned if the viewPro object is invalid.
#DECLARE($area : Text; $viewProObject : Object)

If (Not:C34(vp_initStorage))
	return 
End if 

If (Not:C34(Check_parameters_count(2; Count parameters:C259)))
	return 
End if 

err_TRY

If (Not:C34(vp_isReady($area; Current method name:C684)))
	err_FINALLY
	return 
End if 

If (($viewProObject=Null:C1517) | (OB Is empty:C1297($viewProObject)))
	
	VP NEW DOCUMENT($area)
	
Else 
	
	vp_UPDATE_SJS($viewProObject.spreadJS)
	
	Case of 
			
			//______________________________________________________
		: ($viewProObject=Null:C1517)
			
			
			err_THROW({code: 1})  // Invalid object
			
			//______________________________________________________
		: ($viewProObject.version=Null:C1517)
			
			err_THROW({code: 1})  // Invalid object
			
			//______________________________________________________
		: ($viewProObject.spreadJS.version#Storage:C1525.ViewPro.spreadJSVersion)
			
			err_THROW({code: 1})  // Invalid object
			
			//______________________________________________________
		Else 
			
			If (vp_isDocumentValid($viewProObject))
				
				vp_runFunction($area; "import-json"; {doc: $viewProObject; new: False:C215})
				
			Else 
				
				err_THROW({code: 1})  // Invalid object
				
			End if 
			
			//______________________________________________________
	End case 
End if 

err_FINALLY
