//%attributes = {"invisible":true}
C_BOOLEAN:C305($0)

If (False:C215)
	C_BOOLEAN:C305(vp_initStorage; $0)
End if 

// should be called before any API call to ensure that Storage.ViewPro object is correctly initialized
// and that ViewPro is available for use

If (Storage:C1525.ViewPro=Null:C1517)
	
	Use (Storage:C1525)
		
		C_OBJECT:C1216($obj)
		$obj:=New shared object:C1526
		
		Use ($obj)
			
			$obj.available:=(Version type:C495 ?? 64 bit version:K5:25) & (Is license available:C714(4D View license:K44:4))
			vp_fillStorage($obj)
			
		End use 
		
		
		Storage:C1525.ViewPro:=$obj
		
	End use 
	
Else 
	
	// if vp_initStorage_no_licence_check has been called before Storage.ViewPro.available has not been set
	If (Storage:C1525.ViewPro.available=Null:C1517)
		
		Use (Storage:C1525.ViewPro)
			
			Storage:C1525.ViewPro.available:=(Version type:C495 ?? 64 bit version:K5:25) & (Is license available:C714(4D View license:K44:4))
			
		End use 
	End if 
End if 

$0:=Storage:C1525.ViewPro.available

