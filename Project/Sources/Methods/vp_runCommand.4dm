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

If (Count parameters:C259<2)
	// no dev error?
	return 
End if 

var $o : Object:=vp_getAreaVariable($area)

If ($o#Null:C1517)\
 && ($o.inited)\
 && (Value type:C1509($o.commandBuffers)=Is collection:K8:32)
	
	$params:=OB Copy:C1225($params) || {}
	
	$o.commandBuffers.push({\
		command: $command; \
		params: $params\
		})
	
End if 