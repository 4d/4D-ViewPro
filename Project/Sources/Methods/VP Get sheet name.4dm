//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get sheet name
// Database: 4D ViewPro
// ID[5101BAB9E3104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get sheet name
// ----------------------------------------------------
#DECLARE($area : Text; $index : Integer) : Text

If (False:C215)
	C_TEXT:C284(VP Get sheet name; $1)
	C_LONGINT:C283(VP Get sheet name; $2)
	C_TEXT:C284(VP Get sheet name; $0)
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
		
		$index:=Count parameters:C259>=2 ? $index : -1  // Default is current sheet
		$o:=vp_runFunction($area; "get-sheet-name"; {index: $index})
		
		//______________________________________________________
End case 

err_FINALLY

return String:C10($o.result)