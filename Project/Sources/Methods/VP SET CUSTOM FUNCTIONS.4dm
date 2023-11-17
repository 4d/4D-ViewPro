//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $formulas : Object)

If (False:C215)
	C_TEXT:C284(VP SET CUSTOM FUNCTIONS; $1)
	C_OBJECT:C1216(VP SET CUSTOM FUNCTIONS; $2)
End if 

var $key; $spreadJSMethod : Text
var $i : Integer
var $arrayFormula; $formula; $o; $parameter; $result; $schema : Object

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

If (Check_parameters_count(2; Count parameters:C259))
	$schema:=JSON Parse:C1218(File:C1566("/RESOURCES/schemas/allowedFormulas.json").getText())
	$result:=JSON Validate:C1456($formulas; $schema)
	
	If ($result.success)
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
			
			$formula:=$formulas[$properties{$i}]
			
			$arrayFormula:={}
			$o.ViewPro.formulas.array.push($arrayFormula)
			
			$spreadJSMethod:=Uppercase:C13($properties{$i})
			$arrayFormula.spreadJSMethod:=$spreadJSMethod
			$o.ViewPro.formulas.map[$spreadJSMethod]:=OB Copy:C1225($formula.formula)
			
			For each ($key; ["summary"; "minParams"; "maxParams"])
				
				If ($formula[$key]=Null:C1517)
					continue
					
				End if 
				
				$arrayFormula[$key]:=$formula[$key]
				
			End for each 
			
			If ($formula.parameters=Null:C1517)
				
				continue
				
			End if 
			
			$arrayFormula.parameters:=[]
			
			$arrayFormula.parametersType:=[]
			
			For each ($parameter; $formula.parameters)
				
				$arrayFormula.parameters.push({name: $parameter.name})
				$arrayFormula.parametersType.push($parameter.type ? $parameter.type : -1)
				
			End for each 
		End for 
	End if 
End if 

err_FINALLY