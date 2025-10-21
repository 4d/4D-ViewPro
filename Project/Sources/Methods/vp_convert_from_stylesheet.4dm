//%attributes = {"invisible":true}
#DECLARE($stylesheet : Object) : Object

var $newStylesheet:=OB Copy:C1225($stylesheet)

vp_get_picture($newStylesheet; "backgroundImage")

return $newStylesheet