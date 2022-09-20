//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1; $table)
C_LONGINT:C283($2; $cellPosY; $3; $cellPosX)
C_LONGINT:C283($0; $i)
C_LONGINT:C283($4; $rangeX1)

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