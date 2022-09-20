//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET WORKBOOK OPTIONS
// Database: 4D ViewPro
// ID[5101AAB9EE104650B8B96DB1D581A124]
// Created #10-01-2020 by Francois Marchal
// ----------------------------------------------------
// Description: set workbook options
// ----------------------------------------------------
//----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_TEXT:C284($area)
C_OBJECT:C1216($options)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP SET WORKBOOK OPTIONS; $1)
	C_OBJECT:C1216(VP SET WORKBOOK OPTIONS; $2)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$options:=OB Copy:C1225($2)
		
		vp_make_picture($options; "backgroundImage")
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("options"; $options)
			
			vp_runCommand($area; "set-workbook-options"; $params)
			
		End if 
	End if 
	
	FINALLY
	
End if 