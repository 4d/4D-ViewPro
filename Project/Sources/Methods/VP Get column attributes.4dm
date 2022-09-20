//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP Get column attributes
  // Database: 4D ViewPro
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Get the attributes of columns
  // ----------------------------------------------------
  // ----- Declarations

C_COLLECTION:C1488($0)
C_OBJECT:C1216($1)

If (False:C215)
	C_COLLECTION:C1488(VP Get column attributes ;$0)
	C_OBJECT:C1216(VP Get column attributes ;$1)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges)
C_TEXT:C284($area)

$0:=New collection:C1472()

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
				C_OBJECT:C1216($ret)
				$ret:=vp_runFunction ($area;"get-column-attributes";$params)
				$0:=$ret.value
			End if 
			
		End if 
	End if 
	
	FINALLY 
	
End if 