//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($bcObj : Object; $iterX : Integer; $iterY : Integer; $x1 : Integer; $y1 : Integer; $width : Integer; $height : Integer; $color : Text; $offset : Integer; $isOriented : Boolean)

var $sIterX; $sIterY : Text
$sIterX:=String:C10($iterX)
$sIterY:=String:C10($iterY)

If ($bcObj.bcGrid[$sIterY]=Null:C1517)
	$bcObj.bcGrid[$sIterY]:=New object:C1471
End if 

If ($bcObj.bcGrid[$sIterY][$sIterX]=Null:C1517)
	$bcObj.bcGrid[$sIterY][$sIterX]:=New object:C1471("col"; $color; "isOriented"; $isOriented; "offset"; $offset)
End if 

If ($color="$4D_NOCOLOR")
	return 
End if 

var $sameLeftColor : Boolean
$sameLeftColor:=False:C215

var $sIterXm : Text
$sIterXm:=String:C10($iterX-1)

var $ref : Integer
Case of 
	: ($iterX=0)
	: ($bcObj.bcGrid[$sIterY]=Null:C1517)
	: ($bcObj.bcGrid[$sIterY][$sIterXm]=Null:C1517)
	: ($bcObj.bcGrid[$sIterY][$sIterXm].col=$color) && (Not:C34($bcObj.bcGrid[$sIterY][$sIterXm].isOriented))
		$sameLeftColor:=True:C214
		$ref:=$bcObj.bcGrid[$sIterY][$sIterXm].ref
		$bcObj.bcGrid[$sIterY][$sIterX].ref:=$ref
		$bcObj.bcCol[$ref].w:=$bcObj.bcCol[$ref].w+$width
End case 

If (Not:C34($sameLeftColor))
	
	$ref:=$bcObj.bcCol.length
	$bcObj.bcGrid[$sIterY][$sIterX].ref:=$ref
	$bcObj.bcCol[$ref]:=New object:C1471("x"; $x1; "y"; $y1; "w"; $width; "h"; $height; "c"; $color; "isOriented"; $isOriented; "offset"; $offset)
	
End if 