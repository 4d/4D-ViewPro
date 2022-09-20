//%attributes = {"invisible":true}
C_OBJECT:C1216($1;$2)

If (False:C215)
	C_OBJECT:C1216(vp_eventsCallback ;$1)
	C_OBJECT:C1216(vp_eventsCallback ;$2)
End if 

C_OBJECT:C1216($Obj_callback;$Obj_data;$Obj_areaVariable;$Obj_formula)
C_TEXT:C284($Txt_event)

$obj_callback:=$1
$Obj_data:=$2

If (OB Is defined:C1231($Obj_callback;"event"))
	$Txt_event:=$Obj_callback.event
	
	$Obj_areaVariable:=vp_getAreaVariable ($Obj_callback.areaName)
	If ($Obj_areaVariable#Null:C1517)
		If (Value type:C1509($Obj_areaVariable.events)=Is object:K8:27)
			If (Value type:C1509($Obj_areaVariable.events[$Txt_event])=Is object:K8:27)
				
				C_TEXT:C284($sheet)
				
				If ($Obj_callback.sheetIndex=-2)
					$sheet:="allSheets"
				Else 
					$sheet:="sheet"+String:C10($Obj_callback.sheetIndex)
				End if 
				
				$Obj_formula:=$Obj_areaVariable.events[$Txt_event][$sheet]
				If (Value type:C1509($Obj_formula)=Is object:K8:27)
					$Obj_formula.call($Obj_callback;$Obj_callback.areaName;$Obj_callback.event;$Obj_callback.sheetIndex;$Obj_data)
				End if 
			End if 
		End if 
	End if 
End if 
