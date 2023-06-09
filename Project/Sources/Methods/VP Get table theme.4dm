//%attributes = {"invisible":true,"shared":true}
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_LONGINT:C283($nbParameters; $sheet)
C_OBJECT:C1216($params)
C_TEXT:C284($name; $area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$name:=$2
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters>2)
				$sheet:=$3
			Else 
				$sheet:=-1
			End if 
			
			If ($sheet<-1)
				err_THROW(New object:C1471("code"; 17))
			Else 
				If ($sheet>=VP Get sheet count($area))
					err_THROW(New object:C1471("code"; 19))
				Else 
					
					$params:=New object:C1471()
					
					$params.name:=$name
					$params.sheet:=$sheet
					
					$0:=vp_runFunction($area; "get-table-theme"; $params)
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 