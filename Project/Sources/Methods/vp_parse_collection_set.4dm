//%attributes = {"invisible":true}
#DECLARE($in : Collection) : Collection

var $out:=[]
var $i:=0
var $limit:=$in.length-1
For ($i; 0; $limit)
	$out.push(vp_parse_element_set($in[$i]))
End for 

return $out