//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$table)
C_LONGINT:C283($2;$cellPosY;$3;$cellPosX;$4;$rangeX)
C_LONGINT:C283($0;$i)

$table:=$1
$cellPosY:=$2
$cellPosX:=$3
$rangeX:=$4

$i:=$cellPosX
While ($i<=$rangeX)
	
	$i:=$i+1
	Case of 
		: ($table[String:C10($cellPosY)][String:C10($i)]=Null:C1517)
		: ($table[String:C10($cellPosY)][String:C10($i)].value=Null:C1517)
		Else 
			$0:=$i
			$i:=$rangeX+2
	End case 
	
End while 

If ($i#($rangeX+2))
	$0:=-1
End if 