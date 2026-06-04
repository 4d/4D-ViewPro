//%attributes = {"invisible":true,"preemptive":"capable"}
var $0 : Object
var $rotatedBox : Object
var $1 : Object
var $initialBox : Object
var $2 : Real
var $centerX : Real
var $3 : Real
var $centerY : Real
var $4 : Real
var $radOrientation : Real
$initialBox:=$1
$centerX:=$2
$centerY:=$3
$radOrientation:=$4

$rotatedBox:=New object:C1471
$rotatedBox.topLeft:=New object:C1471
$rotatedBox.topLeft.x:=(($initialBox.topLeft.x-$centerX)*Cos:C18($radOrientation))+(($initialBox.topLeft.y-$centerY)*Sin:C17($radOrientation))+$centerX
$rotatedBox.topLeft.y:=-(($initialBox.topLeft.x-$centerX)*Sin:C17($radOrientation))+(($initialBOx.topLeft.y-$centerY)*Cos:C18($radOrientation))+$centerY

$rotatedBox.topRight:=New object:C1471
$rotatedBox.topRight.x:=(($initialBox.topRight.x-$centerX)*Cos:C18($radOrientation))+(($initialBox.topRight.y-$centerY)*Sin:C17($radOrientation))+$centerX
$rotatedBox.topRight.y:=-(($initialBox.topRight.x-$centerX)*Sin:C17($radOrientation))+(($initialBOx.topRight.y-$centerY)*Cos:C18($radOrientation))+$centerY

$rotatedBox.bottomLeft:=New object:C1471
$rotatedBox.bottomLeft.x:=(($initialBox.bottomLeft.x-$centerX)*Cos:C18($radOrientation))+(($initialBox.bottomLeft.y-$centerY)*Sin:C17($radOrientation))+$centerX
$rotatedBox.bottomLeft.y:=-(($initialBox.bottomLeft.x-$centerX)*Sin:C17($radOrientation))+(($initialBOx.bottomLeft.y-$centerY)*Cos:C18($radOrientation))+$centerY

$rotatedBox.bottomRight:=New object:C1471
$rotatedBox.bottomRight.x:=(($initialBox.bottomRight.x-$centerX)*Cos:C18($radOrientation))+(($initialBox.bottomRight.y-$centerY)*Sin:C17($radOrientation))+$centerX
$rotatedBox.bottomRight.y:=-(($initialBox.bottomRight.x-$centerX)*Sin:C17($radOrientation))+(($initialBOx.bottomRight.y-$centerY)*Cos:C18($radOrientation))+$centerY

$0:=$rotatedBox