//%attributes = {"invisible":true}
#DECLARE($area : Text) : Object

var $o : Object:=OBJECT Get value:C1743($area)

If ($o#Null:C1517)\
 && (Value type:C1509($o.ViewPro)=Is object:K8:27)
	
	return $o.ViewPro
	
End if 