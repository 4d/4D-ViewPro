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
#DECLARE($ranges : Object)->$result : Collection

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				
				var $Obj:=vp_runFunction($area; "get-formulas"; {ranges: $ranges.ranges})
				
				If ($Obj#Null:C1517)
					If (Value type:C1509($Obj.value)=Is collection:K8:32)
						$result:=$obj.value
					End if 
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 
