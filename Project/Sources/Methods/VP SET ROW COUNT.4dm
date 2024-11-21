//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET ROW COUNT
// Database: 4D ViewPro
// ID[37E09C4EE44C4B19A4C8BB90D7548206]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet name
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $rowCount : Integer; $sheetIndex : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "set-row-count"; {rowCount: $rowCount; sheetIndex: $sheetIndex})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 