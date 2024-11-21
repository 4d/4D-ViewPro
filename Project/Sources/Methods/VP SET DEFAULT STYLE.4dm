//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET DEFAULT STYLE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the default style for a specified sheet
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $stylesheet : Object; $sheetIndex : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "set-default-style"; {stylesheet: vp_convert_to_stylesheet($stylesheet); sheetIndex: $sheetIndex})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 