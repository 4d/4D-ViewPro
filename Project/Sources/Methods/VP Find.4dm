//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Find
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: recompute formulas
// ----------------------------------------------------
// ----- Declarations
#DECLARE($ranges : Object; $searchValue : Text; $params : Object; $replaceValue : Text)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area : Text:=$ranges.area
		
		If ($params=Null:C1517)
			$params:=New object:C1471
		End if 
		
		If ($nbParameters>3)
			$params.replace:=$replaceValue
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			$params.range:=$ranges
			$params.find:=$searchValue
			$result:=vp_runFunction($area; "find"; $params)
		End if 
	End if 
	
	err_FINALLY
	
End if 