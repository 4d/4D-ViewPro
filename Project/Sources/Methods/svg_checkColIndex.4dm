//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Collection
var $2 : Integer
var $0 : Boolean
Case of 
	: ($1.length<=$2)
		$0:=False:C215
	: ($1[$2]=Null:C1517)
		$0:=False:C215
	Else 
		$0:=True:C214
End case 