//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get frozen panes
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get frozen panes
// ----------------------------------------------------
// ----- Declarations

C_TEXT:C284($1)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_LONGINT:C283($sheet)

If (False:C215)
	C_OBJECT:C1216(VP Get frozen panes; $0)
	C_TEXT:C284(VP Get frozen panes; $1)
	C_LONGINT:C283(VP Get frozen panes; $2)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		$area:=$1
		
		If ($nbParameters>1)
			$sheet:=$2
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			C_OBJECT:C1216($params)
			$params:=New object:C1471("sheetIndex"; $sheet)
			
			$0:=vp_runFunction($area; "get-frozen-panes"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 