//%attributes = {"invisible":true,"preemptive":"capable"}
var $0 : Object
var $status : Object
var $1 : Integer
var $row : Integer
var $2 : Integer
var $column : Integer
var $3 : Collection
var $mergeTable : Collection
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