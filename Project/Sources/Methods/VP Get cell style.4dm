//%attributes = {"invisible":true,"shared":true}
// The VP Get cell style command returns a style object for the first cell in the given range.

C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_OBJECT:C1216($cell; $params; $style)
C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$cell:=$1
		$area:=$cell.area
		
		If (vp_isReady($area; Current method name:C684))
			
			$params:=New object:C1471()
			$params.ranges:=$cell.ranges
			
			$style:=vp_runFunction($area; "get-cell-style"; $params)
			
			$0:=vp_convert_from_stylesheet($style)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 