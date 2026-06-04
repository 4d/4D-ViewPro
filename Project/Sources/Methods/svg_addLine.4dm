//%attributes = {"invisible":true,"preemptive":"capable"}
var $lineObj : Object
var $1 : Object
var $x : Integer
var $2 : Integer
var $y : Integer
var $3 : Integer
var $style : Integer
var $4 : Integer
var $orientation : Integer
var $6 : Integer
var $offset : Integer
var $8 : Integer
var $position : Integer
var $9 : Integer
var $isOriented : Boolean
var $7 : Boolean
var $color : Text
var $5 : Text
$lineObj:=$1
$x:=$2
$y:=$3
$style:=$4
$color:=$5
$orientation:=$6
$offset:=$8
$isOriented:=$7
$position:=$9

If ($lineObj.map=Null:C1517)
	$lineObj.map:=New collection:C1472
End if 

If (Not:C34(svg_checkColIndex ($lineObj.map;$y)))
	$lineObj.map[$y]:=New collection:C1472
End if 

If (Not:C34(svg_checkColIndex ($lineObj.map[$y];$x)))
	$lineObj.map[$y][$x]:=New collection:C1472
End if 

If (Not:C34(svg_checkColIndex ($lineObj.map[$y][$x];$position))) | ($style=0)
	$lineObj.map[$y][$x][$position]:=New object:C1471
	$lineObj.map[$y][$x][$position].style:=$style
	$lineobj.map[$y][$x][$position].color:=$color
	$lineObj.map[$y][$x][$position].isOriented:=$isOriented
	$lineObj.map[$y][$x][$position].orientation:=$orientation
	$lineObj.map[$y][$x][$position].offset:=$offset
End if 