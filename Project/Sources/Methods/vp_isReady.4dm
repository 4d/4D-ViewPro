//%attributes = {"invisible":true}
// Check if the area is ready
#DECLARE($area : Text; $commandName : Text) : Boolean

var $success : Boolean

If (Not:C34(Asserted:C1132(Count parameters:C259>=2; "Missing parameter")))
	
	return 
	
End if 

var $o:=vp_getAreaVariable($area)

If ($o=Null:C1517)
	
	_4D THROW ERROR:C1520(New object:C1471(\
		"component"; "4DEV"; \
		"code"; 5; \
		"object"; $area; \
		"deferred"; True:C214))
	
Else 
	
	$success:=$o.inited
	
	If (Not:C34($success))
		
		err_THROW({code: 5; object: $area; command: $commandName})  // The area "{object}" is not yet available. The command "{command}" cannot be applied
		
	End if 
End if 

return $success