//%attributes = {"invisible":true}
// add 4D callbacks on specific spreadJS events (not yet published)
#DECLARE($area : Text; $eventName : Text; $formula : Object; $sheetIndex : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		If ($nbParameters<4)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $areaVariable:=vp_getAreaVariable($area)
			If ($areaVariable#Null:C1517)
				If (Value type:C1509($areaVariable.events)=Is object:K8:27)
					If (Value type:C1509($areaVariable.events[$eventName])#Is object:K8:27)
						$areaVariable.events[$eventName]:=New object:C1471()
					End if 
					
					If ($sheetIndex=-1)
						$sheetIndex:=VP Get current sheet($area)
					End if 
					
					If ($sheetIndex<-2)
						err_THROW({code: 17 /*Sheet must be greater or equal than -2*/})
					Else 
						If ($sheetIndex>=VP Get sheet count($area))
							err_THROW({code: 19 /*Sheet index should not be greater than or equal to the number of sheets*/})
						Else 
							C_TEXT:C284($target)
							
							If ($sheetIndex=-2)
								$target:="allSheets"
							Else 
								$target:="sheet"+String:C10($sheetIndex)
							End if 
							
							$areaVariable.events[$eventName][$target]:=$formula
							
							var $params:=New object:C1471("areaName"; $area; "event"; $eventName; "sheetIndex"; $sheetIndex)
							
							If ($formula=Null:C1517)
								vp_runFunction($area; "clear-event"; $params)
							Else 
								vp_runFunction($area; "set-event"; $params)
							End if 
							
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 