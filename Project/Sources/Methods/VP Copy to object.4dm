//%attributes = {"invisible":true,"shared":true}
// copy the cells in the range sent as parameter into an object
// while there is no direct function to do that in SpreadJS
// creates a temporary sheet and copy the range into this sheet
// then save the sheet into the returned object
// the second parameters are options to tell what to copy (values, styles, formulas)
#DECLARE($from : Object; $options : Object) : Object

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		var $area : Text:=$from.area
		
		If ($nbParameters<2)
			$options:={copy: True:C214; copyOptions: 0}
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($from.ranges)=Is collection:K8:32)
				
				return vp_runFunction($area; "copy-cells"; {from: $from.ranges; options: $options})
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 