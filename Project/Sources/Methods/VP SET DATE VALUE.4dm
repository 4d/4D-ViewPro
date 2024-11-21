//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET DATE VALUE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set a date value of a range
// ----------------------------------------------------
// ----- Declarations
#DECLARE($cell : Object; $date : Date; $format : Text)

var $nbParameters:=Count parameters:C259

err_TRY

If (Check_parameters_count(2; $nbParameters))
	
	var $obj:=New object:C1471("value"; $date)
	
	If ($nbParameters>2)
		$obj.format:=$format
	Else 
		$obj.format:="_shortDatePattern_"
	End if 
	
	VP SET VALUE($cell; $obj)
	
End if 

err_FINALLY
