//%attributes = {"invisible":true}
C_TEXT:C284($1)
C_OBJECT:C1216($0)

$0:=Null:C1517

If (False:C215)
	C_TEXT:C284(vp_getAreaVariable ;$1)
	C_OBJECT:C1216(vp_getAreaVariable ;$0)
End if 

C_OBJECT:C1216($var)

$var:=OBJECT Get value:C1743($1)

If ($var#Null:C1517)
	
	If (Value type:C1509($var.ViewPro)=Is object:K8:27)
		
		$0:=$var.ViewPro
		
	End if 
End if 
