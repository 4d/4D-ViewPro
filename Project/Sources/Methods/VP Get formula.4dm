//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get formula
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get the formula of a cell
// ----------------------------------------------------
// ----- Declarations
#DECLARE($ranges : Object)->$result : Text

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				
				var $Obj_returned:=vp_runFunction($area; "get-formula"; {ranges: $ranges.ranges})
				$result:=$Obj_returned.value
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 
