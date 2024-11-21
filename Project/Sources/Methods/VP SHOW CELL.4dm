//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SHOW CELL
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #03-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// ----- Declarations
#DECLARE($ranges : Object; $verticalPosition : Integer; $horizontalPosition : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				
				var $params:=New object:C1471
				$params.ranges:=$ranges.ranges
				$params.verticalPosition:=$verticalPosition
				$params.horizontalPosition:=$horizontalPosition
				
				vp_runCommand($area; "show-cell"; $params)
			End if 
		End if 
	End if 
	err_FINALLY
End if 