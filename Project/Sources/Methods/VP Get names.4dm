//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get custom name infos
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: return infos on a custom name
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $scope : Integer)->$result : Collection

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			
			$scope:=-1
			
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $Obj_result:=vp_runFunction($area; "get-names"; {scope: $scope})
			
			$result:=$Obj_result.collection
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
