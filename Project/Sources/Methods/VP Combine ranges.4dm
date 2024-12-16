//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Combine
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Combine multiple targets into one
// ----------------------------------------------------
// ----- Declarations
#DECLARE( ...  : Object)->$result : Object


If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $parameters:=Copy parameters:C1790
		var $Obj_first; $Obj_current : Object
		$Obj_first:=$parameters.first()
		
		If (OB Get type:C1230($Obj_first; "area")#Is text:K8:3)
			
			err_THROW({code: 9})  // Property "area" is missing
			
		Else 
			
			$result:=New object:C1471(\
				"area"; $Obj_first.area; \
				"ranges"; New collection:C1472)
			
			var $i : Integer
			For ($i; 1; $nbParameters; 1)
				
				$Obj_current:=$parameters[$i-1]
				
				If (OB Get type:C1230($Obj_current; "area")#Is text:K8:3)
					
					err_THROW({code: 9})  // Property "area" is missing
					
				Else 
					
					If ($Obj_current.area#$Obj_first.area)
						
						err_THROW({code: 10})  // Ranges should have same "area" property
						
					Else 
						
						If (OB Get type:C1230($Obj_current; "ranges")#Is collection:K8:32)
							
							err_THROW({code: 11})  // Ranges are missing
							
						Else 
							
							var $Obj_range : Object
							For each ($Obj_range; $Obj_current.ranges)
								
								If (Not:C34(OB Is defined:C1231($Obj_range)))
									
									err_THROW({code: 12}) // No object found in "ranges" collection.
									
								Else 
									
									$result.ranges.push($Obj_range)
									
								End if 
							End for each 
						End if 
					End if 
				End if 
			End for 
		End if 
	End if 
	
	err_FINALLY
	
End if 