//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $name : Text; $source : Text; $options : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			var $params:={}
			
			$params.name:=$name
			$params.source:=$source
			
			If ($nbParameters>=4)
				$params.sheetName:=String:C10($options.sheetName)="" ? $name : $options.sheetName
				If ($options.columns#Null:C1517)
					$params.columns:=$options.columns.copy()
				End if 
				If ($options.defaultColumnWidth#Null:C1517)
					$params.defaultColumnWidth:=$options.defaultColumnWidth
				End if 
			Else 
				$params.sheetName:=$name
			End if 
			
			vp_runCommand($area; "create-table-sheet"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 
