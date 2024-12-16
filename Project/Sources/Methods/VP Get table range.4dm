//%attributes = {"invisible":true,"shared":true}

#DECLARE($area : Text; $tableName : Text; $onlyData : Integer; $sheet : Integer)->$result : Object

$result:=New object:C1471

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			var $isOnlyData : Boolean
			If ($nbParameters>2)
				$isOnlyData:=($onlyData#0)
			Else 
				$isOnlyData:=False:C215
			End if 
			
			If ($nbParameters<4)
				$sheet:=-1
			End if 
			
			If ($sheet<-1)
				err_THROW({code: 17 /*Sheet must be greater or equal than -2*/})
			Else 
				If ($sheet>=VP Get sheet count($area))
					err_THROW({code: 19 /*Sheet index should not be greater than or equal to the number of sheets*/})
				Else 
					
					var $params:=New object:C1471()
					
					$params.name:=$tableName
					$params.onlyData:=$isOnlyData
					$params.sheet:=$sheet
					
					C_OBJECT:C1216($ret)
					$ret:=vp_runFunction($area; "get-table-range"; $params)
					
					If (($ret.rowCount=0) & ($ret.columnCount=0))
						$result:=Null:C1517
					Else 
						$result.area:=$area
						$result.ranges:=New collection:C1472($ret)
					End if 
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 