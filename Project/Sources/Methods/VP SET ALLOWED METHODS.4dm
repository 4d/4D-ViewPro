//%attributes = {"invisible":true,"shared":true}
#DECLARE($methods : Object)

If (False:C215)
	C_OBJECT:C1216(VP SET ALLOWED METHODS; $1)
End if 

var $key; $name : Text

var $i : Integer
var $method; $parameter; $result; $schema; $sharedMethod; $sharedParameter : Object

err_TRY

If (Check_parameters_count(1; Count parameters:C259))
	
	$schema:=JSON Parse:C1218(File:C1566("/RESOURCES/schemas/allowedMethods.json").getText())
	$result:=JSON Validate:C1456($methods; $schema)
	
	If ($result.success)
		
		Use (Storage:C1525)
			
			Storage:C1525.allowedMethods:=Storage:C1525.allowedMethods || New shared collection:C1527()
			
			Use (Storage:C1525.allowedMethods)
				
				Storage:C1525.allowedMethods.clear()
				
				ARRAY TEXT:C222($properties; 0x0000)
				OB GET PROPERTY NAMES:C1232($methods; $properties)
				
				For ($i; 1; Size of array:C274($properties); 1)
					
					$name:=$properties{$i}
					$method:=$methods[$name]
					
					$sharedMethod:=New shared object:C1526()
					
					Storage:C1525.allowedMethods.push($sharedMethod)
					
					Use ($sharedMethod)
						
						$sharedMethod.spreadJSMethod:=Uppercase:C13($name)
						$sharedMethod.method:=$method.method
						
						For each ($key; ["summary"; "minParams"; "maxParams"])
							
							If ($method[$key]=Null:C1517)
								
								continue
								
							End if 
							
							$sharedMethod[$key]:=$method[$key]
							
						End for each 
						
						If ($method.parameters#Null:C1517)
							
							$sharedMethod.parameters:=New shared collection:C1527
							$sharedMethod.parametersType:=New shared collection:C1527
							
							Use ($sharedMethod.parameters)
								
								Use ($sharedMethod.parametersType)
									
									For each ($parameter; $method.parameters)
										
										$sharedParameter:=New shared object:C1526
										
										Use ($sharedParameter)
											
											$sharedParameter.name:=$parameter.name
											$sharedMethod.parametersType.push($parameter.type ? $parameter.type : -1)
											$sharedMethod.parameters.push($sharedParameter)
											
										End use 
									End for each 
								End use 
							End use 
						End if 
					End use 
				End for 
			End use 
		End use 
	End if 
End if 

err_FINALLY