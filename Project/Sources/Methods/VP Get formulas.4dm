//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP Get formulas
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A124]
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Get the values of a range
  // ----------------------------------------------------
  // ----- Declarations

C_COLLECTION:C1488($0)
C_OBJECT:C1216($1)

If (False:C215)
	C_COLLECTION:C1488(VP Get values ;$0)
	C_OBJECT:C1216(VP Get values ;$1)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges)
C_TEXT:C284($area)

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (1;$nbParameters))
		
		$ranges:=$1
		$area:=$ranges.area
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				$params.ranges:=$ranges.ranges
				
				C_OBJECT:C1216($Obj)
				$Obj:=vp_runFunction ($area;"get-formulas";$params)
				
				If ($Obj#Null:C1517)
					If (Value type:C1509($Obj.value)=Is collection:K8:32)
						$0:=$obj.value
					End if 
				End if 
			End if 
		End if 
	End if 
	
	FINALLY 
	
End if 
