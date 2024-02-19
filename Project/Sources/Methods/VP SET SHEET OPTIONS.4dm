//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET SHEET OPTIONS
// Database: 4D ViewPro
// ID[27970BF62E424B948CFB2B43A7F34969]
// Created #10-01-2020 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet options
// ----------------------------------------------------
#DECLARE($area : Text; $options : Object; $index : Integer)

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
		
		$options:=OB Copy:C1225($options)
		$index:=Count parameters:C259>=3 ? $index : -1  // Default is current sheet
		vp_runCommand($area; "set-sheet-options"; {options: $options; index: $index})
		
		//______________________________________________________
End case 

err_FINALLY