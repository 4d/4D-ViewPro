//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : VP SUSPEND CALCULATION
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: recompute formulas
// ----------------------------------------------------
// ----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($0)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)

If (False:C215)
	C_TEXT:C284(VP Copy; $1)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		$area:=$1
		
		If (vp_isReady($area; Current method name:C684))
			C_OBJECT:C1216($params)
			$0:=vp_runFunction($area; "copy-data"; $params)
		End if 
	End if 
	
	FINALLY
	
End if 