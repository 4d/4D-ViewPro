//%attributes = {"invisible":true}
var $0 : Object
var $1 : Text
var $i : Integer
var $nbSheets : Integer
var $name : Text
var $area : Text
$area:=This:C1470.ViewPro.area
$nbSheets:=VP get sheet count ($area)
For ($i;0;$nbSheets-1)
	$name:=VP get sheet name ($area;$i)
	If ($name=$1)
		$0:=vp_makeSheet ($area;$i)
		$i:=$nbSheets
	End if 
End for 
