//%attributes = {"invisible":true,"preemptive":"capable"}
C_COLLECTION:C1488($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($0)

Case of 
	: ($1.length<=$2)
		$0:=False:C215
	: ($1[$2]=Null:C1517)
		$0:=False:C215
	Else 
		$0:=True:C214
End case 