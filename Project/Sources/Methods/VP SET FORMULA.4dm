//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET FORMULA
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the formula of a range
// ----------------------------------------------------
#DECLARE($cell : cs:C1710._cell; $formula : Text; $format : Text)

var $o : Object

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(2; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Not:C34(vp_isReady($cell.area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Value type:C1509($cell.ranges)#Is collection:K8:32)
		
		// ERROR
		//______________________________________________________
	Else 
		
		$o:={\
			ranges: $cell.ranges; \
			formula: $formula\
			}
		
		// Optional format
		If (Length:C16($format)>0)
			
			$o.format:=$format
			
		End if 
		
		vp_runCommand($cell.area; "set-ranges-formula"; $o)
		
		//______________________________________________________
End case 

err_FINALLY