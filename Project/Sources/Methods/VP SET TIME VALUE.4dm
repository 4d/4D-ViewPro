//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET TIME VALUE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set a time value of a range
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)
C_TIME:C306($2)



If (False:C215)
	C_OBJECT:C1216(VP SET TIME VALUE; $1)
	C_TIME:C306(VP SET TIME VALUE; $2)
	C_TEXT:C284(VP SET TIME VALUE; $3)
End if 

var $nbParameters:=Count parameters:C259

err_TRY

If (Check_parameters_count(2; $nbParameters))
	
	C_OBJECT:C1216($obj)
	$obj:=New object:C1471("time"; $2)
	
	If ($nbParameters>2)
		$obj.format:=$3
	Else 
		$obj.format:="_longTimePattern_"
	End if 
	
	VP SET VALUE($1; $obj)
	
End if 

err_FINALLY
