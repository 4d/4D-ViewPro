//%attributes = {"invisible":true,"shared":true}
#DECLARE($config : Object)->$result : Variant

If (vp_initStorage)
	
	err_TRY
	
	If (Check_parameters_count(1; Count parameters:C259))
		
		If ($config.ViewPro=Null:C1517)
			$config.ViewPro:={}
		End if 
		
		$result:=WA Run offscreen area:C1727($config)
		
	End if 
	
	err_FINALLY
	
End if 
