//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Object
var $doubleLineObj : Object
var $2 : Integer
var $3 : Integer
var $4 : Pointer
var $dliDirectionPtr : Pointer
var $strIterY : Text
var $strIterX : Text
$doubleLineObj:=$1
$strIterY:=String:C10($2)
$strIterX:=String:C10($3)
$dliDirectionPtr:=$4

$0:=False:C215
Case of 
	: ($doubleLineObj=Null:C1517)
	: ($doubleLineObj[$strIterY]=Null:C1517)
	: ($doubleLineObj[$strIterY][$strIterX]=Null:C1517)
	: ($doubleLineObj[$strIterY][$strIterX][$dliDirectionPtr->]=Null:C1517)
	: ($doubleLineObj[$strIterY][$strIterX][$dliDirectionPtr->]=EMPTY_STRING)
	Else 
		$0:=True:C214
End case 