//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP COLUMN aAUTOFIT
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Autofit the specified columns
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)

If (False:C215)
	C_OBJECT:C1216(VP COLUMN AUTOFIT; $1)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges)
C_TEXT:C284($area)

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
				vp_runFunction($area; "column-autofit"; $params)
				
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 