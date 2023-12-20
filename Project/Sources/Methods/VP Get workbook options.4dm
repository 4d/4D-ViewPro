//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP GET SHEET OPTIONS
// Database: 4D ViewPro
// ID[EE3F5DCA83514676B97195FF9595BE58]
// Created #10-01-2020 by Francois Marchal
// ----------------------------------------------------
// Description: Get woorkbook options
// ----------------------------------------------------
#DECLARE($area : Text) : cs:C1710.workbookOptions

If (False:C215)
	C_TEXT:C284(VP Get workbook options; $1)
	C_OBJECT:C1216(VP Get workbook options; $0)
End if 

var $options : cs:C1710.workbookOptions

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
		
		$options:=vp_runFunction($area; "get-workbook-options")
		
		//______________________________________________________
End case 

err_FINALLY

return $options