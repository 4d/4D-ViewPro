//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Object
var $lineObj : Object
var $line : Object
var $2 : Integer
var $3 : Integer
var $iterX : Integer
var $iterY : Integer
var $4 : Integer
var $diagonalUpStyle : Integer
var $5 : Text
var $diagonalUpColor : Text
var $6 : Pointer
var $7 : Pointer
var $colPos : Pointer
var $rowPos : Pointer
var $8 : Object
var $range : Object
$lineObj:=$1
$iterX:=$2
$iterY:=$3
$diagonalUpStyle:=$4
$diagonalUpColor:=$5
$colPos:=$6
$rowPos:=$7
$range:=$8

If ($diagonalUpStyle=6)
	$iterY:=$iterY+1
	
	If ($lineObj.double=Null:C1517)
		$lineObj.double:=New object:C1471
	End if 
	
	var $strIterY : Text
	
	var $strIterX : Text
	$strIterY:=String:C10($iterY)
	$strIterX:=String:C10($iterX)
	
	If ($lineObj.double[$strIterY]=Null:C1517)
		$lineObj.double[$strIterY]:=New object:C1471
	End if 
	
	If ($lineObj.double[$strIterY][$strIterX]=Null:C1517)
		$lineObj.double[$strIterY][$strIterX]:=New object:C1471
	End if 
	
	$lineObj.double[$strIterY][$strIterX].du:=$diagonalUpColor
	$lineObj.double[$strIterY][$strIterX].upDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].downDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].leftDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].rightDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DDUpDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DDDownDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DUUpDrawed:=False:C215
	$lineObj.double[$strIterY][$strIterX].DUDownDrawed:=False:C215
	
Else 
	
	If ($diagonalUpStyle>0) & ($diagonalUpStyle<=13)
		
		$line:=New object:C1471
		$line.y1:=$rowPos->{Int:C8($iterY-$range.y1+2)}
		$line.y2:=$rowPos->{Int:C8($iterY-$range.y1+1)}
		$line.x1:=$colPos->{Int:C8($iterX-$range.x1+1)}
		$line.x2:=$colPos->{Int:C8($iterX-$range.x1+2)}
		$line.color:=$diagonalUpColor
		$line.style:=$diagonalUpStyle
		$lineObj.lines.push($line)
		
	End if 
	
End if 
