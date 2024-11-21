//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)
C_LONGINT:C283($4)
C_COLLECTION:C1488($0)

C_LONGINT:C283($sheet)
C_OBJECT:C1216($params)
C_TEXT:C284($table; $area)
C_BOOLEAN:C305($reset)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$table:=$2
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters>2)
				$reset:=$3
			Else 
				$reset:=True:C214
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
					
					$params.name:=$table
					$params.reset:=$reset
					$params.sheet:=$sheet
					
					C_OBJECT:C1216($ret)
					$ret:=vp_runFunction($area; "get-table-dirty-rows"; $params)
					
					$0:=$ret.dirtyRows
					
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 