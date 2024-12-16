//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : VP Run function
// Database: 4D ViewPro
// ID[43EC6B2DA66549A6B529347173AC6025]
// Created #5-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description:
// Ask JS to run a command
// ----------------------------------------------------
#DECLARE($area : Text; $command : Text; $params : Object) : Object

var $o : Object

Case of 
		
	: (Not:C34(Check_parameters_count(2; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	Else 
		
		vp_FLUSH($area)
		
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; $area; "runCommand"; $o; $command; $params || {})
		
		Case of 
				
				//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
			: ($o=Null:C1517)
				
				err_THROW({code: 23 /*No data retrieved, possibly a timeout (suspension or breakpoint)*/})
				
				return 
				
				//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
			: (Length:C16($o.error)>0)
				
				err_THROW({code: 2; message: $o.error})
				
				return 
				
				//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
		End case 
		
		return Value type:C1509($o.result)=Is object:K8:27 ? $o.result : Null:C1517
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
End case 