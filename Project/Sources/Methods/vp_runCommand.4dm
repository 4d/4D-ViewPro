//%attributes = {"invisible":true}
/*
Object := ***vp_runCommand*** ( Param_1 ; Param_2 ; params )
 -> Param_1 (Text)
 -> Param_2 (Text)
 -> params (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : VP Run command
// Database: 4D ViewPro
// ID[43EC6B2DA66549A6B529347473AC6025]
// Created #5-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description:
// ask JS to run a command
// ----------------------------------------------------
// Declarations

C_TEXT:C284($1)
C_TEXT:C284($2)
C_OBJECT:C1216($3)

C_OBJECT:C1216($params)
C_TEXT:C284($Txt_command)
C_TEXT:C284($area)
C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(vp_runCommand; $1)
	C_TEXT:C284(vp_runCommand; $2)
	C_OBJECT:C1216(vp_runCommand; $3)
End if 

$nbParameters:=Count parameters:C259

If ($nbParameters>=2)
	$area:=$1
	$Txt_command:=$2
	
	If ($nbParameters=3)
		$params:=$3
	Else 
		$params:=New object:C1471
	End if 
	
	C_OBJECT:C1216($obj)
	$obj:=vp_getAreaVariable($area)
	
	If ($obj#Null:C1517)
		If ($obj.inited)
			
			If (Value type:C1509($obj.commandBuffers)=Is collection:K8:32)
				
				$obj.commandBuffers.push(New object:C1471("command"; $Txt_command; "params"; OB Copy:C1225($params)))
				
			End if 
		End if 
	End if 
End if 
