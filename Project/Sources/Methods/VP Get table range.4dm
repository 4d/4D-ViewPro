//%attributes = {"invisible":true,"shared":true}
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($nbParameters; $sheet)
C_OBJECT:C1216($params)
C_TEXT:C284($tableName; $area)
C_BOOLEAN:C305($onlyData)

$0:=New object:C1471

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$tableName:=$2
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters>2)
				$onlyData:=($3#0)
			Else 
				$onlyData:=False:C215
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
					
					$params.name:=$tableName
					$params.onlyData:=$onlyData
					$params.sheet:=$sheet
					
					C_OBJECT:C1216($ret)
					$ret:=vp_runFunction($area; "get-table-range"; $params)
					
					If (($ret.rowCount=0) & ($ret.columnCount=0))
						$0:=Null:C1517
					Else 
						$0.area:=$area
						$0.ranges:=New collection:C1472($ret)
					End if 
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 