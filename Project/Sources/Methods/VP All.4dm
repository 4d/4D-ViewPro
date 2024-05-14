//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP All
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Create a target for all the cells
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($area)
C_LONGINT:C283($sheet)
C_LONGINT:C283($nbParameters)

If (False:C215)
	C_OBJECT:C1216(VP All; $0)
	C_TEXT:C284(VP All; $1)
	C_LONGINT:C283(VP All; $2)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			
			$sheet:=$2
			
		Else 
			
			$sheet:=-1
			
		End if 
		
		If ($sheet<-1)
			err_THROW(New object:C1471("code"; 17))
		Else 
			
			C_OBJECT:C1216($ranges)
			
			$ranges:=New object:C1471()
			
			If ($sheet#-1)
				$ranges.sheet:=$sheet
			End if 
			
			$0:=New object:C1471(\
				"area"; $area; \
				"ranges"; New collection:C1472($ranges))
			
		End if 
	End if 
	
	err_FINALLY
	
End if 