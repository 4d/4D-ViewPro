//%attributes = {"invisible":true}
#DECLARE($area : Text) : Object

var $obj:=OBJECT Get value:C1743($area)

If ($obj.ViewPro#Null:C1517)
	return $obj.ViewPro.formulas
End if 