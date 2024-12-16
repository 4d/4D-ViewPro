//%attributes = {"invisible":true}
#DECLARE($command : Text; $areaName : Text; $params : Object) : Object

var $callback:={command: $command; areaName: $areaName}

If ($params.formula#Null:C1517)
	
	$callback.uuid:=Generate UUID:C1066  // UUID help to find stored callback
	
	// Keep the callback method
	var $areaVariable:=vp_getAreaVariable($areaName)
	If (($areaVariable#Null:C1517) && (Value type:C1509($areaVariable.callbacks)=Is object:K8:27))
		$areaVariable.callbacks[$callback.uuid]:=$params
	End if 
	
End if 

return $callback