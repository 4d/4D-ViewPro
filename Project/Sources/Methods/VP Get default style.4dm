//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get default style
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get the default style for a specified sheet
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $sheetIndex : Integer) : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $stylesheet:=vp_runFunction($area; "get-default-style"; {sheetIndex: $sheetIndex})
			
			return vp_convert_from_stylesheet($stylesheet)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 