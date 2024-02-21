//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get formula by name
// Database: 4D ViewPro
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: retrieve the formula associated with a name
// ----------------------------------------------------
#DECLARE($area : Text; $name : Text; $scope : Integer) : Object

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
	: (Not:C34(vp_isReady($area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	Else 
		
		$scope:=Count parameters:C259=3 ? $scope : vk current sheet:K89:3  // Default=current sheet
		$o:=vp_runFunction($area; "get-formula-by-name"; {name: $name; scope: $scope})
		
		//______________________________________________________
End case 

err_FINALLY

return OB Is empty:C1297($o) ? Null:C1517 : $o