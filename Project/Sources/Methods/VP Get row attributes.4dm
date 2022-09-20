//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get row attributes
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get the attributes of rows
// ----------------------------------------------------
// ----- Declarations

C_COLLECTION:C1488($0)
C_OBJECT:C1216($1)

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($range; $ret)
C_TEXT:C284($area)

$0:=New collection:C1472()

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$range:=$1
		$area:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			If (Value type:C1509($range.ranges)=Is collection:K8:32)
				$params.ranges:=$range.ranges
				$ret:=vp_runFunction($area; "get-row-attributes"; $params)
				$0:=$ret.value
			End if 
			
		End if 
	End if 
	
	FINALLY
	
End if 