//%attributes = {"invisible":true,"shared":true}
C_OBJECT:C1216($1)
C_VARIANT:C1683($0)

If (vp_initStorage )
	
	TRY 
	
	If (Check_parameters_count (1;Count parameters:C259))
		
		C_OBJECT:C1216($config)
		$config:=$1
		
		If ($config.ViewPro=Null:C1517)
			$config.ViewPro:=New object:C1471
		End if 
		
		$0:=WA Run offscreen area:C1727($config)
		
	End if 
	
	FINALLY 
	
End if 
