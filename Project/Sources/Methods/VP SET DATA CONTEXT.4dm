//%attributes = {"invisible":true,"shared":true}
// The VP SET DATA CONTEXT command sets the data context of a sheet

C_TEXT:C284($1)
C_VARIANT:C1683($2)
C_VARIANT:C1683($3)
C_VARIANT:C1683($4)

C_LONGINT:C283($nbParameters; $sheet)
C_TEXT:C284($area)
C_OBJECT:C1216($params; $options)
C_VARIANT:C1683($data)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$data:=$2
		
		$sheet:=-1
		$options:=New object:C1471
		
		If ($nbParameters>=3)
			If (($nbParameters=3) & vp_isNumeric($3))
				$sheet:=$3
			Else 
				If (Value type:C1509($3)=Is object:K8:27)
					$options:=$3
				End if 
			End if 
		End if 
		
		If (($nbParameters>=4) & vp_isNumeric($4))
			$sheet:=$4
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($sheet=-1)
				$sheet:=VP Get current sheet($area)
			End if 
			
			If ($sheet<-1)
				err_THROW(New object:C1471("code"; 17))
			Else 
				If ($sheet>=VP Get sheet count($area))
					err_THROW(New object:C1471("code"; 19))
				Else 
					C_VARIANT:C1683($data2)
					
					$data2:=vp_parse_element_set($data)
					
					$params:=New object:C1471
					$params.data:=$data2
					$params.options:=$options
					$params.sheetIndex:=$sheet
					
					vp_runCommand($area; "set-data-context"; $params)
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 