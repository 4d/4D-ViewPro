//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get row count
// Database: 4D ViewPro
// ID[5101BAB9E3104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get sheet row count
// ----------------------------------------------------
//----- Declarations

C_LONGINT:C283($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($area)
C_LONGINT:C283($Lon_sheetIndex)
C_LONGINT:C283($nbParameters)

If (False:C215)
	C_LONGINT:C283(VP Get row count; $0)
	C_TEXT:C284(VP Get row count; $1)
	C_LONGINT:C283(VP Get row count; $2)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			$Lon_sheetIndex:=$2
		Else 
			$Lon_sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params; $Obj_result)
			$params:=New object:C1471("sheetIndex"; $Lon_sheetIndex)
			
			$Obj_result:=vp_runFunction($area; "get-row-count"; $params)
			
			$0:=$Obj_result.result
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
