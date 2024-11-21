//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET SHEET COLUMN COUNT
// Database: 4D ViewPro
// ID[EEEEC00482D14476A9E8216D7BAFDBF5]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet column count
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $columnCount : Integer; $sheetIndex : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "set-column-count"; {columnCount: $columnCount; sheetIndex: $sheetIndex})
			
		End if 
		
	End if 
	
	err_FINALLY
	
End if 