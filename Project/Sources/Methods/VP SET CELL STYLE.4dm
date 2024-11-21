//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET DEFAULT STYLE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the style for a specified range
// ----------------------------------------------------
//----- Declarations
#DECLARE($cell : Object; $style : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area : Text:=$cell.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($cell.ranges)=Is collection:K8:32)
				
				vp_runCommand($area; "set-cell-style"; {ranges: $cell.ranges; style: vp_convert_to_stylesheet($style)})
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 