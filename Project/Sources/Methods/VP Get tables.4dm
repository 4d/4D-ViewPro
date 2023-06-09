//%attributes = {"invisible":true,"shared":true}
C_COLLECTION:C1488($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($nbParameters; $sheet)
C_OBJECT:C1216($params)
C_TEXT:C284($area)

$0:=New collection:C1472

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters=2)
				$sheet:=$2
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
					
					$params.sheet:=$sheet
					
					C_OBJECT:C1216($ret)
					$ret:=vp_runFunction($area; "get-tables"; $params)
					$0:=$ret.collection
				End if 
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 