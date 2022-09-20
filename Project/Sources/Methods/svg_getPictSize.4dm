//%attributes = {"invisible":true,"preemptive":"capable"}
C_POINTER:C301($1; $backgroundImage; $2; $width; $3; $height)
C_PICTURE:C286($pict)

$backgroundImage:=$1
$width:=$2
$height:=$3

If (Position:C15("file://"; $backgroundImage->)>0)
	READ PICTURE FILE:C678(Replace string:C233($backgroundImage->; "file://"; ""); $pict)
Else 
	$pict:=svg_convertBase64ToPicture($backgroundImage)
End if 

PICTURE PROPERTIES:C457($pict; $width->; $height->)