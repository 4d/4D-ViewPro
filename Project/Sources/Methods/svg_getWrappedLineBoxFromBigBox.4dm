//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$bigBox;$2;$line;$0;$lineBox)

$bigBox:=$1
$line:=$2

C_REAL:C285($middleBigBoxX)

$middleBigBoxX:=($bigBox.topRight.x-$bigBOx.topLeft.x)/2

$lineBox:=New object:C1471
$lineBox.topLeft:=New object:C1471
$lineBox.topLeft.x:=$bigBox.topLeft.x+$middleBigBoxX-($line.width/2)
$lineBox.topLeft.y:=$bigBox.topLeft.y

$lineBox.topRight:=New object:C1471
$lineBox.topRight.x:=$bigBox.topRight.x-$middleBigBoxX+($line.width/2)
$lineBox.topRight.y:=$bigBox.topRight.y

$lineBox.bottomLeft:=New object:C1471
$lineBox.bottomLeft.x:=$bigBox.bottomLeft.x+$middleBigBoxX-($line.width/2)
$lineBox.bottomLeft.y:=$bigBox.bottomLeft.y

$lineBox.bottomRight:=New object:C1471
$lineBox.bottomRight.x:=$bigBox.bottomRight.x-$middleBigBoxX+($line.width/2)
$lineBox.bottomRight.y:=$bigBox.bottomRight.y

$0:=$lineBox