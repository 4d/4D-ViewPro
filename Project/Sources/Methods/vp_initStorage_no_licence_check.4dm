//%attributes = {"invisible":true}
// should be called before any API call to ensure that Storage.ViewPro object is correctly initialized
// and that ViewPro is available for use

If (Storage:C1525.ViewPro=Null:C1517)
	Use (Storage:C1525)
		C_OBJECT:C1216($obj)
		$obj:=New shared object:C1526
		Use ($obj)
			vp_fillStorage($obj)
		End use 
		Storage:C1525.ViewPro:=$obj
	End use 
End if 
