//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Name
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Create a target for a named range
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $name : Text; $sheet : Integer) : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		
		If (Length:C16($name)=0)
			err_THROW({code: 18})
		Else 
			
			If ($nbParameters<3)
				
				$sheet:=-1
				
			End if 
			
			If ($sheet<-2)
				err_THROW({code: 17 /*Sheet must be greater or equal than -2*/})
			Else 
				
				var $ranges:={}
				
				If ($sheet#-1)
					$ranges.sheet:=$sheet
				End if 
				
				$ranges.name:=$name
				
				return {area: $area; ranges: [$ranges]}
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 