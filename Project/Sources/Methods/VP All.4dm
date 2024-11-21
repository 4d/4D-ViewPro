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
#DECLARE($area : Text; $sheet : Integer)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			
			$sheet:=-1
			
		End if 
		
		If ($sheet<-1)
			err_THROW(New object:C1471("code"; 17))
		Else 
			
			var $ranges:=New object:C1471()
			
			If ($sheet#-1)
				$ranges.sheet:=$sheet
			End if 
			
			$result:={area: $area; ranges: [$ranges]}
			
		End if 
	End if 
	
	err_FINALLY
	
End if 