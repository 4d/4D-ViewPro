//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET FORMULAS
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the formulas for a range
// ----------------------------------------------------
// ----- Declarations
#DECLARE($ranges : Object; $values : Collection)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($values)=Is collection:K8:32)
				
				var $params:=New object:C1471()
				$params.value:=New collection:C1472
				var $row; $col : Integer
				
				For ($row; 0; $values.length-1)
					
					If (Value type:C1509($values[$row])=Is collection:K8:32)
						
						var $colCollection:=New collection:C1472
						
						For ($col; 0; $values[$row].length-1)
							
							If (Value type:C1509($values[$row][$col])=Is text:K8:3)
								$colCollection.push($values[$row][$col])
							Else 
								$colCollection.push("")
							End if 
						End for 
						
						$params.value.push($colCollection)
					Else 
						$params.value.push(Null:C1517)
					End if 
				End for 
				
				If (OB Is defined:C1231($params; "value"))
					
					If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
						$params.ranges:=$ranges.ranges
						
						vp_runCommand($area; "set-formulas"; $params)
						
					End if 
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 