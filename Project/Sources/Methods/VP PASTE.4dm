//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : VP PASTE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #28-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: recompute formulas
// ----------------------------------------------------
// ----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($2)
C_LONGINT:C283($3)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_OBJECT:C1216($toPaste)
C_LONGINT:C283($pasteOption)

If (False:C215)
	C_TEXT:C284(VP PASTE; $1)
	C_OBJECT:C1216(VP PASTE; $2)
	C_LONGINT:C283(VP PASTE; $3)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		$area:=$1
		$toPaste:=$2
		$pasteOption:=0
		
		If ($nbParameters>2)
			$pasteOption:=$3
		End if 
		
		
		If (vp_isReady($area; Current method name:C684))
			C_OBJECT:C1216($params)
			$params:=New object:C1471
			$params.text:=$toPaste.text
			$params.html:=$toPaste.html
			$params.pasteOption:=$pasteOption
			vp_runCommand($area; "paste-data"; $params)
		End if 
	End if 
	
	err_FINALLY
	
End if 
