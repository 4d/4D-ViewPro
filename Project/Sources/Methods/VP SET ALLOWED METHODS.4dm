//%attributes = {"invisible":true,"shared":true}
#DECLARE($methods : Object)

var $functionName; $key : Text
var $i : Integer
var $o; $parameter; $schema; $sharedMethod; $sharedParameter : Object

err_TRY

If (Check_parameters_count(1; Count parameters:C259))
	
	// Mark:validation
	$schema:=JSON Parse:C1218(File:C1566("/RESOURCES/schemas/allowedMethods.json").getText())
	
	If (JSON Validate:C1456($methods; $schema).success)
		
		Use (Storage:C1525)
			
			Storage:C1525.allowedMethods:=Storage:C1525.allowedMethods || New shared collection:C1527()
			
			Use (Storage:C1525.allowedMethods)
				
				Storage:C1525.allowedMethods.clear()
				
				ARRAY TEXT:C222($properties; 0x0000)
				OB GET PROPERTY NAMES:C1232($methods; $properties)
				
				For ($i; 1; Size of array:C274($properties); 1)
					
					$functionName:=$properties{$i}
					$o:=$methods[$functionName]
					$sharedMethod:=New shared object:C1526()
					
					Storage:C1525.allowedMethods.push($sharedMethod)
					
					Use ($sharedMethod)
						
						$sharedMethod.spreadJSMethod:=Uppercase:C13($functionName)
						$sharedMethod.method:=$o.method
						
						// Mark:summary, minParams, maxParams
						For each ($key; ["summary"; "minParams"; "maxParams"])
							
							If ($o[$key]=Null:C1517)
								
								continue
								
							End if 
							
							$sharedMethod[$key]:=$o[$key]
							
						End for each 
						
						If ($o.parameters=Null:C1517)
							
							continue
							
						End if 
						
						// Mark:parameters
						
						$sharedMethod.parameters:=New shared collection:C1527
						$sharedMethod.parametersType:=New shared collection:C1527
						
						Use ($sharedMethod.parameters)
							
							Use ($sharedMethod.parametersType)
								
								For each ($parameter; $o.parameters)
									
									$sharedParameter:=New shared object:C1526
									
									Use ($sharedParameter)
										
										$sharedParameter.name:=$parameter.name
										
										// FIXME:On ne gère pas d'erreur si le type n'est pas implémenté ?
										// Je voulais mettre un flag pour accepter les objets et les collections mais nada
										
										$sharedMethod.parametersType.push($parameter.type ? $parameter.type : -1)
										$sharedMethod.parameters.push($sharedParameter)
										
									End use 
								End for each 
							End use 
						End use 
					End use 
				End for 
			End use 
		End use 
	End if 
End if 

err_FINALLY