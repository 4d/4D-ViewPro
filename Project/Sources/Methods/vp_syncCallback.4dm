//%attributes = {"invisible":true}
#DECLARE($cmd : Text; $area : Text; $params : Object; $filePath : Text)

If ($params.formula#Null:C1517)  // Is there a user callback method to execute ?
	var $callback:=vp_newCallback($cmd; $area; $params)
	If (Count parameters:C259>3)
		$callback.path:=$filePath
	End if 
	vp_callback($callback)  // called immediately, not async so not called by cpp code
End if 