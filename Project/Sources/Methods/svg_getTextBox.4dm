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
