//%attributes = {"invisible":true,"shared":true}
C_OBJECT:C1216($1)
C_OBJECT:C1216($methods)

$methods:=$1

err_TRY

If (Check_parameters_count(1; Count parameters:C259))
	
	C_OBJECT:C1216($result; $schema)
	$schema:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"schemas"+Folder separator:K24:12+"allowedMethods.json"))
	
	$result:=JSON Validate:C1456($methods; $schema)
	
	If ($result.success)
		
		Use (Storage:C1525)
			
			If (Storage:C1525.allowedMethods=Null:C1517)
				Storage:C1525.allowedMethods:=New shared collection:C1527()
			End if 
			
			Use (Storage:C1525.allowedMethods)
				
				Storage:C1525.allowedMethods.clear()
				
				ARRAY TEXT:C222($properties; 0)
				OB GET PROPERTY NAMES:C1232($methods; $properties)
				C_LONGINT:C283($i; $j)
				C_OBJECT:C1216($sharedMethod; $sharedParameter; $method; $parameter)
				
				For ($i; 1; Size of array:C274($properties))
					
					$method:=$methods[$properties{$i}]
					
					$sharedMethod:=New shared object:C1526()
					
					Storage:C1525.allowedMethods.push($sharedMethod)
					
					Use ($sharedMethod)
						$sharedMethod.spreadJSMethod:=Uppercase:C13($properties{$i})
						$sharedMethod.method:=$method.method
						
						If (OB Is defined:C1231($method; "summary"))
							$sharedMethod.summary:=$method.summary
						End if 
						
						If (OB Is defined:C1231($method; "minParams"))
							$sharedMethod.minParams:=$method.minParams
						End if 
						
						If (OB Is defined:C1231($method; "maxParams"))
							$sharedMethod.maxParams:=$method.maxParams
						End if 
						
						If (OB Is defined:C1231($method; "parameters"))
							
							$sharedMethod.parameters:=New shared collection:C1527
							$sharedMethod.parametersType:=New shared collection:C1527
							
							Use ($sharedMethod.parameters)
								
								Use ($sharedMethod.parametersType)
									
									For ($j; 0; $method.parameters.length-1)
										
										$parameter:=$method.parameters[$j]
										
										$sharedParameter:=New shared object:C1526
										
										Use ($sharedParameter)
											
											$sharedParameter.name:=$parameter.name
											
											If (OB Is defined:C1231($parameter; "type"))
												$sharedMethod.parametersType.push($parameter.type)
											Else 
												$sharedMethod.parametersType.push(-1)
											End if 
											
											$sharedMethod.parameters.push($sharedParameter)
											
										End use   // Use ($sharedParameter)
										
									End for   // For ($j;0;$method.parameters.length-1)
								End use   // Use ($sharedMethod.parametersType)
							End use   // Use ($sharedMethod.parameters)
						End if   // If (OB Is defined($method;"parameters"))
					End use   // Use ($sharedMethod)
				End for   // For ($i;1;Size of array($properties))
			End use   // Use (Storage.allowedMethods)
		End use 
	End if   // If ($result.success)
End if   // If (Check_parameters_count (1;Count parameters))

err_FINALLY