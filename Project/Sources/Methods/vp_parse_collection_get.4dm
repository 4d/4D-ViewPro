//%attributes = {"invisible":true}
#DECLARE($in : Collection) : Collection
var $out:=New collection:C1472

var $i; $limit : Integer

$i:=0
$limit:=$in.length-1

For ($i; 0; $limit)
	$out.push(vp_parse_element_get($in[$i]))
End for 

return $out