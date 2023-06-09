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

C_OBJECT:C1216($1)
C_COLLECTION:C1488($2)

If (False:C215)
	C_OBJECT:C1216(VP SET FORMULAS; $1)
	C_COLLECTION:C1488(VP SET FORMULAS; $2)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges)
C_COLLECTION:C1488($Obj_values)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$ranges:=$1
		$Obj_values:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			If (Value type:C1509($Obj_values)=Is collection:K8:32)
				
				$params.value:=New collection:C1472
				C_LONGINT:C283($row; $col)
				
				For ($row; 0; $Obj_values.length-1)
					
					If (Value type:C1509($Obj_values[$row])=Is collection:K8:32)
						
						C_COLLECTION:C1488($colCollection)
						$colCollection:=New collection:C1472
						
						For ($col; 0; $Obj_values[$row].length-1)
							
							If (Value type:C1509($Obj_values[$row][$col])=Is text:K8:3)
								$colCollection.push($Obj_values[$row][$col])
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