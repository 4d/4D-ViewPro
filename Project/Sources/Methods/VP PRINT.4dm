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

C_TEXT:C284($1)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_LONGINT:C283($sheet)

If (False:C215)
	C_TEXT:C284(VP PRINT; $1)
	C_LONGINT:C283(VP PRINT; $2)
End if 

// do not execute if in headless mode
C_OBJECT:C1216($infos)
$infos:=Get application info:C1599
If (Not:C34($infos.headless))
	
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
			
			If ($sheet<-2)
				err_THROW(New object:C1471("code"; 17))
			Else 
				If ($sheet>=VP Get sheet count($area))
					err_THROW(New object:C1471("code"; 19))
				Else 
					
					If (vp_isReady($area; Current method name:C684))
						C_OBJECT:C1216($params)
						$params:=New object:C1471("sheetIndex"; $sheet)
						
						vp_runFunction($area; "print"; $params)
					End if 
				End if 
			End if 
		End if 
		
		err_FINALLY
		
	End if 
End if 