//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP ADD SHEET
// Database: 4D ViewPro
// ID[E97B695A4C07466CA399BB6A5BB38A3B]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: add a sheet
// ----------------------------------------------------
#DECLARE($area : Text; $index : Integer; $name : Text)

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
		
		$index:=Count parameters:C259>=2 ? $index : 9999
		vp_runCommand($area; "add-sheet"; {name: $name; index: $index})
		
		//______________________________________________________
End case 

err_FINALLY