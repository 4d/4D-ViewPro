//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get column attributes
// Database: 4D ViewPro
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get the attributes of columns
// ----------------------------------------------------
// ----- Declarations
#DECLARE($ranges : Object)->$result : Collection

$result:=[]

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(1; Count parameters:C259))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				
				var $ret:=vp_runFunction($area; "get-column-attributes"; {ranges: $ranges.ranges})
				$result:=$ret.value
				
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 