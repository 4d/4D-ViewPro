//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $formulas : Object)

var $key; $spreadJSMethod : Text
var $i : Integer
var $arrayFormula; $customFunction; $o; $parameter; $schema : Object

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

If (Check_parameters_count(2; Count parameters:C259))
	
	// Mark:validation
	$schema:=JSON Parse:C1218(File:C1566("/RESOURCES/schemas/allowedFormulas.json").getText())
	
	If (JSON Validate:C1456($formulas; $schema).success)
		
		$o:=OBJECT Get value:C1743($area)
		
		If ($o=Null:C1517)
			
			$o:={}
			OBJECT SET VALUE:C1742($area; $o)
			
		End if 
		
		$o.ViewPro:=$o.ViewPro || {}
		$o.ViewPro.formulas:=$o.ViewPro.formulas || {}
		$o.ViewPro.formulas.array:=[]
		$o.ViewPro.formulas.map:={}
		
		ARRAY TEXT:C222($properties; 0x0000)
		OB GET PROPERTY NAMES:C1232($formulas; $properties)
		
		For ($i; 1; Size of array:C274($properties); 1)
			
			$customFunction:=$formulas[$properties{$i}]
			
			// Mark:formula
			$arrayFormula:={}
			$o.ViewPro.formulas.array.push($arrayFormula)
			
			$spreadJSMethod:=Uppercase:C13($properties{$i})
			$arrayFormula.spreadJSMethod:=$spreadJSMethod
			$o.ViewPro.formulas.map[$spreadJSMethod]:=($customFunction.formula.source=Null:C1517) ? $customFunction.formula : OB Copy:C1225($customFunction.formula)
			
			// Mark:summary, minParams, maxParams
			For each ($key; ["summary"; "minParams"; "maxParams"])
				
				If ($customFunction[$key]=Null:C1517)
					
					continue
					
				End if 
				
				$arrayFormula[$key]:=$customFunction[$key]
				
			End for each 
			
			If ($customFunction.parameters=Null:C1517)
				
				continue
				
			End if 
			
			// Mark:parameters
			$arrayFormula.parameters:=[]
			$arrayFormula.parametersType:=[]
			
			For each ($parameter; $customFunction.parameters)
				
				$arrayFormula.parameters.push({name: $parameter.name})
				
				// FIXME:On ne gère pas d'erreur si le type n'est pas implémenté ?
				// Je voulais mettre un flag pour accepter les objets et les collections mais nada
				
				$arrayFormula.parametersType.push($parameter.type ? $parameter.type : -1)
				
			End for each 
		End for 
	End if 
End if 

err_FINALLY