//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get sheet index
// Database: 4D ViewPro
// ID[5101BAB9E3104650B8B96DB1D501A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get sheet index by name
// ----------------------------------------------------
//----- Declarations

C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($area)
C_TEXT:C284($Txt_sheetName)
C_LONGINT:C283($nbParameters)

If (False:C215)
	C_LONGINT:C283(VP Get sheet index; $0)
	C_TEXT:C284(VP Get sheet index; $1)
	C_TEXT:C284(VP Get sheet index; $2)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$Txt_sheetName:=$2
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params; $Obj_result)
			$params:=New object:C1471("name"; $Txt_sheetName)
			
			$Obj_result:=vp_runFunction($area; "get-sheet-index"; $params)
			
			$0:=$Obj_result.result
		End if 
		
	End if 
	
	err_FINALLY
	
End if 
