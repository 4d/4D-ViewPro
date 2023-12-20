//%attributes = {"invisible":true}
#DECLARE($area : Text) : Object

If (False:C215)
	C_TEXT:C284(vp_getAreaVariable; $1)
	C_OBJECT:C1216(vp_getAreaVariable; $0)
End if 

var $o : Object

$o:=OBJECT Get value:C1743($area)

If ($o#Null:C1517)\
 && (Value type:C1509($o.ViewPro)=Is object:K8:27)
	
	return $o.ViewPro
	
End if 