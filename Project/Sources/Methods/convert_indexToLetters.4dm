//%attributes = {"invisible":true}
#DECLARE($index : Integer) : Text

var $sb : Text
var $code : Integer
$code:=Character code:C91("A")
var $n : Integer

While ($index>0)
	$n:=Mod:C98($index-1; 26)
	$sb:=Char:C90($code+$n)+$sb
	$index:=$index\26
End while 

return $sb
