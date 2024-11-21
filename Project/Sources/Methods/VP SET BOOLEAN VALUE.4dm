//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET BOOLEAN VALUE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set a boolean value of a range
// ----------------------------------------------------
// ----- Declarations
#DECLARE($cell : Object; $value : Boolean)

var $nbParameters:=Count parameters:C259

err_TRY

If (Check_parameters_count(2; $nbParameters))
	
	VP SET VALUE($cell; {value: $value})
	
End if 

err_FINALLY
