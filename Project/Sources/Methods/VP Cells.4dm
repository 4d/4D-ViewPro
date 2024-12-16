//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Cells
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Create a target for a range of cells
// ----------------------------------------------------
#DECLARE($area : Text; $column : Integer; $row : Integer; $columnCount : Integer; $rowCount : Integer; $sheet : Integer) : Object

var $range : cs:C1710._range

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

$sheet:=Count parameters:C259<6 ? -1 : $sheet

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(5; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: ($column<0)
		
		err_THROW({code: 13 /*Column must be greater or equal than zero*/})
		
		//______________________________________________________
	: ($row<0)
		
		err_THROW({code: 14 /*Row must be greater or equal than zero*/})
		
		//______________________________________________________
	: ($columnCount<0)
		
		err_THROW({code: 15 /*Column count must be greater than zero*/})
		
		//______________________________________________________
	: ($rowCount<0)
		
		err_THROW({code: 16 /*Row count must be greater than zero*/})
		
		//______________________________________________________
	: ($sheet<(-1))
		
		err_THROW({code: 17 /*Sheet must be greater or equal than -2*/})
		
		//______________________________________________________
	Else 
		
		$range:=cs:C1710._range.new($area; $column; $row; $columnCount; $rowCount; $sheet)
		
		//______________________________________________________
End case 

err_FINALLY

return $range