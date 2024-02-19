//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET SHEET NAME
// Database: 4D ViewPro
// ID[929476667B744BCC816509A8E1A4F566]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet name
// ----------------------------------------------------
#DECLARE($area : Text; $name : Text; $index : Integer)

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(2; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Not:C34(vp_isReady($area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	Else 
		
		$index:=Count parameters:C259>=3 ? $index : -1  // Default is current sheet
		vp_runCommand($area; "set-sheet-name"; {name: $name; index: $index})
		
		//______________________________________________________
End case 

err_FINALLY