//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET FORMULA
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the formula of a range
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

If (False:C215)
	C_OBJECT:C1216(VP SET FORMULA; $1)
	C_TEXT:C284(VP SET FORMULA; $2)
	C_TEXT:C284(VP SET FORMULA; $3)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges)
C_TEXT:C284($area; $Txt_formula)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$ranges:=$1
		$Txt_formula:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			$params.formula:=$Txt_formula
			
			// optional format
			If ($nbParameters>2)
				$params.format:=$3
			End if 
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				
				$params.ranges:=$ranges.ranges
				
				vp_runCommand($area; "set-ranges-formula"; $params)
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 