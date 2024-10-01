//%attributes = {"invisible":true}
// Should be called before any API call to ensure that Storage.ViewPro object is correctly initialized
// And that ViewPro is available for use

If (Storage:C1525.ViewPro=Null:C1517)
	
	Use (Storage:C1525)
		
		var $o : Object
		$o:=New shared object:C1526
		
		Use ($o)
			
			vp_fillStorage($o)
			
		End use 
		
		Storage:C1525.ViewPro:=$o
		
	End use 
End if 