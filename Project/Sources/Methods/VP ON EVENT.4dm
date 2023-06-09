//%attributes = {"invisible":true}
// add 4D callbacks on specific spreadJS events (not yet published)

C_TEXT:C284($1)
C_TEXT:C284($2)
C_OBJECT:C1216($3)
C_LONGINT:C283($4)

C_LONGINT:C283($nbParameters; $sheet)
C_TEXT:C284($area; $eventName)
C_OBJECT:C1216($params; $areaVariable; $formula)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		$area:=$1
		$eventName:=$2
		$formula:=$3
		
		If ($nbParameters>=4)
			
			$sheet:=$4
		Else 
			
			$sheet:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			$areaVariable:=vp_getAreaVariable($area)
			If ($areaVariable#Null:C1517)
				If (Value type:C1509($areaVariable.events)=Is object:K8:27)
					If (Value type:C1509($areaVariable.events[$eventName])#Is object:K8:27)
						$areaVariable.events[$eventName]:=New object:C1471()
					End if 
					
					If ($sheet=-1)
						$sheet:=VP Get current sheet($area)
					End if 
					
					If ($sheet<-2)
						err_THROW(New object:C1471("code"; 17))
					Else 
						If ($sheet>=VP Get sheet count($area))
							err_THROW(New object:C1471("code"; 19))
						Else 
							C_TEXT:C284($target)
							
							If ($sheet=-2)
								$target:="allSheets"
							Else 
								$target:="sheet"+String:C10($sheet)
							End if 
							
							$areaVariable.events[$eventName][$target]:=$formula
							
							$params:=New object:C1471("areaName"; $area; "event"; $eventName; "sheetIndex"; $sheet)
							
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