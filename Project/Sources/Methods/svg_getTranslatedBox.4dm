//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($0;$translatedBox;$1;$initialBox)
C_REAL:C285($2;$translationX;$3;$translationY)

$initialBox:=$1
$translationX:=$2
$translationY:=$3

$translatedBox:=New object:C1471
$translatedBox.topLeft:=New object:C1471
$translatedBox.topLeft.x:=$translationX+$initialBox.topLeft.x
$translatedBox.topLeft.y:=$translationY+$initialBox.topLeft.y

$translatedBox.topRight:=New object:C1471
$translatedBox.topRight.x:=$translationX+$initialBox.topRight.x
$translatedBox.topRight.y:=$translationY+$initialBox.topRight.y

$translatedBox.bottomLeft:=New object:C1471
$translatedBox.bottomLeft.x:=$translationX+$initialBox.bottomLeft.x
$translatedBox.bottomLeft.y:=$translationY+$initialBox.bottomLeft.y

$translatedBox.bottomRight:=New object:C1471
$translatedBox.bottomRight.x:=$translationX+$initialBox.bottomRight.x
$translatedBox.bottomRight.y:=$translationY+$initialBox.bottomRight.y

$0:=$translatedBox