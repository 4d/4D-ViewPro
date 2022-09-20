//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($0;$status)
C_LONGINT:C283($1;$row;$2;$column)
C_COLLECTION:C1488($3;$mergeTable)

$row:=$1
$column:=$2
$mergeTable:=$3

$status:=Null:C1517

Case of 
	: ($mergeTable=Null:C1517)
	: (Not:C34(svg_checkColIndex ($mergeTable;$row)))
	: (Not:C34(svg_checkColIndex ($mergeTable[$row];$column)))
	Else 
		$status:=$mergeTable[$row][$column]
End case 

If ($status=Null:C1517)
	$status:=New object:C1471("type";FREE)
End if 

$0:=$status