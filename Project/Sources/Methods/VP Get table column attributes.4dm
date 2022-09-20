//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_OBJECT:C1216($0)

C_LONGINT:C283($nbParameters; $sheet; $index)
C_OBJECT:C1216($params)
C_COLLECTION:C1488($attributes)
C_TEXT:C284($name; $area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		$area:=$1
		$name:=$2
		$index:=$3
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters>3)
				$sheet:=$4
			Else 
				$sheet:=-1
			End if 
			
			If ($sheet<-1)
				THROW(New object:C1471("code"; 17))
			Else 
				If ($sheet>=VP Get sheet count($area))
					THROW(New object:C1471("code"; 19))
				Else 
					
					$params:=New object:C1471()
					
					$params.name:=$name
					$params.index:=$index
					$params.sheet:=$sheet
					
					$0:=vp_runFunction($area; "get-table-column-attributes"; $params)
				End if 
			End if 
			
		End if 
	End if 
	
	FINALLY
	
End if 