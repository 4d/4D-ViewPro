//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP get value
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A124]
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Set the value of a range
  // ----------------------------------------------------
  // ----- Declarations

C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

If (False:C215)
	C_OBJECT:C1216(VP get value ;$0)
	C_OBJECT:C1216(VP get value ;$1)
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
				
				C_OBJECT:C1216($obj)
				$obj:=vp_runFunction ($area;"get-value";$params)
				
				If ($obj#Null:C1517)
					If (Value type:C1509($obj.value)=Is object:K8:27)
						If ($obj.value.date#Null:C1517)
							$obj.time:=$obj.value.time
							$obj.value:=Add to date:C393(!00-00-00!;$obj.value.date.year;$obj.value.date.month;$obj.value.date.day)
						End if 
					End if 
				End if 
				
				$0:=$obj
			End if 
		End if 
	End if 
	
	FINALLY 
	
End if 