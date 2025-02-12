//%attributes = {"invisible":true}
/*
When a VP command calls a js command that runs asynchronously,
& the js command is done, js calls $4d.__vp_callback
which is trapped by C++, which will call vp_callback in 4D ViewPro component. 
We need to use C++ to call vp_callback from JS because this method is not shared
outside the component, so not directly available by $4d.xxx
*/
#DECLARE($callback : Object)

var $content; $pathname; $uuid : Text
var $run; $success : Boolean
var $areaValue; $formula; $status; $userObject : Object
var $blob : 4D:C1709.Blob

If (($callback=Null:C1517) || ($callback.command=Null:C1517))
	
	return 
	
End if 

cs:C1710._ErrorCallBack.me.try()

Case of 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($callback.command="export-excel")\
		 | ($callback.command="export-pdf")\
		 | ($callback.command="export-sjs")\
		 | ($callback.command="export-blob")
		
		$run:=True:C214
		
		If ($callback.content#Null:C1517)
			
			// Content is encoded
			$content:=$callback.content
			OB REMOVE:C1226($callback; "content")  // Free memory as soon as possible
			$blob:=4D:C1709.Blob.new()
			BASE64 DECODE:C896($content; $blob)
			$content:=""  // Free memory as soon as possible
			
			If ($callback.command="export-blob")
				
				$success:=True:C214
				
			Else 
				
				If ($blob.size>0)
					
					$pathname:=String:C10($callback.path)
					
					// Create-update the document
					BLOB TO DOCUMENT:C526($pathname; $blob)
					
					If (Not:C34(cs:C1710._ErrorCallBack.me.hasErrors()))
						
						$success:=True:C214
						
					Else 
						
						cs:C1710._ErrorCallBack.me.throw(1; "Error, unable to write file "+File:C1566($pathname; fk platform path:K87:2).fullName+", check if file is not locked or in use.")
						
					End if 
					
				Else 
					
					cs:C1710._ErrorCallBack.me.throw(2; "Internal error, empty document returned")
					
				End if 
			End if 
		End if 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($callback.command="import-excel")\
		 | ($callback.command="import-sjs")\
		 | ($callback.command="export-4VP")\
		 | ($callback.command="import-4VP")\
		 | ($callback.command="export-csv")\
		 | ($callback.command="import-csv")
		
		$pathname:=String:C10($callback.path)
		$success:=True:C214
		$run:=True:C214
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($callback.command="import-blob")
		
		$success:=True:C214
		$run:=True:C214
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($callback.command="asyncflush")
		
		$success:=True:C214
		$run:=True:C214
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
End case 

If ($run)\
 && ($callback.uuid#Null:C1517)
	
	$uuid:=$callback.uuid
	$areaValue:=vp_getAreaVariable($callback.areaName)
	
	If ($areaValue#Null:C1517)\
		 && (Value type:C1509($areaValue.callbacks)=Is object:K8:27)\
		 && ($areaValue.callbacks[$uuid]#Null:C1517)
		
		// Get the object given by user
		$userObject:=$areaValue.callbacks[$uuid]
		
		// Clean-up
		OB REMOVE:C1226($areaValue.callbacks; $uuid)
		
		If ($userObject.formula#Null:C1517)
			
			$formula:=$userObject.formula
			$status:={success: $success}
			
			If ($callback.error#Null:C1517)
				
				$status:=$callback.error
				$status.success:=False:C215
				
			Else 
				
				If (cs:C1710._ErrorCallBack.me.hasErrors())
					
					$status:=cs:C1710._ErrorCallBack.me.result
					$status.success:=False:C215
					
				End if 
			End if 
			
			Case of 
				: (($callback.command="import-blob")\
					 | ($callback.command="export-blob"))
					
					If ($callback.command="import-blob")
						
						$blob:=$userObject.blob
						OB REMOVE:C1226($userObject; "blob")
						
					End if 
					
					$formula.call(Null:C1517; $callback.areaName; $blob; $userObject; $status)
					
				: ($callback.command="asyncflush")
					
					$formula.call(Null:C1517; $callback.areaName; $status)
					
				Else 
					
					$formula.call(Null:C1517; $callback.areaName; $pathname; $userObject; $status)
					
			End case 
		End if 
	End if 
End if 

cs:C1710._ErrorCallBack.me.finally()