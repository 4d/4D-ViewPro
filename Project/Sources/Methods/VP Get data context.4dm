//%attributes = {"invisible":true,"shared":true}
// The VP Get data context command returns the current data context of a worksheet.
// The returned context includes any modifications made to the contents of the data context

C_VARIANT:C1683($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($nbParameters; $sheet)
C_TEXT:C284($area)
C_OBJECT:C1216($params; $obj)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>=2)
			$sheet:=$2
		Else 
			$sheet:=-1
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
					
					$params:=New object:C1471
					$params.sheetIndex:=$sheet
					
					$obj:=vp_runFunction($area; "get-data-context"; $params)
					$0:=vp_parse_element_get($obj.value)
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 