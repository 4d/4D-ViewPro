//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Object
var $table : Object
var $2 : Integer
var $cellPosY : Integer
var $3 : Integer
var $cellPosX : Integer
var $0 : Integer
var $i : Integer
var $4 : Integer
var $rangeX1 : Integer
$table:=$1
$cellPosY:=$2
$cellPosX:=$3
$rangeX1:=$4

$i:=$cellPosX
While ($i>=$rangeX1)
	
	$i:=$i-1
	Case of 
		: ($table[String:C10($cellPosY)][String:C10($i)]=Null:C1517)
		: ($table[String:C10($cellPosY)][String:C10($i)].value=Null:C1517)
		Else 
			$0:=$i
			$i:=-2
	End case 
	
End while 

If ($i#-2)
	$0:=-1
End if 