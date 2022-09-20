//%attributes = {"invisible":true,"preemptive":"capable"}
C_COLLECTION:C1488($sortedMap;$1)
C_LONGINT:C283($y;$2;$x;$3)
C_OBJECT:C1216($0)

$sortedMap:=$1
$y:=$2
$x:=$3

If (Not:C34(svg_checkColIndex ($sortedMap;$y)))
	$sortedMap[$y]:=New collection:C1472
End if 

If (Not:C34(svg_checkColIndex ($sortedMap[$y];$x)))
	$sortedMap[$y][$x]:=New object:C1471
End if 

$0:=$sortedMap[$y][$x]