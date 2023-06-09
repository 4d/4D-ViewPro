//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP REMOVE SPAN
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: recompute formulas
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges)
C_TEXT:C284($area)

If (False:C215)
	C_OBJECT:C1216(VP REMOVE SPAN; $1)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$ranges:=$1
		$area:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				$params.ranges:=$ranges.ranges
				
				vp_runCommand($area; "remove-span"; $params)
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 