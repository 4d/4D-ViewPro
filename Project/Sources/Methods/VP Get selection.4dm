//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get selection
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #03-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// ----- Declarations
#DECLARE($area : Text; $sheetIndex : Integer)->$result : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		If ($nbParameters<2)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			var $ret:=vp_runFunction($area; "get-selection"; {sheetIndex: $sheetIndex})
			
			If (Value type:C1509($ret.ranges)=Is collection:K8:32)
				$ret.area:=$area
				$result:=$ret
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 