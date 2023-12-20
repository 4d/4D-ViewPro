//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : VP Run command
// Database: 4D ViewPro
// ID[43EC6B2DA66549A6B529347473AC6025]
// Created #5-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description:
// ask JS to run a command
// ----------------------------------------------------
#DECLARE($area : Text; $command : Text; $params : Object)

If (False:C215)
	C_TEXT:C284(vp_runCommand; $1)
	C_TEXT:C284(vp_runCommand; $2)
	C_OBJECT:C1216(vp_runCommand; $3)
End if 

var $o : Object

If (Count parameters:C259<2)
	
	return 
	
End if 

$params:=$params || {}

$o:=vp_getAreaVariable($area)

If ($o#Null:C1517)\
 && ($o.inited)\
 && (Value type:C1509($o.commandBuffers)=Is collection:K8:32)
	
	$o.commandBuffers.push({\
		command: $command; \
		params: OB Copy:C1225($params)\
		})
	
End if 