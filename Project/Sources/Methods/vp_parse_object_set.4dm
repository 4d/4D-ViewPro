//%attributes = {"invisible":true}
C_OBJECT:C1216($1; $0)

ARRAY TEXT:C222($ar_names; 0)

OB GET PROPERTY NAMES:C1232($1; $ar_names)

C_LONGINT:C283($i; $limit)

$0:=New object:C1471

$limit:=Size of array:C274($ar_names)

For ($i; 1; $limit)
	$0[$ar_names{$i}]:=vp_parse_element_set($1[$ar_names{$i}])
End for 