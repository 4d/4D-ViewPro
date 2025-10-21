//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($backgroundImage : Pointer; $width : Pointer; $height : Pointer)

var $pict : Picture
If (Position:C15("file://"; $backgroundImage->)>0)
	READ PICTURE FILE:C678(Replace string:C233($backgroundImage->; "file://"; ""); $pict)
Else 
	$pict:=svg_convertBase64ToPicture($backgroundImage)
End if 

PICTURE PROPERTIES:C457($pict; $width->; $height->)