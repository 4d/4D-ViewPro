//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP ADD STYLE SHEET
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Add a style sheet for a specified sheet or for the whole workbook
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $name : Text; $stylesheet : Object; $sheetIndex : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		If ($nbParameters<4)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "add-stylesheet"; {name: $name; stylesheet: vp_convert_to_stylesheet($stylesheet); sheetIndex: $sheetIndex})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 