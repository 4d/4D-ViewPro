//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET BORDER
// Database: 4D ViewPro
// ID[5101BDB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the border for a specified range
// ----------------------------------------------------
//----- Declarations

C_OBJECT:C1216($1)
C_OBJECT:C1216($2)
C_OBJECT:C1216($3)

C_OBJECT:C1216($range)
C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		$range:=$1
		$area:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				C_OBJECT:C1216($params)
				$params:=New object:C1471()
				$params.ranges:=$range.ranges
				$params.border:=$2
				$params.option:=$3
				vp_runCommand($area; "set-border"; $params)
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 