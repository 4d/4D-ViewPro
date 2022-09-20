//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)

C_LONGINT:C283($nbParameters; $sheet; $row; $count)
C_OBJECT:C1216($params)
C_TEXT:C284($name; $area)
C_BOOLEAN:C305($isInsertAfter)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		$area:=$1
		$name:=$2
		$row:=$3
		
		If (vp_isReady($area; Current method name:C684))
			
			If ($nbParameters>3)
				$count:=$4
			Else 
				$count:=1
			End if 
			
			If ($nbParameters>4)
				$isInsertAfter:=($5#0)
			Else 
				$isInsertAfter:=False:C215
			End if 
			
			If ($nbParameters>5)
				$sheet:=$6
			Else 
				$sheet:=-1
			End if 
			
			If ($sheet<-1)
				THROW(New object:C1471("code"; 17))
			Else 
				If ($sheet>=VP Get sheet count($area))
					THROW(New object:C1471("code"; 19))
				Else 
					
					C_OBJECT:C1216($params)
					$params:=New object:C1471()
					
					$params.name:=$name
					$params.row:=$row
					$params.count:=$count
					$params.isInsertAfter:=$isInsertAfter
					$params.sheet:=$sheet
					
					C_OBJECT:C1216($ret)
					$ret:=vp_runFunction($area; "insert-table-rows"; $params)
				End if 
			End if 
			
		End if 
	End if 
	
	FINALLY
	
End if 