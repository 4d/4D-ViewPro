//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($1)
C_TEXT:C284($area)

C_OBJECT:C1216($2)
C_OBJECT:C1216($formulas)

$area:=$1
$formulas:=$2

If (vp_initStorage)
	
	TRY
	
	If (Check_parameters_count(2; Count parameters:C259))
		
		C_OBJECT:C1216($result; $schema)
		$schema:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"schemas"+Folder separator:K24:12+"allowedFormulas.json"))
		
		$result:=JSON Validate:C1456($formulas; $schema)
		
		If ($result.success)
			
			C_OBJECT:C1216($obj)
			
			$obj:=OBJECT Get value:C1743($area)
			
			If ($obj=Null:C1517)
				$obj:=New object:C1471
				OBJECT SET VALUE:C1742($area; $obj)
			End if 
			
			If ($obj.ViewPro=Null:C1517)
				$obj.ViewPro:=New object:C1471
			End if 
			
			If ($obj.ViewPro.formulas=Null:C1517)
				$obj.ViewPro.formulas:=New object:C1471
			End if 
			
			$obj.ViewPro.formulas.array:=New collection:C1472()
			$obj.ViewPro.formulas.map:=New object:C1471()
			
			ARRAY TEXT:C222($properties; 0)
			OB GET PROPERTY NAMES:C1232($formulas; $properties)
			C_LONGINT:C283($i; $j)
			C_OBJECT:C1216($arrayFormula; $arrayParameter; $formula; $parameter)
			C_TEXT:C284($spreadJSMethod)
			
			For ($i; 1; Size of array:C274($properties))
				
				$formula:=$formulas[$properties{$i}]
				
				$arrayFormula:=New object:C1471()
				
				$obj.ViewPro.formulas.array.push($arrayFormula)
				$spreadJSMethod:=Uppercase:C13($properties{$i})
				$arrayFormula.spreadJSMethod:=$spreadJSMethod
				$obj.ViewPro.formulas.map[$spreadJSMethod]:=OB Copy:C1225($formula.formula)
				
				If (OB Is defined:C1231($formula; "summary"))
					$arrayFormula.summary:=$formula.summary
				End if 
				
				If (OB Is defined:C1231($formula; "minParams"))
					$arrayFormula.minParams:=$formula.minParams
				End if 
				
				If (OB Is defined:C1231($formula; "maxParams"))
					$arrayFormula.maxParams:=$formula.maxParams
				End if 
				
				If (OB Is defined:C1231($formula; "parameters"))
					
					$arrayFormula.parameters:=New collection:C1472
					$arrayFormula.parametersType:=New collection:C1472
					
					For ($j; 0; $formula.parameters.length-1)
						
						$parameter:=$formula.parameters[$j]
						
						$arrayParameter:=New object:C1471
						
						$arrayParameter.name:=$parameter.name
						
						If (OB Is defined:C1231($parameter; "type"))
							$arrayFormula.parametersType.push($parameter.type)
						Else 
							$arrayFormula.parametersType.push(-1)
						End if 
						
						$arrayFormula.parameters.push($arrayParameter)
						
					End for   // For ($j;0;$formula.parameters.length-1)
				End if   // If (OB Is defined($formula;"parameters"))
			End for   // For ($i;1;Size of array($properties))
		End if   // If ($result.success)
	End if   // If (Check_parameters_count (1;Count parameters))
	
	FINALLY
	
End if 