//%attributes = {"invisible":true,"shared":true}
// Move cells from range passed as first parameter to the destination pointed by parameter 2
// It can be in same sheet, different sheets in same workbook, or from one 4D ViewPro area to another
// in this case it will use the commands VP Copy to object and VP Paste
#DECLARE($from : Object; $to : Object; $options : Object)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		var $area1 : Text:=$from.area
		var $area2 : Text:=$to.area
		
		If ($nbParameters>2)
			$options:=OB Copy:C1225($options)
		Else 
			$options:=New object:C1471("copy"; False:C215; "pasteOptions"; 0)
		End if 
		
		If ($options.copy=Null:C1517)
			$options.copy:=False:C215
		End if 
		
		If ($options.pasteOptions=Null:C1517)
			$options.pasteOptions:=0
		End if 
		
		If ($area1=$area2)
			
			If (vp_isReady($area1; Current method name:C684))
				
				If ((Value type:C1509($from.ranges)=Is collection:K8:32) & (Value type:C1509($to.ranges)=Is collection:K8:32))
					var $params:=New object:C1471
					$params.from:=$from.ranges
					$params.to:=$to.ranges
					$params.options:=$options
					
					vp_runCommand($area1; "move-cells"; $params)
				End if 
			End if 
			
		Else 
			var $pasteOptions : Integer
			If ((Value type:C1509($options.pasteOptions)=Is longint:K8:6) | (Value type:C1509($options.pasteOptions)=Is real:K8:4))
				$pasteOptions:=$options.pasteOptions
				$options.copyOptions:=$options.pasteOptions
			Else 
				$pasteOptions:=0
				$options.copyOptions:=0
			End if 
			
			var $tmp:=VP Copy to object($from; $options)
			
			If ($tmp#Null:C1517)
				VP PASTE FROM OBJECT($to; $tmp; $pasteOptions)
			End if 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 