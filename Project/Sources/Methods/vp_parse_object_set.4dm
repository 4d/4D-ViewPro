//%attributes = {"invisible":true}
#DECLARE($object : Object) : Object

ARRAY TEXT:C222($ar_names; 0)

OB GET PROPERTY NAMES:C1232($object; $ar_names)

var $i; $limit : Integer

var $result:=New object:C1471

$limit:=Size of array:C274($ar_names)

For ($i; 1; $limit)
	$result[$ar_names{$i}]:=vp_parse_element_set($object[$ar_names{$i}])
End for 

return $result