//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET WORKBOOK OPTIONS
// Database: 4D ViewPro
// ID[FCC91304298446B492002638D5ABD1E8]
// Created #10-01-2020 by Francois Marchal
// ----------------------------------------------------
// Description: set workbook options
// ----------------------------------------------------
#DECLARE($area : Text; $options : Object)

If (False:C215)
	C_TEXT:C284(VP SET WORKBOOK OPTIONS; $1)
	C_OBJECT:C1216(VP SET WORKBOOK OPTIONS; $2)
End if 

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
		vp_make_picture($options; "backgroundImage")
		vp_runCommand($area; "set-workbook-options"; {options: $options})
		
		//______________________________________________________
End case 

err_FINALLY