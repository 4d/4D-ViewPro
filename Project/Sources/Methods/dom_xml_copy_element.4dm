//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$srcRef;$2;$destRef;$name;$value)
C_LONGINT:C283($nbAttr;$i)

$srcRef:=$1
$destRef:=$2

$nbAttr:=DOM Count XML attributes:C727($srcRef)

For ($i;1;$nbAttr)
	DOM GET XML ATTRIBUTE BY INDEX:C729($srcRef;$i;$name;$value)
	DOM SET XML ATTRIBUTE:C866($destRef;$name;$value)
End for 