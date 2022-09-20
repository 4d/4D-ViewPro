//%attributes = {"invisible":true,"shared":true}
// The VP Get cell style command returns a style object for the first cell in the given range.

C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_OBJECT:C1216($range; $params; $style)
C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$range:=$1
		$area:=$range.area
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216()
			$params:=New object:C1471()
			$params.ranges:=$range.ranges
			
			$style:=vp_runFunction($area; "get-cell-style"; $params)
			
			$0:=vp_convert_from_stylesheet($style)
			
		End if 
	End if 
	
	FINALLY
	
End if 