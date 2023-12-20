Class extends __range

property column; row; sheet : Integer

Class constructor($area : Text; $column : Integer; $row : Integer; $columnCount : Integer; $rowCount : Integer; $sheet : Integer)
	
	var $range : Object
	
	$columnCount+=Num:C11($columnCount=0)  // Default is 1
	$rowCount+=Num:C11($rowCount=0)  // Default is 1
	$sheet:=Count parameters:C259<4 ? -1 : $sheet  // Default is -1
	
	$range:={\
		column: $column; \
		row: $row; \
		columnCount: $columnCount; \
		rowCount: $rowCount\
		}
	
	If ($sheet#-1)
		
		$range.sheet:=$sheet
		
	End if 
	
	Super:C1705($area; $range)
	
	This:C1470.column:=$column
	This:C1470.row:=$row
	This:C1470.columnCount:=$columnCount
	This:C1470.rowCount:=$rowCount
	This:C1470.sheet:=$sheet
	
	This:C1470.range:=$range