//%attributes = {"invisible":true}
#DECLARE($obj_callback : Object; $Obj_data : Object)


var $Obj_areaVariable; $Obj_formula : Object
var $Txt_event : Text


If (OB Is defined:C1231($Obj_callback; "event"))
	$Txt_event:=$Obj_callback.event
	
	$Obj_areaVariable:=vp_getAreaVariable($Obj_callback.areaName)
	If ($Obj_areaVariable#Null:C1517)
		If (Value type:C1509($Obj_areaVariable.events)=Is object:K8:27)
			If (Value type:C1509($Obj_areaVariable.events[$Txt_event])=Is object:K8:27)
				
				var $sheet : Text
				If ($Obj_callback.sheetIndex=-2)
					$sheet:="allSheets"
				Else 
					$sheet:="sheet"+String:C10($Obj_callback.sheetIndex)
				End if 
				
				$Obj_formula:=$Obj_areaVariable.events[$Txt_event][$sheet]
				If (Value type:C1509($Obj_formula)=Is object:K8:27)
					$Obj_formula.call($Obj_callback; $Obj_callback.areaName; $Obj_callback.event; $Obj_callback.sheetIndex; $Obj_data)
				End if 
			End if 
		End if 
	End if 
End if 
