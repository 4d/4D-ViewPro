//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP REMOVE NAME
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: remove the given name in given scope
// ----------------------------------------------------
// ----- Declarations

C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_TEXT:C284($name)
C_LONGINT:C283($Lon_scope)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP REMOVE NAME; $1)
	C_TEXT:C284(VP REMOVE NAME; $2)
	C_LONGINT:C283(VP REMOVE NAME; $3)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$name:=$2
		
		If ($nbParameters>2)
			$Lon_scope:=$3
		Else 
			$Lon_scope:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("name"; $name; "scope"; $Lon_scope)
			
			vp_runCommand($area; "remove-name"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 