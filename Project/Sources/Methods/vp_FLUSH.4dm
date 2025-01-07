//%attributes = {"invisible":true}
#DECLARE($area : Text)

var $obj:=vp_getAreaVariable($area)

If (($obj=Null:C1517) || (Not:C34($obj.inited)))
	return 
End if 

var $commandsBuffer : Collection:=$obj.commandBuffers

If (($commandsBuffer#Null:C1517) && ($commandsBuffer.length>0))
	
	WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; $area; "runCommands"; *; $commandsBuffer)
	
	$commandsBuffer.clear()
	
End if 
