//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($lineObj;$1)
C_LONGINT:C283($x;$2;$y;$3;$style;$4;$orientation;$6;$offset;$8;$position;$9)
C_BOOLEAN:C305($isOriented;$7)
C_TEXT:C284($color;$5)

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