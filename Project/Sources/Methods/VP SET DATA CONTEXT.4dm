//%attributes = {"invisible":true,"shared":true}
// The VP SET DATA CONTEXT command sets the data context of a sheet
#DECLARE($area : Text; $data : Variant; $p3 : Variant; $p4 : Variant)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $sheetIndex:=-1
		var $options:={}
		
		If ($nbParameters>=3)
			If (($nbParameters=3) & vp_isNumeric($p3))
				$sheetIndex:=$p3
			Else 
				If (Value type:C1509($p3)=Is object:K8:27)
					$options:=$p3
				End if 
			End if 
		End if 
		
		If (($nbParameters>=4) & vp_isNumeric($p4))
			$sheetIndex:=$p4
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($sheetIndex=-1)
				$sheetIndex:=VP Get current sheet($area)
			End if 
			
			If ($sheetIndex<-1)
				err_THROW(New object:C1471("code"; 17))
			Else 
				If ($sheetIndex>=VP Get sheet count($area))
					err_THROW(New object:C1471("code"; 19))
				Else 
					
					vp_runCommand($area; "set-data-context"; {data: vp_parse_element_set($data); options: $options; sheetIndex: $sheetIndex})
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 