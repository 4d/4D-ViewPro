//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get style sheet
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get a style sheet for a specified sheet or for the whole workbook
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $name : Text; $sheetIndex : Integer)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $stylesheet:=vp_runFunction($area; "get-stylesheet"; {name: $name; sheetIndex: $sheetIndex})
			
			$result:=vp_convert_from_stylesheet($stylesheet)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 