//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$bcObj)
C_LONGINT:C283($2;$iterX;$3;$iterY;$4;$x1;$5;$y1;$6;$width;$7;$height;$9;$offset)
C_TEXT:C284($8;$color)
C_BOOLEAN:C305($10;$isOriented)

C_BOOLEAN:C305($sameLeftColor)
C_LONGINT:C283($ref)
C_TEXT:C284($sIterX;$sIterY;$sIterXm)

$bcObj:=$1
$iterX:=$2
$iterY:=$3
$x1:=$4
$y1:=$5
$width:=$6
$height:=$7
$color:=$8
$offset:=$9
$isOriented:=$10

$sIterX:=String:C10($iterX)
$sIterY:=String:C10($iterY)

If ($bcObj.bcGrid[$sIterY]=Null:C1517)
	$bcObj.bcGrid[$sIterY]:=New object:C1471
End if 

If ($bcObj.bcGrid[$sIterY][$sIterX]=Null:C1517)
	$bcObj.bcGrid[$sIterY][$sIterX]:=New object:C1471("col";$color;"isOriented";$isOriented;"offset";$offset)
End if 

$sameLeftColor:=False:C215

$sIterXm:=String:C10($iterX-1)

Case of 
	: ($iterX=0)
	: ($bcObj.bcGrid[$sIterY]=Null:C1517)
	: ($bcObj.bcGrid[$sIterY][$sIterXm]=Null:C1517)
	: ($bcObj.bcGrid[$sIterY][$sIterXm].col=$color) & (Not:C34($bcObj.bcGrid[$sIterY][$sIterXm].isOriented))
		$sameLeftColor:=True:C214
		$ref:=$bcObj.bcGrid[$sIterY][$sIterXm].ref
		$bcObj.bcGrid[$sIterY][$sIterX].ref:=$ref
		$bcObj.bcCol[$ref].w:=$bcObj.bcCol[$ref].w+$width
End case 

If (Not:C34($sameLeftColor))
	$ref:=$bcObj.bcCol.length
	$bcObj.bcGrid[$sIterY][$sIterX].ref:=$ref
	$bcObj.bcCol[$ref]:=New object:C1471("x";$x1;"y";$y1;"w";$width;"h";$height;"c";$color;"isOriented";$isOriented;"offset";$offset)
	
End if 