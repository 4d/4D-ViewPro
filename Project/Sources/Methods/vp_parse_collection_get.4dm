//%attributes = {"invisible":true}
var $0 : Collection
var $1 : Collection
$0:=New collection:C1472

var $i : Integer

var $limit : Integer
$i:=0
$limit:=$1.length-1

For ($i; 0; $limit)
	$0.push(vp_parse_element_get($1[$i]))
End for 
