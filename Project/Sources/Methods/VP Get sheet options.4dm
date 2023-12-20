//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP GET SHEET OPTIONS
// Database: 4D ViewPro
// ID[5101AAB9EE104650B8B96DB1D581A124]
// Created #10-01-2020 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet options
// ----------------------------------------------------
#DECLARE($area : Text; $index : Integer) : cs:C1710.sheetOptions

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP Get sheet options; $1)
	C_LONGINT:C283(VP Get sheet options; $2)
	C_OBJECT:C1216(VP Get sheet options; $0)
End if 

var $options : cs:C1710.sheetOptions

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(1; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Not:C34(vp_isReady($area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	Else 
		
		$index:=Count parameters:C259>=2 ? $index : -1  // Default is current sheet
		$options:=vp_runFunction($area; "get-sheet-options"; {index: $index})
		
		//______________________________________________________
End case 

err_FINALLY

return $options