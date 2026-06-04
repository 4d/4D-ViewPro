//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Text
var $srcRef : Text
var $2 : Text
var $destRef : Text
var $name : Text
var $value : Text
var $nbAttr : Integer
var $i : Integer
$srcRef:=$1
$destRef:=$2

$nbAttr:=DOM Count XML attributes:C727($srcRef)

For ($i;1;$nbAttr)
	DOM GET XML ATTRIBUTE BY INDEX:C729($srcRef;$i;$name;$value)
	DOM SET XML ATTRIBUTE:C866($destRef;$name;$value)
End for 