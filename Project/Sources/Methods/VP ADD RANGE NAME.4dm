//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP ADD RANGE NAME
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Add a custom name for a specified target
// target can be a cell, a range, a column or a row, or any formula
// ----------------------------------------------------
//----- Declarations
#DECLARE($range : Object; $name : Text; $options : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$options:=New object:C1471("scope"; -1)
		End if 
		
		If (vp_isReady($range.area; Current method name:C684))
			
			var $params:=New object:C1471()
			$params.ranges:=$range.ranges
			$params.name:=$name
			$params.options:=$options
			
			vp_runCommand($range.area; "add-range-name"; $params)
			
		End if 
		
	End if 
	
	err_FINALLY
	
End if 