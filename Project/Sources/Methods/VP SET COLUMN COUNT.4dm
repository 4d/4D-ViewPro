//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET SHEET COLUMN COUNT
// Database: 4D ViewPro
// ID[EEEEC00482D14476A9E8216D7BAFDBF5]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: set sheet column count
// ----------------------------------------------------
//----- Declarations

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_LONGINT:C283($Lon_columnCount)
C_LONGINT:C283($Lon_sheetIndex)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP SET COLUMN COUNT; $1)
	C_LONGINT:C283(VP SET COLUMN COUNT; $2)
	C_LONGINT:C283(VP SET COLUMN COUNT; $3)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$Lon_columnCount:=$2
		
		If ($nbParameters>2)
			$Lon_sheetIndex:=$3
		Else 
			$Lon_sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("columnCount"; $Lon_columnCount; "sheetIndex"; $Lon_sheetIndex)
			
			vp_runCommand($area; "set-column-count"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 