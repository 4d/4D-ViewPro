//%attributes = {"invisible":true,"preemptive":"capable"}
C_LONGINT:C283($1; $iterY; $2; $iterX)
C_TEXT:C284($3; $styleLabel)
C_OBJECT:C1216($4; $table)

$iterY:=$1
$iterX:=$2
$styleLabel:=$3
$table:=$4

$0:=False:C215
Case of 
	: ($table=Null:C1517)
	: ($table[String:C10($iterY)]=Null:C1517)
	: ($table[String:C10($iterY)][String:C10($iterX)]=Null:C1517)
	: ($table[String:C10($iterY)][String:C10($iterX)].style=Null:C1517)
	: (Not:C34(Value type:C1509($table[String:C10($iterY)][String:C10($iterX)].style)=Is object:K8:27))
	: ($table[String:C10($iterY)][String:C10($iterX)].style[$styleLabel]=Null:C1517)
	Else 
		$0:=True:C214
End case 