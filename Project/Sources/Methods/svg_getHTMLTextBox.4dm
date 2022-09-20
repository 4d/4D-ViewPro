//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($0;$box)
C_LONGINT:C283($1;$2;$3;$4;$x;$y;$textWidth;$lineHeight)

$x:=$1
$y:=$2
$textWidth:=$3
$lineHeight:=$4

$box:=New object:C1471
$box.topLeft:=New object:C1471
$box.topLeft.x:=$x
$box.topLeft.y:=$y-(0.8*$lineHeight)

$box.topRight:=New object:C1471
$box.topRight.x:=$x+$textWidth+3
$box.topRight.y:=$y-(0.8*$lineHeight)

$box.bottomLeft:=New object:C1471
$box.bottomLeft.x:=$x
$box.bottomLeft.y:=$y+(0.5*$lineHeight)

$box.bottomRight:=New object:C1471
$box.bottomRight.x:=$x+$textWidth+3
$box.bottomRight.y:=$y+(0.5*$lineHeight)

$0:=$box
