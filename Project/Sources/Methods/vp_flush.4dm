//%attributes = {"invisible":true}
C_TEXT:C284($1)
C_TEXT:C284($area)

$area:=$1

C_OBJECT:C1216($obj)

$obj:=vp_getAreaVariable ($area)

If ($obj#Null:C1517)
	If ($obj.inited)
		
		C_COLLECTION:C1488($Obj_commandsBuffer)
		$Obj_commandsBuffer:=$obj.commandBuffers
		
		If ($Obj_commandsBuffer#Null:C1517)
			
			If ($Obj_commandsBuffer.length>0)
				
				WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;$area;"runCommands";*;$Obj_commandsBuffer)
				
			End if 
			
			$Obj_commandsBuffer.clear()
		End if 
		
	End if 
End if 