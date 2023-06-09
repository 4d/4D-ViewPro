//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET SHEET OPTIONS
// Database: 4D ViewPro
// ID[5101AAB9EE104650B8B96DB1D581A124]
// Created #10-01-2020 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet options
// ----------------------------------------------------
//----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_OBJECT:C1216($options)
C_LONGINT:C283($Lon_sheetIndex)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP SET SHEET OPTIONS; $1)
	C_OBJECT:C1216(VP SET SHEET OPTIONS; $2)
	C_LONGINT:C283(VP SET SHEET OPTIONS; $3)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$options:=$2
		
		If ($nbParameters>2)
			$Lon_sheetIndex:=$3
		Else 
			$Lon_sheetIndex:=-1
		End if 
		
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("options"; $options; "index"; $Lon_sheetIndex)
			
			vp_runCommand($area; "set-sheet-options"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 