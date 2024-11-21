//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3; $4)


C_OBJECT:C1216($params)
C_LONGINT:C283($options; $sheet)
C_TEXT:C284($name; $area)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$name:=$2
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters>2)
				$options:=$3
			Else 
				$options:=0
			End if 
			
			If ($nbParameters>3)
				$sheet:=$4
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
					$params.options:=$options
					$params.sheet:=$sheet
					
					vp_runCommand($area; "remove-table"; $params)
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 