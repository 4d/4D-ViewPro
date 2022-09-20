//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283($3)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_BOOLEAN:C305($visible)
C_LONGINT:C283($sheet)

If (vp_initStorage)
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			$visible:=$2
		Else 
			$visible:=True:C214
		End if 
		
		If ($nbParameters>2)
			$sheet:=$3
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			$params.visible:=$visible
			$params.sheetIndex:=$sheet
			vp_runCommand($area; "set-show-print-lines"; $params)
			
		End if 
	End if 
	
	FINALLY
	
End if 