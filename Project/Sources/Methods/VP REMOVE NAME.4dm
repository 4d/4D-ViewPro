//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP REMOVE NAME
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: remove the given name in given scope
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $name : Text; $scope : Integer)




If (False:C215)
	C_TEXT:C284(VP REMOVE NAME; $1)
	C_TEXT:C284(VP REMOVE NAME; $2)
	C_LONGINT:C283(VP REMOVE NAME; $3)
End if 

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$scope:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			vp_runCommand($area; "remove-name"; {name: $name; scope: $scope})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 