//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get row attributes
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get the attributes of rows
// ----------------------------------------------------
// ----- Declarations
#DECLARE($range : Object)->$result : Collection

$result:=[]

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				
				var $ret:=vp_runFunction($area; "get-row-attributes"; {ranges: $range.ranges})
				$result:=$ret.value
				
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
