//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$doubleLineObj)
C_LONGINT:C283($2;$3)
C_POINTER:C301($4;$dliDirectionPtr)
C_TEXT:C284($strIterY;$strIterX)

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