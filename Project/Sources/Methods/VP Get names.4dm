//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get custom name infos
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: return infos on a custom name
// ----------------------------------------------------
// ----- Declarations

C_COLLECTION:C1488($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($area)
C_LONGINT:C283($Lon_scope)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_COLLECTION:C1488(VP Get names; $0)
	C_TEXT:C284(VP Get names; $1)
	C_LONGINT:C283(VP Get names; $2)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			
			$Lon_scope:=$2
			
		Else 
			
			$Lon_scope:=-1
			
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("scope"; $Lon_scope)
			
			C_OBJECT:C1216($Obj_result)
			$Obj_result:=vp_runFunction($area; "get-names"; $params)
			
			$0:=$Obj_result.collection
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
