//%attributes = {"invisible":true,"shared":true}
// The VP Get data context command returns the current data context of a worksheet.
// The returned context includes any modifications made to the contents of the data context
#DECLARE($area : Text; $sheetIndex : Integer) : Variant

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($sheetIndex=-1)
				$sheetIndex:=VP Get current sheet($area)
			End if 
			
			If ($sheetIndex<-1)
				err_THROW({code: 17 /*Sheet must be greater or equal than -2*/})
			Else 
				If ($sheetIndex>=VP Get sheet count($area))
					err_THROW({code: 19 /*Sheet index should not be greater than or equal to the number of sheets*/})
				Else 
					
					var $obj:=vp_runFunction($area; "get-data-context"; {sheetIndex: $sheetIndex})
					return vp_parse_element_get($obj.value)
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 