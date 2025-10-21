//%attributes = {"invisible":true}
#DECLARE($in : Object) : Object

ARRAY TEXT:C222($ar_names; 0)

OB GET PROPERTY NAMES:C1232($in; $ar_names)

var $out:=New object:C1471
var $limit:=Size of array:C274($ar_names)

var $i : Integer
For ($i; 1; $limit)
	$out[$ar_names{$i}]:=vp_parse_element_get($in[$ar_names{$i}])
End for 

return $out