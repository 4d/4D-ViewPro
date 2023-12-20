//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP cell
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Creates a target for a single cell
// ----------------------------------------------------
#DECLARE($area : Text; $column : Integer; $row : Integer; $sheet : Integer) : cs:C1710._cell

If (False:C215)
	C_TEXT:C284(VP Cell; $1)
	C_LONGINT:C283(VP Cell; $2)
	C_LONGINT:C283(VP Cell; $3)
	C_LONGINT:C283(VP Cell; $4)
	C_OBJECT:C1216(VP Cell; $0)
End if 

var $cell : cs:C1710._cell

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

$sheet:=Count parameters:C259<4 ? -1 : $sheet

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(3; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: ($column<0)
		
		err_THROW({code: 13})
		
		//______________________________________________________
	: ($row<0)
		
		err_THROW({code: 14})
		
		//______________________________________________________
	: ($sheet<-1)
		
		err_THROW({code: 17})
		
		//______________________________________________________
	Else 
		
		$cell:=cs:C1710._cell.new($area; $column; $row; $sheet)
		
		//______________________________________________________
End case 

err_FINALLY

return $cell