//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP GET SHEET OPTIONS
// Database: 4D ViewPro
// ID[5101AAB9EE104650B8B96DB1D581A124]
// Created #10-01-2020 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet options
// ----------------------------------------------------
//----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($0)

C_TEXT:C284($area)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP Get workbook options; $1)
	C_OBJECT:C1216(VP Get workbook options; $0)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471
			
			$0:=vp_runFunction($area; "get-workbook-options"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 