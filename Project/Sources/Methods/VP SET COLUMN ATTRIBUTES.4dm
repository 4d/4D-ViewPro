//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET COLUMN ATTRIBUTES
// Database: 4D ViewPro
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the attributes of columns
// ----------------------------------------------------
// ----- Declarations
#DECLARE($ranges : Object; $attributes : Object)

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(2; Count parameters:C259))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				
				vp_runCommand($area; "set-column-attributes"; {ranges: $ranges.ranges; attributes: $attributes})
				
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 