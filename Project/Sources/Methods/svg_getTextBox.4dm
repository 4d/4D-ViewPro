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
$box.topLeft.y:=$y

$box.topRight:=New object:C1471
$box.topRight.x:=$x+$textWidth
$box.topRight.y:=$y

$box.bottomLeft:=New object:C1471
$box.bottomLeft.x:=$x
$box.bottomLeft.y:=$y+$lineHeight

$box.bottomRight:=New object:C1471
$box.bottomRight.x:=$x+$textWidth
$box.bottomRight.y:=$y+$lineHeight

$0:=$box
