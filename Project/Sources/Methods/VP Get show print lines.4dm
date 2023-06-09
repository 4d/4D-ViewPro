//%attributes = {"invisible":true,"shared":true}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_LONGINT:C283($sheet)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			$sheet:=$2
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($result; $params)
			$params:=New object:C1471("sheetIndex"; $sheet)
			$result:=vp_runFunction($area; "get-show-print-lines"; $params)
			
			$0:=$result.result
			
		End if 
	End if 
	
	err_FINALLY
	
End if 