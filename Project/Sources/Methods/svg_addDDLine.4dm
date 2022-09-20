//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$lineObj;$line)
C_LONGINT:C283($2;$3;$iterX;$iterY)
C_LONGINT:C283($4;$diagonalDownStyle)
C_TEXT:C284($5;$diagonalDownColor)
C_POINTER:C301($6;$7;$colPos;$rowPos)
C_OBJECT:C1216($8;$range)

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
	
	C_TEXT:C284($strIterX;$strIterY)
	
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