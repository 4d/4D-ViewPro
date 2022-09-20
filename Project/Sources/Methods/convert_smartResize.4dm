//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : convert_smartResize
// Database: Convert4DView
// ID[2BFDF21EE4C04CCE889D229D4A55A9C5]
// Created #19-9-2018 by Francois Marchal
// ----------------------------------------------------

// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($1)

If (False:C215)
	C_OBJECT:C1216(convert_smartResize; $1)
End if 

C_OBJECT:C1216($Obj_d4)
$Obj_d4:=$1

C_LONGINT:C283($maxHeight; $maxWidth)

// ----- if 4D View document is bigger than default 4D View Pro document, 
// ----- then use default 4D View Pro document size

If ($Obj_d4.columnCount>20)
	$maxWidth:=20
Else 
	$maxWidth:=$Obj_d4.columnCount
End if 

If ($Obj_d4.rowCount>200)
	$maxHeight:=200
Else 
	$maxHeight:=$Obj_d4.rowCount
End if 

// ----- ensure that all cells are enclosed in default 4D View Pro document
// ----- enlarge document if needed

C_OBJECT:C1216($cell)

For each ($cell; $Obj_d4.cells)
	
	If (($cell.value#Null:C1517) | ($cell.formula#Null:C1517))
		
		If ($cell.column>$maxWidth)
			$maxWidth:=$cell.column+1
		End if 
		
		If ($cell.row>$maxHeight)
			$maxHeight:=$cell.row+1
		End if 
		
	End if 
	
End for each 

// ----- ensure that all style ranges are enclosed in those new boundaries

C_OBJECT:C1216($styleRange)

If ($Obj_d4.styleRanges#Null:C1517)
	If (Value type:C1509($Obj_d4.styleRanges)=Is collection:K8:32)
		For each ($styleRange; $Obj_d4.styleRanges)
			convert_ensureRect($styleRange; $maxWidth; $maxHeight)
		End for each 
	End if 
End if 

// ----- ensure that all edges are enclosed in those new boundaries

C_OBJECT:C1216($rowEdge)

If ($Obj_d4.rowEdges#Null:C1517)
	If (Value type:C1509($Obj_d4.rowEdges)=Is collection:K8:32)
		For each ($rowEdge; $Obj_d4.rowEdges)
			convert_ensureRect($rowEdge; $maxWidth+1; $maxHeight+1)
		End for each 
	End if 
End if 

C_OBJECT:C1216($columnEdge)

If ($Obj_d4.columnEdges#Null:C1517)
	If (Value type:C1509($Obj_d4.columnEdges)=Is collection:K8:32)
		For each ($columnEdge; $Obj_d4.columnEdges)
			convert_ensureRect($columnEdge; $maxWidth+1; $maxHeight+1)
		End for each 
	End if 
End if 

C_OBJECT:C1216($selectedRange)

If ($Obj_d4.selectedRanges#Null:C1517)
	If (Value type:C1509($Obj_d4.selectedRanges)=Is collection:K8:32)
		For each ($selectedRange; $Obj_d4.selectedRanges)
			convert_ensureRect($selectedRange; $maxWidth; $maxHeight)
		End for each 
	End if 
End if 

// ----- finally, set new size to the document

$Obj_d4.columnCount:=$maxWidth
$Obj_d4.rowCount:=$maxHeight
