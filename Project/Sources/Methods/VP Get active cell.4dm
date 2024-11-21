//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get active cell
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #03-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description:
// Returns the active cell object
// ----------------------------------------------------
#DECLARE($area : Text; $sheet : Integer) : Object

var $cell; $o : Object

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

$sheet:=Count parameters:C259<2 ? -1 : $sheet

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
		
		$o:=vp_runFunction($area; "get-active-cell"; {sheetIndex: $sheet})
		
		If (Value type:C1509($o.column)=Is real:K8:4)
			
			$cell:=cs:C1710._cell.new($area; $o.column; $o.row; $o.sheetIndex)
			
		End if 
		
		//______________________________________________________
End case 

err_FINALLY

return $cell