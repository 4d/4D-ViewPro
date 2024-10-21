//%attributes = {"invisible":true,"shared":true}
// The VP IMPORT DOCUMENT command imports and displays the 4D View Pro document designated by filePath in the 4D View Pro area vpAreaName. The imported document replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In filePath, pass the destination path and name of the document to be imported. Only 4D View Pro documents (extension ".4vp") are supported by the command. You must pass a full path, unless the document is located at the same level as the database structure file, in which case you can just pass its name.
// An error is returned if the filePath parameter is invalid, or if the file is missing or malformed.
#DECLARE($area : Text; $filePath : Text; $params : Object)

var $textBuffer; $fileName : Text
var $documentObject; $pathObject; $callback; $areaVariable : Object
var $blobBuffer : Blob

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(2; Count parameters:C259))
		
		If ($params=Null:C1517)
			
			$params:=New object:C1471
			
		End if 
		
		
		If (vp_isReady($area; Current method name:C684))
			
			var $isOK:=(Length:C16($filePath)>0)
			
			If ($isOK)
				
				If (Position:C15(Folder separator:K24:12; $filePath)=0)
					
					$fileName:=$filePath
					
					// Search for a document located near the 4D structure file
					$filePath:=Get 4D folder:C485(Database folder:K5:14; *)+$fileName
					
				Else 
					
					$pathObject:=Path to object:C1547($filePath)
					$fileName:=$pathObject.name+$pathObject.extension
					
				End if 
				
				Case of 
						
						//________________________________________
					: (Test path name:C476($filePath)#Is a document:K24:1)
						
						$isOK:=False:C215
						
						// File "{name}" not found ({path})
						err_THROW(New object:C1471("component"; "xbox"; "code"; 600; "name"; $fileName; "path"; $filePath))
						
						//________________________________________
				End case 
				
				If ($isOK)
					
					Case of 
							// MARK:- 4VP
						: ($filePath="@.4VP")
							
							$textBuffer:=Document to text:C1236($filePath; "UTF-8")
							
							If (err_continue)
								
								$documentObject:=JSON Parse:C1218($textBuffer)
								
								If (err_continue)
									
									If ($documentObject.spreadJS#Null:C1517)
										
										vp_UPDATE($documentObject)
										
									Else 
										
										// Allow to open a spreadJS' native document by changing the ".json"
										// Extension to ".4VP"
										$documentObject:=New object:C1471("version"; Storage:C1525.ViewPro.version; "spreadJS"; $documentObject)
										
									End if 
									
									// Validate data with shema
									If (vp_isDocumentValid($documentObject))
										
										vp_runFunction($area; "import-json"; New object:C1471("doc"; $documentObject; "new"; False:C215))
										// Is there a user callback method to execute ?
										
										If ($params.formula#Null:C1517)
											$callback:=New object:C1471
											$callback.path:=$filePath
											$callback.command:="import-4VP"
											$callback.areaName:=$area
											
											// Get an UUID to associate with the callback method
											$callback.uuid:=Generate UUID:C1066
											
											// Keep the callback method
											$areaVariable:=vp_getAreaVariable($area)
											If ($areaVariable#Null:C1517)
												If (Value type:C1509($areaVariable.callbacks)=Is object:K8:27)
													
													$areaVariable.callbacks[$callback.uuid]:=$params
												End if 
											End if 
											
											vp_callback($callback)
										End if 
										
									Else 
										
										// The file "{name}" is not a valid 4D View Pro file.
										err_THROW(New object:C1471("code"; 4; "name"; $fileName))
										
									End if 
									
								Else 
									
									err_THROW(New object:C1471("code"; 7; "name"; $fileName))
									
								End if 
								
							Else 
								
								// Cannot open file "{name}" ({path})
								err_THROW(New object:C1471("component"; "xbox"; "code"; 602; "name"; $fileName; "path"; $filePath))
								
							End if 
							// MARK:- xlsx
						: ($filePath="@.xlsx")
							DOCUMENT TO BLOB:C525($filePath; $blobBuffer)
							
							If (err_continue)
								BASE64 ENCODE:C895($blobBuffer; $textBuffer)
								
								If (Length:C16($textBuffer)>0)
									
									// Keep the export file destination pathname
									$callback:=New object:C1471
									$callback.path:=$filePath
									$callback.content:=$textBuffer
									$callback.command:="import-excel"
									$callback.areaName:=$area
									$callback.password:=$params.password
									$callback.excelOptions:=$params.excelOptions
									$callback.excelIO:=$params.excelIO
									
									// Is there a user callback method to execute ?
									If ($params.formula#Null:C1517)
										
										// Get an UUID to associate with the callback method
										$callback.uuid:=Generate UUID:C1066
										
										// Keep the callback method
										
										$areaVariable:=vp_getAreaVariable($area)
										
										If ($areaVariable#Null:C1517)
											If (Value type:C1509($areaVariable.callbacks)=Is object:K8:27)
												$areaVariable.callbacks[$callback.uuid]:=$params
											End if 
										End if 
										
									End if 
									
									// Launch export
									$documentObject:=vp_runFunction($area; "import-excel"; $callback)
									
								End if 
								
							End if 
							
							// MARK:- sjs
						: ($filePath="@.sjs")
							DOCUMENT TO BLOB:C525($filePath; $blobBuffer)
							
							If (err_continue)
								BASE64 ENCODE:C895($blobBuffer; $textBuffer)
								
								If (Length:C16($textBuffer)>0)
									
									// Keep the export file destination pathname
									$callback:=New object:C1471
									$callback.path:=$filePath
									$callback.content:=$textBuffer
									$callback.command:="import-sjs"
									$callback.areaName:=$area
									$callback.sjsOptions:=$params.sjsOptions
									
									// Is there a user callback method to execute ?
									If ($params.formula#Null:C1517)
										
										// Get an UUID to associate with the callback method
										$callback.uuid:=Generate UUID:C1066
										
										// Keep the callback method
										
										$areaVariable:=vp_getAreaVariable($area)
										
										If ($areaVariable#Null:C1517)
											If (Value type:C1509($areaVariable.callbacks)=Is object:K8:27)
												$areaVariable.callbacks[$callback.uuid]:=$params
											End if 
										End if 
										
									End if 
									
									// Launch export
									$documentObject:=vp_runFunction($area; "import-sjs"; $callback)
									
								End if 
								
							End if 
							
						Else   // if not xls or 4VP then csv
							// MARK:- csv
							If ($params.csvOptions.rowDelimiter#Null:C1517)
								$textBuffer:=Document to text:C1236($filePath; "UTF-8"; Document unchanged:K24:18)
							Else 
								$textBuffer:=Document to text:C1236($filePath; "UTF-8"; Document with LF:K24:22)
							End if 
							
							If (err_continue)
								
								var $jsParams : Object
								$jsParams:=($params.csvOptions#Null:C1517) ? OB Copy:C1225($params.csvOptions) : New object:C1471()
								If ($jsParams.rowDelimiter=Null:C1517)
									$jsParams.rowDelimiter:=Char:C90(Line feed:K15:40)  // we read file with LF
								End if 
								$jsParams.csv:=$textBuffer
								
								vp_runFunction($area; "import-csv"; $jsParams)  // suppose synchrone, no js callback 
								// Is there a user callback method to execute ?
								
								If ($params.formula#Null:C1517)
									
									$callback:=New object:C1471
									$callback.path:=$filePath
									$callback.command:="import-csv"
									$callback.areaName:=$area
									
									// Get an UUID to associate with the callback method
									$callback.uuid:=Generate UUID:C1066
									
									// Keep the callback method
									$areaVariable:=vp_getAreaVariable($area)
									If ($areaVariable#Null:C1517)
										If (Value type:C1509($areaVariable.callbacks)=Is object:K8:27)
											
											$areaVariable.callbacks[$callback.uuid]:=$params
										End if 
									End if 
									
									vp_callback($callback)
								End if 
							End if 
							
					End case 
				End if 
			Else   //-----
				
				// Output document path is empty.
				err_THROW(New object:C1471("component"; "xbox"; "code"; 3107))
				
			End if 
			
			If (Not:C34($isOK))
				
				err_THROW(New object:C1471("code"; 7; "name"; $fileName))
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 