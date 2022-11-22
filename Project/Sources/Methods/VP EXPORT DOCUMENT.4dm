//%attributes = {"invisible":true,"shared":true}
// The VP EXPORT DOCUMENT command exports the 4D View Pro object attached to the 4D View Pro area vpAreaName
// to a document on disk according to the filePath parameter.
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In filePath, pass the destination path and name of the document to be exported. If you pass only the document name, it will be saved at the same level as the 4D structure file. 
// 4D View Pro document extension is ".4vp". It is automatically added to the document name if not passed in filePath.

C_TEXT:C284($1)
C_TEXT:C284($2)
C_OBJECT:C1216($3)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($path; $area)
C_OBJECT:C1216($callback; $documentObject; $params; $pathObject; $areaVariable)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$path:=$2
		
		If ($nbParameters>=3)
			
			$params:=$3
			
		Else 
			
			$params:=New object:C1471
			
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			$pathObject:=vp_Path($path; String:C10($params.format))
			
			$path:=Object to path:C1548($pathObject)
			
			Case of 
					
					//______________________________________________________
				: (Length:C16($path)=0)
					
					// Output document path is empty.
					THROW(New object:C1471(\
						"component"; "xbox"; \
						"code"; 3107))
					
					//______________________________________________________
				: ($pathObject.extension=".4vp")
					
					// Gets the json description of the area content
					$documentObject:=vp_runFunction($area; "export-json"; $params)
					
					If (vp_continue)
						
						Case of 
								
								//………………………………………………………………………………………
							: ($documentObject=Null:C1517)
								
								THROW(New object:C1471(\
									"code"; 2; \
									"message"; "export-json"))
								
								//………………………………………………………………………………………
							Else 
								
								vp_METADATA($documentObject)
								
								If (Storage:C1525.ViewPro.options.prettyPrint)  // Pretty print
									
									TEXT TO DOCUMENT:C1237($path; JSON Stringify:C1217($documentObject; *))
									
								Else 
									
									TEXT TO DOCUMENT:C1237($path; JSON Stringify:C1217($documentObject))
									
								End if 
								
								If (vp_continue)
									
									If ($params.formula#Null:C1517)
										
										$callback:=New object:C1471
										$callback.path:=$path
										$callback.command:="export-4VP"
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
								
								//………………………………………………………………………………………
						End case 
					End if 
					
					//______________________________________________________
				: ($pathObject.extension=".xlsx")\
					 | ($pathObject.extension=".pdf")
					
					// We must keep parameters for later use
					// when the asynchronous export will be ending
					
					// Keep the export file destination pathname
					$callback:=New object:C1471
					$callback.path:=$path
					$callback.areaName:=$area
					$callback.sheetIndex:=-2
					
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
					
					Case of 
							
							//……………………………………………………………………………………
						: ($pathObject.extension=".xlsx")
							
							$callback.command:="export-excel"
							$callback.password:=$params.password
							$callback.valuesOnly:=$params.valuesOnly
                            $callback.includeBindingSource:=$params.includeBindingSource
														
							//……………………………………………………………………………………
						: ($pathObject.extension=".pdf")
							
							$callback.command:="export-pdf"
							$callback.pdfOptions:=$params.pdfOptions
							If (OB Is defined:C1231($params; "sheetIndex"))
								$callback.sheetIndex:=$params.sheetIndex
							End if 
							
							//……………………………………………………………………………………
					End case 
					
					// check 
					If (OB Get type:C1230($callback; "sheetIndex")#Is real:K8:4)
						THROW(New object:C1471("code"; 21))
					Else 
						If ($callback.sheetIndex<-2)
							THROW(New object:C1471("code"; 17))
						Else 
							If ($callback.sheetIndex>=VP Get sheet count($area))
								THROW(New object:C1471("code"; 19))
							Else 
								
								// Launch export
								$documentObject:=vp_runFunction($area; $callback.command; $callback)
							End if 
						End if 
					End if 
					//______________________________________________________
				Else 
					
					// if not one of those extension, this is a csv export
					C_OBJECT:C1216($Obj_csvParams)
					$Obj_csvParams:=OB Copy:C1225($params)
					If ($Obj_csvParams.csvOptions=Null:C1517)
						$Obj_csvParams.csvOptions:=New object:C1471
					End if 
					
					If ($Obj_csvParams.csvOptions.range=Null:C1517)
						$Obj_csvParams.csvOptions.range:=VP All($area)
					End if 
					
					If (Value type:C1509($Obj_csvParams.csvOptions.range)#Is object:K8:27)
						THROW(New object:C1471("code"; 22))
					Else 
						// Gets the json description of the area content
						$documentObject:=vp_runFunction($area; "export-csv"; $Obj_csvParams.csvOptions)
						
						If (vp_continue)
							
							Case of 
									
									//………………………………………………………………………………………
								: ($documentObject=Null:C1517)
									
									THROW(New object:C1471(\
										"code"; 2; \
										"message"; "export-csv"))
									
									//………………………………………………………………………………………
								Else 
									
									If ($params.csvOptions.rowDelimiter=Null:C1517)
										TEXT TO DOCUMENT:C1237($path; $documentObject.csv; "UTF-8"; Document with CRLF:K24:20)
									Else 
										TEXT TO DOCUMENT:C1237($path; $documentObject.csv; "UTF-8"; Document unchanged:K24:18)
									End if 
									
									If (vp_continue)
										
										If ($params.formula#Null:C1517)
											
											$callback:=New object:C1471
											$callback.path:=$path
											$callback.command:="export-csv"
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
									
									//………………………………………………………………………………………
							End case 
						End if 
					End if 
			End case 
			
			If ((err.count#Null:C1517))
				
				// Main error
				THROW(New object:C1471(\
					"code"; 8; \
					"name"; Path to object:C1547($path).name))  // Cannot create file "{name}".
				
			End if 
		End if 
	End if 
	
	FINALLY
End if 
