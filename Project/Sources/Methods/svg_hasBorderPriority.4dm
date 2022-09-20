//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($priorityTable)

$priorityTable:=New object:C1471
$priorityTable["0"]:=0
$priorityTable["9"]:=1
$priorityTable["1"]:=1
$priorityTable["3"]:=1
$priorityTable["4"]:=1
$priorityTable["7"]:=1
$priorityTable["11"]:=1
$priorityTable["2"]:=2
$priorityTable["10"]:=2
$priorityTable["12"]:=2
$priorityTable["8"]:=2
$priorityTable["13"]:=2
$priorityTable["5"]:=3
$priorityTable["6"]:=3

C_LONGINT:C283($1;$2;$firstCell;$secondCell)

$firstCell:=$1
$secondCell:=$2

C_TEXT:C284($strFirstCell;$strSecondCell)

$strFirstCell:=String:C10($firstCell)
$strSecondCell:=String:C10($secondCell)

Case of 
	: ($firstCell=0)
		$0:=True:C214
	: ($secondCell=0)
		$0:=False:C215
	: ($firstCell=NONE_BORDER_STYLE)
		$0:=False:C215
	: ($secondCell=NONE_BORDER_STYLE)
		$0:=True:C214
	: ($secondCell>13)
		$0:=True:C214
	: ($firstCell>13)
		If ($secondCell=6)
			$0:=False:C215
		Else 
			$0:=True:C214
		End if 
	: ($priorityTable[$strFirstCell]>$priorityTable[$strSecondCell])
		$0:=True:C214
	: ($priorityTable[$strFirstCell]=$priorityTable[$strSecondCell])
		If ((($secondCell=2) & ($firstCell#2)) | (($secondCell=1) & ($firstCell#1)) | (($secondCell=6) & ($firstCell#6)))
			$0:=False:C215
		Else 
			$0:=True:C214
		End if 
	Else 
		$0:=False:C215
End case 