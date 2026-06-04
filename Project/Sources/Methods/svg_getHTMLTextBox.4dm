//%attributes = {"invisible":true,"preemptive":"capable"}
var $0 : Object
var $box : Object
var $1 : Integer
var $2 : Integer
var $3 : Integer
var $4 : Integer
var $x : Integer
var $y : Integer
var $textWidth : Integer
var $lineHeight : Integer
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
