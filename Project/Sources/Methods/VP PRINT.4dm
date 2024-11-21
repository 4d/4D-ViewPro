//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP PRINT
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: print document
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $sheetIndex : Integer)

// do not execute if in headless mode

var $infos:=Application info:C1599
If (Not:C34($infos.headless))
	
	If (vp_initStorage)
		
		var $nbParameters:=Count parameters:C259
		
		err_TRY
		
		If (Check_parameters_count(1; $nbParameters))
			
			If ($nbParameters<2)
				$sheetIndex:=-1
			End if 
			
			If ($sheetIndex<-2)
				err_THROW(New object:C1471("code"; 17))
			Else 
				
				If ($sheetIndex>=VP Get sheet count($area))
					err_THROW(New object:C1471("code"; 19))
				Else 
					
					If (vp_isReady($area; Current method name:C684))
						
						vp_runFunction($area; "print"; {sheetIndex: $sheetIndex})
						
					End if 
				End if 
			End if 
		End if 
		
		err_FINALLY
		
	End if 
End if 