//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP SET ROW ATTRIBUTES
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A124]
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Set the attributes of rows
  // ----------------------------------------------------
  // ----- Declarations

C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

If (False:C215)
	C_OBJECT:C1216(VP SET ROW ATTRIBUTES ;$1)
	C_OBJECT:C1216(VP SET ROW ATTRIBUTES ;$2)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges;$Obj_attributes)
C_TEXT:C284($area)

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (2;$nbParameters))
		
		$ranges:=$1
		$Obj_attributes:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				$params.ranges:=$ranges.ranges
				$params.attributes:=$Obj_attributes
				vp_runCommand ($area;"set-row-attributes";$params)
				
			End if 
			
		End if 
	End if 
	
	FINALLY 
	
End if 