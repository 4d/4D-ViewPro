//%attributes = {"invisible":true}
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_LONGINT:C283($i;$nbSheets)
C_TEXT:C284($name;$area)
$area:=This:C1470.ViewPro.area
$nbSheets:=VP get sheet count ($area)
For ($i;0;$nbSheets-1)
	$name:=VP get sheet name ($area;$i)
	If ($name=$1)
		$0:=vp_makeSheet ($area;$i)
		$i:=$nbSheets
	End if 
End for 
