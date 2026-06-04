//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Object
var $lineObj : Object
var $line : Object
var $2 : Integer
var $3 : Integer
var $iterX : Integer
var $iterY : Integer
var $4 : Integer
var $diagonalDownStyle : Integer
var $5 : Text
var $diagonalDownColor : Text
var $6 : Pointer
var $7 : Pointer
var $colPos : Pointer
var $rowPos : Pointer
var $8 : Object
var $range : Object
$lineObj:=$1
$iterX:=$2
$iterY:=$3
$diagonalDownStyle:=$4
$diagonalDownColor:=$5
$colPos:=$6
$rowPos:=$7
$range:=$8

If ($diagonalDownStyle=6)
	
	If ($lineObj.double=Null:C1517)
		$lineObj.double:=New object:C1471
	End if 
	
	var $strIterX : Text
	
	var $strIterY : Text
	$strIterX:=String:C10($iterX)
	$strIterY:=String:C10($iterY)
	
	If ($lineObj.double[$strIterY]=Null:C1517)
		$lineObj.double[$strIterY]:=New object:C1471
	End if 
	
	If ($lineObj.double[$strIterY][$strIterX]=Null:C1517)
		$lineObj.double[$strIterY][$strIterX]:=New object:C1471
	End if 
	
	$lineObj.double[$strIterY][$strIterX].dd:=$diagonalDownColor
	$lineObj.double[$strIterY][$strIterX].upDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].downDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].leftDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].rightDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DDUpDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DDDownDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DUUpDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DUDownDrawed:=False:C215
	
Else 
	
	If ($diagonalDownStyle>0) & ($diagonalDownStyle<=13)
		
		$line:=New object:C1471
		$line.y1:=$rowPos->{Int:C8($iterY-$range.y1+1)}
		$line.y2:=$rowPos->{Int:C8($iterY-$range.y1+2)}
		$line.x1:=$colPos->{Int:C8($iterX-$range.x1+1)}
		$line.x2:=$colPos->{Int:C8($iterX-$range.x1+2)}
		$line.color:=$diagonalDownColor
		$line.style:=$diagonalDownStyle
		$lineObj.lines.push($line)
		
	End if 
	
End if 