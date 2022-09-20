//%attributes = {"invisible":true}
  // called from js via C++ when a pdf is exported.

C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_OBJECT:C1216($fonts)
$fonts:=New object:C1471

ARRAY TEXT:C222($shorthands;0)
OB GET PROPERTY NAMES:C1232($1;$shorthands)

C_LONGINT:C283($i)

For ($i;1;Size of array:C274($shorthands))
	vp_makeFont ($fonts;$shorthands{$i})
End for 

$0:=$fonts