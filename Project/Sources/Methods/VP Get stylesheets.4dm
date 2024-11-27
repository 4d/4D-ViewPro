//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get stylesheets
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get list of stylesheets for a specified sheet or for the whole workbook
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $sheetIndex : Integer)->$result : Collection

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $Obj_result:=vp_runFunction($area; "get-stylesheets"; {sheetIndex: $sheetIndex})
			
			$result:=$Obj_result.collection.map(Formula:C1597(vp_convert_from_stylesheet($1.value)))
			
		End if 
	End if 
	
	err_FINALLY
	
End if 