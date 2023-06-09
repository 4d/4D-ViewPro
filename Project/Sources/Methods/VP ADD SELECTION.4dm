//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP ADD SELECTION
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #03-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)

C_OBJECT:C1216($ranges)
C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_OBJECT:C1216($params)

If (False:C215)
	C_OBJECT:C1216(VP ADD SELECTION; $1)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$ranges:=$1
		$area:=$ranges.area
		
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				$params:=New object:C1471
				$params.ranges:=$ranges.ranges
				
				vp_runCommand($area; "add-selection"; $params)
			End if 
		End if 
	End if 
	err_FINALLY
End if 