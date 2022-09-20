//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$lineObj;$line)
C_LONGINT:C283($2;$3;$iterX;$iterY)
C_LONGINT:C283($4;$diagonalUpStyle)
C_TEXT:C284($5;$diagonalUpColor)
C_POINTER:C301($6;$7;$colPos;$rowPos)
C_OBJECT:C1216($8;$range)

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
	
	C_TEXT:C284($strIterY;$strIterX)
	
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
