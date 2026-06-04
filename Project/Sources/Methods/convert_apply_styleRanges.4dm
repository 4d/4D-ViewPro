//%attributes = {"invisible":true}
  // create cells for all the styleRanges
var $1 : Object
var $styleRanges : Collection
var $cells : Collection
$styleRanges:=$1.styleRanges
$cells:=$1.cells

var $cellsArray : Collection
$cellsArray:=New collection:C1472()

var $cell : Object
For each ($cell;$cells)
	
	If ($cell.column>=$cellsArray.length)
		$cellsArray[$cell.column]:=New collection:C1472()
	End if 
	
	$cellsArray[$cell.column][$cell.row]:=$cell
	
End for each 

var $styleRange : Object

var $style : Object

var $cellStyle : Object
var $col : Integer
var $row : Integer
var $right : Integer
var $bottom : Integer
var $prop : Integer
ARRAY TEXT:C222($ar;0)

For each ($styleRange;$styleRanges)
	
	$style:=$styleRange.style
	
	$right:=$styleRange.right
	If ($right=2147483647)
		$right:=$1.columnCount
	End if 
	
	For ($col;$styleRange.left;$right)
		
		If ($col>=$cellsArray.length)
			$cellsArray[$col]:=New collection:C1472()
		End if 
		
		$bottom:=$styleRange.bottom
		If ($bottom=2147483647)
			$bottom:=$1.rowCount
		End if 
		
		For ($row;$styleRange.top;$bottom)
			
			If ($cellsArray[$col]=Null:C1517)
				$cellsArray[$col]:=New collection:C1472()
			End if 
			
			If ($row>=$cellsArray[$col].length)
				$cellsArray[$col][$row]:=New object:C1471("kind";"empty";"style";$style;"column";$col;"row";$row)
			Else 
				If (Null:C1517=$cellsArray[$col][$row])
					$cellsArray[$col][$row]:=New object:C1471("kind";"empty";"style";$style;"column";$col;"row";$row)
				Else 
					
					$cellStyle:=$cellsArray[$col][$row].style
					$cellsArray[$col][$row].style:=OB Copy:C1225($style)
					
					If (Null:C1517#$cellStyle)
						
						OB GET PROPERTY NAMES:C1232($cellStyle;$ar)
						
						For ($prop;1;Size of array:C274($ar))
							$cellsArray[$col][$row].style[$ar{$prop}]:=$cellStyle[$ar{$prop}]
						End for 
						
					End if 
					
				End if 
			End if 
			
		End for 
	End for 
	
End for each 

$1._cells:=$cellsArray
