//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Pointer
var $backgroundImage : Pointer
var $2 : Pointer
var $width : Pointer
var $3 : Pointer
var $height : Pointer
var $pict : Picture
$backgroundImage:=$1
$width:=$2
$height:=$3

If (Position:C15("file://"; $backgroundImage->)>0)
	READ PICTURE FILE:C678(Replace string:C233($backgroundImage->; "file://"; ""); $pict)
Else 
	$pict:=svg_convertBase64ToPicture($backgroundImage)
End if 

PICTURE PROPERTIES:C457($pict; $width->; $height->)