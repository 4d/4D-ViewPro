//%attributes = {"invisible":true,"shared":true}
// The VP NEW DOCUMENT command loads and display a new, default document in the 4D View Pro form area object vpAreaName. The new empty document replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
#DECLARE($area : Text)

var $filePath; $textBuffer; $fileName : Text
var $documentObject; $path : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			// Get host database default template path
			$filePath:=Object to path:C1548(New object:C1471(\
				"name"; "default"; \
				"extension"; "4vp"; \
				"parentFolder"; Get 4D folder:C485(Current resources folder:K5:16; *)+"viewPro"))
			
			If (Test path name:C476($filePath)#Is a document:K24:1)
				
				// Get internal default template path
				$filePath:=Object to path:C1548(New object:C1471(\
					"name"; "default"; \
					"extension"; "4vp"; \
					"parentFolder"; Get 4D folder:C485(Current resources folder:K5:16)+"viewPro"))
				
			End if 
			
			Case of 
					
					//______________________________________________________
				: (Test path name:C476($filePath)#Is a document:K24:1)
					
					// File "{name}" not found ({path})
					$path:=Path to object:C1547($filePath)
					
					err_THROW({component: "xbox"; code: 600; name: $path.name+$path.extension; path: $filePath})
					
					//______________________________________________________
				Else 
					
					$textBuffer:=Document to text:C1236($filePath)
					
					If (err_continue)
						
						$documentObject:=JSON Parse:C1218($textBuffer)
						
						If (err_continue)
							
							$documentObject.version:=Storage:C1525.ViewPro.version
							$documentObject.spreadJS.version:=Storage:C1525.ViewPro.spreadJSVersion
							
							If ($documentObject.spreadJS.sheets.Sheet1.columnCount=Null:C1517)
								
								$documentObject.spreadJS.sheets.Sheet1.columnCount:=100
								
							End if 
							
							If ($documentObject.spreadJS.sheets.Sheet1.rowCount=Null:C1517)
								
								$documentObject.spreadJS.sheets.Sheet1.rowCount:=1000
								
							End if 
							
							C_OBJECT:C1216($obj)
							$obj:=vp_getAreaVariable($area)
							If ($obj.interface#"none")
								
								$documentObject.spreadJS.tabStripVisible:=True:C214
								
							End if 
							
							vp_runFunction($area; "import-json"; New object:C1471("doc"; $documentObject; "new"; True:C214))
							
						Else 
							
							err_THROW({code: 7; name: $fileName})
							
						End if 
						
					Else 
						
						// Cannot open file "{name}" ({path})
						err_THROW({component: "xbox"; code: 602; name: $fileName; path: $filePath})
						
					End if 
					
					//______________________________________________________
			End case 
		End if 
	End if 
	
	err_FINALLY
	
End if 