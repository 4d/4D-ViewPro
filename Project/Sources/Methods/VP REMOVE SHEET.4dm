//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP REMOVE SHEET
// Database: 4D ViewPro
// ID[5101AAB9EE104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: remove sheet
// ----------------------------------------------------
#DECLARE($area : Text; $index : Integer)

If (False:C215)
	C_TEXT:C284(VP REMOVE SHEET; $1)
	C_LONGINT:C283(VP REMOVE SHEET; $2)
End if 

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
	: ($index>=VP Get sheet count($area))
		
		// FIXME:ERROR
		//______________________________________________________
	Else 
		
		$index:=Count parameters:C259>=2 ? $index : -1
		vp_runCommand($area; "remove-sheet"; {index: $index})
		
		//______________________________________________________
End case 

err_FINALLY