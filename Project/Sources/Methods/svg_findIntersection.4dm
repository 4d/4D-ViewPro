//%attributes = {"invisible":true,"preemptive":"capable"}
var $Px : Real
var $1 : Real
var $Py : Real
var $2 : Real
var $Ax : Real
var $3 : Real
var $Ay : Real
var $4 : Real
var $Bx : Real
var $5 : Real
var $By : Real
var $6 : Real
var $0 : Object
$Px:=$1
$Py:=$2
$Ax:=$3
$Ay:=$4
$Bx:=$5
$By:=$6

var $cDir : Real

var $ordOrig : Real
$cDir:=($By-$Ay)/($Bx-$Ax)

$ordOrig:=$Ay-($cDir*$Ax)

$0:=New object:C1471

$0.x:=($Py-$ordOrig)/$cDir
$0.y:=($cDir*$0.x)+$ordOrig