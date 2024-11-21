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

C_OBJECT:C1216($0)
C_OBJECT:C1216($1)
C_TEXT:C284($2)
C_OBJECT:C1216($3)
C_TEXT:C284($4)



C_OBJECT:C1216($params)

If (False:C215)
	C_OBJECT:C1216(VP Find; $0)
	C_OBJECT:C1216(VP Find; $1)
	C_TEXT:C284(VP Find; $2)
	C_OBJECT:C1216(VP Find; $3)
	C_TEXT:C284(VP Find; $4)
End if 

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area : Text:=$1.area
		
		If ($nbParameters>2)
			$params:=$3
		Else 
			$params:=New object:C1471
		End if 
		
		If ($nbParameters>3)
			$params.replace:=$4
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			$params.range:=$1
			$params.find:=$2
			$0:=vp_runFunction($area; "find"; $params)
		End if 
	End if 
	
	err_FINALLY
	
End if 