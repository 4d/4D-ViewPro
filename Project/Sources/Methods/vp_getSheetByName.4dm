//%attributes = {"invisible":true}
#DECLARE($wantedName : Text) : Object

var $area : Text:=This:C1470.ViewPro.area
var $nbSheets:=VP Get sheet count($area)
var $i : Integer
For ($i; 0; $nbSheets-1)
	var $name:=VP Get sheet name($area; $i)
	If ($name=$wantedName)
		return vp_makeSheet($area; $i)
	End if 
End for 

return Null:C1517
