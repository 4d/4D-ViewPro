//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET COLUMN ATTRIBUTES
// Database: 4D ViewPro
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the attributes of columns
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

If (False:C215)
	C_OBJECT:C1216(VP SET COLUMN ATTRIBUTES; $1)
	C_OBJECT:C1216(VP SET COLUMN ATTRIBUTES; $2)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges; $Obj_attributes)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$ranges:=$1
		$Obj_attributes:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				$params.ranges:=$ranges.ranges
				$params.attributes:=$Obj_attributes
				vp_runCommand($area; "set-column-attributes"; $params)
				
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 