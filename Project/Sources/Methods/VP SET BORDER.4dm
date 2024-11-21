//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET BORDER
// Database: 4D ViewPro
// ID[5101BDB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the border for a specified range
// ----------------------------------------------------
//----- Declarations
#DECLARE($range : Object; $border : Object; $option : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		var $area : Text:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				
				vp_runCommand($area; "set-border"; {ranges: $range.ranges; border: $border; option: $option})
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 