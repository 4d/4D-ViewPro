//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Column
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Create a target for a single column or multiple columns
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $column : Integer; $columnCount : Integer; $sheet : Integer) : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($column<0)
			err_THROW({code: 13 /*Column must be greater or equal than zero*/})
		Else 
			
			If ($nbParameters<3)
				
				$columnCount:=1
				
			End if 
			
			If ($columnCount<1)
				err_THROW({code: 15 /*Column count must be greater than zero*/})
			Else 
				If ($nbParameters<4)
					
					$sheet:=-1
					
				End if 
				
				If ($sheet<-1)
					err_THROW({code: 17 /*Sheet must be greater or equal than -2*/})
				Else 
					
					var $ranges:={column: $column; columnCount: $columnCount}
					
					If ($sheet#-1)
						$ranges.sheet:=$sheet
					End if 
					
					return {area: $area; ranges: [$ranges]}
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 