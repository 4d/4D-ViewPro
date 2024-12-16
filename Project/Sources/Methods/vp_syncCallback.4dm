//%attributes = {"invisible":true}
#DECLARE($cmd : Text; $area : Text; $params : Object; $filePath : Text)

If ($params.formula#Null:C1517)  // Is there a user callback method to execute ?
	var $callback:=vp_newCallback("import-4VP"; $area; $params)
	$callback.path:=$filePath
	vp_callback($callback)  // called immediately, not async so not called by cpp code
End if 