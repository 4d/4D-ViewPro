//%attributes = {"invisible":true,"shared":true}
// The VP Get cell style command returns a style object for the first cell in the given range.
#DECLARE($cell : Object)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$cell.area
		
		If (vp_isReady($area; Current method name:C684))
			
			var $style:=vp_runFunction($area; "get-cell-style"; {ranges: $cell.ranges})
			
			$result:=vp_convert_from_stylesheet($style)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 