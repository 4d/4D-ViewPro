//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Row
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Create a target for a single row or multiple rows
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $row : Integer; $rowCount : Integer; $sheet : Integer)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($row<0)
			err_THROW(New object:C1471("code"; 14))
		Else 
			
			If ($nbParameters<3)
				
				$rowCount:=1
				
			End if 
			
			If ($rowCount<1)
				err_THROW(New object:C1471("code"; 16))
			Else 
				If ($nbParameters<4)
					
					$sheet:=-1
					
				End if 
				
				If ($sheet<-1)
					err_THROW(New object:C1471("code"; 17))
				Else 
					
					var $ranges:={row: $row; rowCount: $rowCount}
					
					If ($sheet#-1)
						$ranges.sheet:=$sheet
					End if 
					
					$result:={area: $area; ranges: [$ranges]}
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 