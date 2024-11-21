//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get spans
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: recompute formulas
// ----------------------------------------------------
// ----- Declarations
#DECLARE($ranges : Object)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				var $params:=New object:C1471()
				$params.ranges:=$ranges.ranges
				
				var $ret:=vp_runFunction($area; "get-spans"; $params)
				
				If (Value type:C1509($ret.ranges)=Is collection:K8:32)
					$ret.area:=$area
					$result:=$ret
				End if 
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 