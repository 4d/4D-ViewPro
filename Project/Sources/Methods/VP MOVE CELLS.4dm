//%attributes = {"invisible":true,"shared":true}
// Move cells from range passed as first parameter to the destination pointed by parameter 2
// It can be in same sheet, different sheets in same workbook, or from one 4D ViewPro area to another
// in this case it will use the commands VP Copy to object and VP Paste

C_OBJECT:C1216($1; $2; $3)

C_OBJECT:C1216($from; $to; $options; $params)
C_LONGINT:C283($nbParameters)
C_TEXT:C284($area1; $area2)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$from:=$1
		$to:=$2
		$area1:=$from.area
		$area2:=$to.area
		
		If ($nbParameters>2)
			$options:=OB Copy:C1225($3)
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
					$params:=New object:C1471
					$params.from:=$from.ranges
					$params.to:=$to.ranges
					$params.options:=$options
					
					vp_runCommand($area1; "move-cells"; $params)
				End if 
			End if 
			
		Else 
			C_LONGINT:C283($pasteOptions)
			
			If ((Value type:C1509($options.pasteOptions)=Is longint:K8:6) | (Value type:C1509($options.pasteOptions)=Is real:K8:4))
				$pasteOptions:=$options.pasteOptions
				$options.copyOptions:=$options.pasteOptions
			Else 
				$pasteOptions:=0
				$options.copyOptions:=0
			End if 
			
			C_OBJECT:C1216($tmp)
			$tmp:=VP Copy to object($from; $options)
			
			If ($tmp#Null:C1517)
				VP PASTE FROM OBJECT($to; $tmp; $pasteOptions)
			End if 
			
		End if 
	End if 
	
	FINALLY
	
End if 