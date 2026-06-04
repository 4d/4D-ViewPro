//%attributes = {"invisible":true,"preemptive":"capable"}
var $sortedMap : Collection
var $1 : Collection
var $y : Integer
var $2 : Integer
var $x : Integer
var $3 : Integer
var $0 : Object
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