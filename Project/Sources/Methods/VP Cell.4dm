//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP cell
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Create a target for a single cell
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_TEXT:C284($area)
C_LONGINT:C283($column)
C_LONGINT:C283($row)
C_LONGINT:C283($sheet)
C_LONGINT:C283($nbParameters)

If (False:C215)
	C_OBJECT:C1216(VP Cell; $0)
	C_TEXT:C284(VP Cell; $1)
	C_LONGINT:C283(VP Cell; $2)
	C_LONGINT:C283(VP Cell; $3)
	C_LONGINT:C283(VP Cell; $4)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		$area:=$1
		$column:=$2
		$row:=$3
		
		If ($column<0)
			err_THROW(New object:C1471("code"; 13))
		Else 
			If ($row<0)
				err_THROW(New object:C1471("code"; 14))
			Else 
				If ($nbParameters>3)
					
					$sheet:=$4
					
				Else 
					
					$sheet:=-1
					
				End if 
				
				If ($sheet<-1)
					err_THROW(New object:C1471("code"; 17))
				Else 
					
					C_OBJECT:C1216($ranges)
					
					$ranges:=New object:C1471(\
						"column"; $column; \
						"row"; $row)
					
					If ($sheet#-1)
						$ranges.sheet:=$sheet
					End if 
					
					$0:=New object:C1471(\
						"area"; $area; \
						"ranges"; New collection:C1472($ranges))
					
					vp_addRangeFormulas($0)
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 