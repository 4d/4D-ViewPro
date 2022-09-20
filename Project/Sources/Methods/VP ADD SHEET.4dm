//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP ADD SHEET 
// Database: 4D ViewPro
// ID[5101AAB9EE104650B8B96DB1D581A124]
// Created #18-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: add a sheet
// ----------------------------------------------------
//----- Declarations

C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_TEXT:C284($name)
C_LONGINT:C283($Lon_sheetIndex)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP ADD SHEET; $1)
	C_LONGINT:C283(VP ADD SHEET; $2)
	C_TEXT:C284(VP ADD SHEET; $3)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		
		If ($nbParameters>1)
			$Lon_sheetIndex:=$2
		Else 
			$Lon_sheetIndex:=9999
		End if 
		
		If ($nbParameters>2)
			$name:=$3
		Else 
			$name:=""
		End if 
		
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("name"; $name; "index"; $Lon_sheetIndex)
			
			vp_runCommand($area; "add-sheet"; $params)
			
		End if 
		
	End if 
	
	FINALLY
	
End if 