//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get current sheet
// Database: 4D ViewPro
// ID[5101BAB9E3104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get the current sheet index
// ----------------------------------------------------
#DECLARE($area : Text) : Integer

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
		
		$o:=vp_runFunction($area; "get-current-sheet")
		
		//______________________________________________________
End case 

err_FINALLY

return Num:C11($o.result)