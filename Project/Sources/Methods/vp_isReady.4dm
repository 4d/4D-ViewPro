//%attributes = {"invisible":true}
/*
OK := ***vp_isReady*** ( vpAreaName ; command )
-> vpAreaName (Text)
-> command (Text)
<- OK (Boolean)
________________________________________________________
*/
#DECLARE($area : Text; $commandName : Text) : Boolean

If (False:C215)
	C_TEXT:C284(vp_isReady; $1)
	C_TEXT:C284(vp_isReady; $2)
	C_BOOLEAN:C305(vp_isReady; $0)
End if 

var $success : Boolean
var $o : Object

If (Not:C34(Asserted:C1132(Count parameters:C259>=2; "Missing parameter")))
	
	ABORT:C156
	
End if 

$o:=vp_getAreaVariable($area)

If ($o=Null:C1517)
	
	_4D THROW ERROR:C1520(New object:C1471(\
		"component"; "4DEV"; \
		"code"; 5; \
		"object"; $area; \
		"deferred"; True:C214))
	
Else 
	
	$success:=$o.inited
	
	If (Not:C34($success))
		
		err_THROW(New object:C1471(\
			"code"; 5; \
			"object"; $area; \
			"command"; $commandName))
		
	End if 
End if 

return $success