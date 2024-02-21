//%attributes = {"invisible":true}
#DECLARE() : Boolean

var $o : Object

FEATURES

// Should be called before any API call to ensure that Storage.ViewPro object is correctly initialized
// And that ViewPro is available for use

If (Storage:C1525.ViewPro=Null:C1517)
	
	Use (Storage:C1525)
		
		$o:=New shared object:C1526
		
		Use ($o)
			
			$o.available:=(Version type:C495 ?? 64 bit version:K5:25) & (Is license available:C714(4D View license:K44:4))
			vp_fillStorage($o)
			
		End use 
		
		Storage:C1525.ViewPro:=$o
		
	End use 
	
Else 
	
	If (Storage:C1525.ViewPro.available=Null:C1517)
		
		Use (Storage:C1525.ViewPro)
			
			Storage:C1525.ViewPro.available:=(Version type:C495 ?? 64 bit version:K5:25) & (Is license available:C714(4D View license:K44:4))
			
		End use 
	End if 
End if 

return Storage:C1525.ViewPro.available