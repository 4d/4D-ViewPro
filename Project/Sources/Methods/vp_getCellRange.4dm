//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1; $vpObject; $2; $cells; $sheets; $workbook; $table)
C_LONGINT:C283($biggestCol; $biggestRow)
C_OBJECT:C1216($range; $0)
C_TEXT:C284($s; $currentCol; $currentRow)
C_COLLECTION:C1488($sheetCol)

$vpObject:=$1
If (Count parameters:C259>=2)
	$cells:=$2
Else 
	$cells:=Null:C1517
End if 

If (Value type:C1509($vpObject.spreadJS)=Is object:K8:27)
	$workbook:=$vpObject.spreadJS
	
	$sheetCol:=New collection:C1472
	
	For each ($s; $workbook.sheets)
		$sheetCol.push($workbook.sheets[$s])
	End for each 
	
	If (Value type:C1509($workbook.activeSheetIndex)=Is real:K8:4)
		$sheets:=$sheetCol[$vpObject.spreadJS.activeSheetIndex]
	Else 
		$sheets:=$sheetCol[0]
	End if 
	
	Case of 
		: ($cells=Null:C1517)
		: ($cells.ranges=Null:C1517)
		: ($cells.ranges[0]=Null:C1517)
		: ($cells.ranges[0].sheet=Null:C1517)
		: (Value type:C1509($cells.ranges[0].sheet)#Is real:K8:4)
		Else 
			If ($sheetCol.length>$cells.ranges[0].sheet)
				$sheets:=$sheetCol[$cells.ranges[0].sheet]
			End if 
	End case 
	
End if 

If ($sheets#Null:C1517)
	$table:=$sheets.data.dataTable
Else 
	$table:=Null:C1517
End if 

$range:=New object:C1471("isAll"; False:C215; "isAllRow"; False:C215; "isAllCol"; False:C215)

Case of 
	: ($cells=Null:C1517)
		$range.isAll:=True:C214
	: ($cells.ranges=Null:C1517)
		$cells:=Null:C1517
		$range.isAll:=True:C214
	: ($cells.ranges[0]=Null:C1517)
		$cells:=Null:C1517
		$range.isAll:=True:C214
	: (($cells.ranges[0].row=Null:C1517) & ($cells.ranges[0].column=Null:C1517))
		$cells:=Null:C1517
		$range.isAll:=True:C214
	Else 
		$cells:=$cells.ranges[0]
		If ($cells.row#Null:C1517)
			
			$range.y1:=$cells.row
			If ($cells.rowCount#Null:C1517)
				
				$range.y2:=$range.y1+$cells.rowCount-1
				
				If ($cells.column=Null:C1517)
					
					$biggestRow:=0
					For each ($currentRow; $table)
						For each ($currentCol; $table[$currentRow])
							
							If (Not:C34(Value type:C1509($table[$currentRow][$currentCol].value)=Is undefined:K8:13))
								If (Num:C11($currentCol)>$biggestRow)
									$biggestRow:=Num:C11($currentCol)
								End if 
							End if 
							
						End for each 
					End for each 
					
					$range.x1:=0
					$range.x2:=$biggestRow
					
				End if 
			Else 
				$range.y2:=$range.y1
			End if 
		Else 
			$range.isAllRow:=True:C214
		End if 
		
		If ($cells.column#Null:C1517)
			
			$range.x1:=$cells.column
			If ($cells.columnCount#Null:C1517)
				
				$range.x2:=$range.x1+$cells.columnCount-1
				
				If ($cells.row=Null:C1517)
					
					$biggestCol:=0
					For each ($currentRow; $table)
						For each ($currentCol; $table[$currentRow])
							
							If (Not:C34(Value type:C1509($table[$currentRow][$currentCol].value)=Is undefined:K8:13))
								If (Num:C11($currentRow)>$biggestCol)
									$biggestCol:=Num:C11($currentRow)
								End if 
							End if 
							
						End for each 
					End for each 
					
					$range.y1:=0
					$range.y2:=$biggestCol
					
				End if 
			Else 
				$range.x2:=$range.x1
			End if 
		Else 
			$range.isAllCol:=True:C214
		End if 
End case 

If ($cells=Null:C1517)
	
	$biggestCol:=0
	$biggestRow:=0
	
	If ($table#Null:C1517)
		For each ($currentRow; $table)
			
			For each ($currentCol; $table[$currentRow])
				
				If (Not:C34(Value type:C1509($table[$currentRow][$currentCol].value)=Is undefined:K8:13))
					If (Num:C11($currentRow)>$biggestCol)
						$biggestCol:=Num:C11($currentRow)
					End if 
					
					
					If (Num:C11($currentCol)>$biggestRow)
						$biggestRow:=Num:C11($currentCol)
					End if 
				End if 
				
			End for each 
		End for each 
	End if 
	
	$range.x1:=0
	$range.x2:=$biggestRow
	$range.y1:=0
	$range.y2:=$biggestCol
	
End if 

$0:=$range