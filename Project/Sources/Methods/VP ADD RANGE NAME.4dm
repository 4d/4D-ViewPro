//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP ADD RANGE NAME
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Add a custom name for a specified target
// target can be a cell, a range, a column or a row, or any formula
// ----------------------------------------------------
//----- Declarations

C_OBJECT:C1216($1)
C_TEXT:C284($2)
C_OBJECT:C1216($3)

C_OBJECT:C1216($Obj_range)
C_TEXT:C284($name)
C_OBJECT:C1216($options)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_OBJECT:C1216(VP ADD RANGE NAME; $1)
	C_TEXT:C284(VP ADD RANGE NAME; $2)
	C_OBJECT:C1216(VP ADD RANGE NAME; $3)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$Obj_range:=$1
		$name:=$2
		
		If ($nbParameters>2)
			$options:=$3
		Else 
			$options:=New object:C1471("scope"; -1)
		End if 
		
		If (vp_isReady($Obj_range.area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			$params.ranges:=$Obj_range.ranges
			$params.name:=$name
			$params.options:=$options
			
			vp_runCommand($Obj_range.area; "add-range-name"; $params)
			
		End if 
		
	End if 
	
	err_FINALLY
	
End if 