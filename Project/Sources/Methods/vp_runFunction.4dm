//%attributes = {"invisible":true}
/*
Object := ***vp_runFunction*** ( Param_1 ; Param_2 ; params )
 -> Param_1 (Text)
 -> Param_2 (Text)
 -> params (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : VP Run function
// Database: 4D ViewPro
// ID[43EC6B2DA66549A6B529347173AC6025]
// Created #5-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description:
// ask JS to run a command
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_OBJECT:C1216($3)

C_OBJECT:C1216($params; $Obj_result)
C_TEXT:C284($Txt_command)
C_TEXT:C284($area)

If (False:C215)
	C_OBJECT:C1216(vp_runFunction; $0)
	C_TEXT:C284(vp_runFunction; $1)
	C_TEXT:C284(vp_runFunction; $2)
	C_OBJECT:C1216(vp_runFunction; $3)
End if 

If (Count parameters:C259>=2)
	$area:=$1
	$Txt_command:=$2
	
	If (Count parameters:C259=3)
		
		$params:=$3
	Else 
		
		$params:=New object:C1471
	End if 
	
	vp_flush($area)
	
	WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; $1; "runCommand"; $Obj_result; $2; $params)
	
	$0:=$Obj_result.result
	
	If ($Obj_result.error#"")
		THROW(New object:C1471("code"; 2; "message"; $Obj_result.error))
	End if 
	
End if 