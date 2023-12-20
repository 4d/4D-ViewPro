//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get sheet count
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get the number of sheets
// ----------------------------------------------------
#DECLARE($area : Text) : Integer

If (False:C215)
	C_TEXT:C284(VP Get sheet count; $1)
	C_LONGINT:C283(VP Get sheet count; $0)
End if 

var $o : Object

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
		
		$o:=vp_runFunction($area; "get-sheet-count")
		
		//______________________________________________________
End case 

err_FINALLY

return Num:C11($o.result)