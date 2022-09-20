//%attributes = {"invisible":true}
C_COLLECTION:C1488($0)
C_COLLECTION:C1488($1)

$0:=New collection:C1472

C_LONGINT:C283($i; $limit)

$i:=0
$limit:=$1.length-1

For ($i; 0; $limit)
	$0.push(vp_parse_element_set($1[$i]))
End for 
