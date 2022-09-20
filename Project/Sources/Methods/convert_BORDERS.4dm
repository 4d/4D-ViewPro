//%attributes = {"invisible":true}
/*
***convert_BORDERS*** ( d4 ; data )
 -> d4 (Object)
 -> data (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_BORDERS
// Database: Convert4DView
// ID[BD02B0671A3A4604804C316628C6BFC0]
// Created #26-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

C_LONGINT:C283($column; $Lon_i; $Lon_j; $Lon_left; $nbParameters; $row)
C_LONGINT:C283($Lon_top; $tmp_row; $tmp_col)
C_TEXT:C284($Txt_border; $Txt_col; $Txt_row)
C_OBJECT:C1216($Obj_border; $Obj_d4; $Obj_data; $Obj_dataTable; $Obj_edge)
C_COLLECTION:C1488($Col_edges)

If (False:C215)
	C_OBJECT:C1216(convert_BORDERS; $1)
	C_OBJECT:C1216(convert_BORDERS; $2)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=2; "Missing parameter"))
	
	// Required parameters
	$Obj_d4:=$1
	$Obj_data:=$2
	
	// Optional parameters
	If ($nbParameters>=3)
		
		// <NONE>
		
	End if 
	
	$Obj_dataTable:=$Obj_data.dataTable
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

// Top lines =============================================================== [
// 4D View make no difference between top and bottom lines
// We assume all lines are top

$Col_edges:=$Obj_d4.rowEdges


For ($row; 0; $Col_edges.length-1; 1)
	
	$Txt_border:="borderTop"
	
	$Obj_edge:=$Col_edges[$row]
	
	$Obj_border:=New object:C1471("color"; convert_color(Num:C11($Obj_edge.color); False:C215); \
		"style"; Choose:C955(Num:C11($Obj_edge.style); 1; 1; 2; 2; 5; 5; 5; 6; 6; 6; 6; 6; 6; 1; 1); \
		"top"; New collection:C1472)
	
	For ($Lon_i; $Obj_edge.left; $Obj_edge.right; 1)
		
		For ($Lon_j; $Obj_edge.top; $Obj_edge.bottom; 1)
			
			$Obj_border.top[$Obj_border.top.length]:=New collection:C1472($Lon_j-1; $Lon_i-1)
			
		End for 
	End for 
	
	If ($Obj_border.color="black")
		
		OB REMOVE:C1226($Obj_border; "color")  // Black is default
		
	End if 
	
	If ($Obj_edge.left=1)\
		 & ($Obj_edge.right=$Obj_d4.columnCount)
		
		// Apply to the row
		
		// special case if the edge is the last one,
		// it should be a bottomBorder of the last row and not a topBorder of a row after the last.
		If ($Obj_edge.bottom=($Obj_d4.rowCount+1))
			$Txt_border:="borderBottom"
			$Obj_edge.top:=$Obj_edge.top-1
		End if 
		
		
		If ($Obj_data.rowDataArray=Null:C1517)
			
			$Obj_data.rowDataArray:=New collection:C1472
			
		End if 
		
		If ($Obj_data.rowDataArray.length<$Obj_edge.top)
			
			$Obj_data.rowDataArray[$Obj_edge.top-1]:=New object:C1471(\
				"style"; New object:C1471)
			
		End if 
		
		If ($Obj_data.rowDataArray[$Obj_edge.top-1]=Null:C1517)
			
			$Obj_data.rowDataArray[$Obj_edge.top-1]:=New object:C1471(\
				"style"; New object:C1471)
			
		End if 
		
		If ($Obj_data.rowDataArray[$Obj_edge.top-1].style[$Txt_border]=Null:C1517)
			
			$Obj_data.rowDataArray[$Obj_edge.top-1].style[$Txt_border]:=New object:C1471
			
		End if 
		
		If ($Obj_border.color#Null:C1517)
			
			$Obj_data.rowDataArray[$Obj_edge.top-1].style[$Txt_border].color:=$Obj_border.color
			
		End if 
		
		$Obj_data.rowDataArray[$Obj_edge.top-1].style[$Txt_border].style:=$Obj_border.style
		
	Else 
		
		// Apply to the cell
		
		For ($Lon_top; 0; $Obj_border.top.length-1; 1)
			
			// special case if the edge is the last one,
			// it should be a bottomBorder of the last row and not a topBorder of a row after the last.
			
			$tmp_row:=$Obj_border.top[$Lon_top][0]
			
			If ($tmp_row=$Obj_d4.rowCount)
				$Txt_border:="borderBottom"
				$tmp_row:=$tmp_row-1
			Else 
				$Txt_border:="borderTop"
			End if 
			
			$Txt_row:=String:C10($tmp_row)
			$Txt_col:=String:C10($Obj_border.top[$Lon_top][1])
			
			If ($Obj_dataTable[$Txt_row]=Null:C1517)
				
				$Obj_dataTable[$Txt_row]:=New object:C1471
				
			End if 
			
			If ($Obj_dataTable[$Txt_row][$Txt_col]=Null:C1517)
				
				$Obj_dataTable[$Txt_row][$Txt_col]:=New object:C1471
				
			End if 
			
			If ($Obj_dataTable[$Txt_row][$Txt_col].style=Null:C1517)
				
				$Obj_dataTable[$Txt_row][$Txt_col].style:=New object:C1471
				
			End if 
			
			If (Value type:C1509($Obj_dataTable[$Txt_row][$Txt_col].style)=Is object:K8:27)
				
				$Obj_dataTable[$Txt_row][$Txt_col].style[$Txt_border]:=New object:C1471
				
				If ($Obj_border.color#Null:C1517)  // Black is default
					
					$Obj_dataTable[$Txt_row][$Txt_col].style[$Txt_border].color:=$Obj_border.color
					
				End if 
				
				$Obj_dataTable[$Txt_row][$Txt_col].style[$Txt_border].style:=$Obj_border.style
				
			End if 
		End for 
	End if 
End for 

// ================================================================================== ]

// Left lines =============================================================== [
// 4D View make no difference between left and right lines
// We assume all lines are left

$Col_edges:=$Obj_d4.columnEdges

For ($column; 0; $Col_edges.length-1; 1)
	
	$Txt_border:="borderLeft"
	
	$Obj_edge:=$Col_edges[$column]
	
	$Obj_border:=New object:C1471("color"; convert_color(Num:C11($Obj_edge.color); False:C215); \
		"style"; Choose:C955(Num:C11($Obj_edge.style); 1; 1; 2; 2; 5; 5; 5; 6; 6; 6; 6; 6; 6; 1; 1); \
		"left"; New collection:C1472)
	
	For ($Lon_i; $Obj_edge.left; $Obj_edge.right; 1)
		
		For ($Lon_j; $Obj_edge.top; $Obj_edge.bottom; 1)
			
			$Obj_border.left[$Obj_border.left.length]:=New collection:C1472($Lon_j-1; $Lon_i-1)
			
		End for 
	End for 
	
	If ($Obj_border.color="black")
		
		OB REMOVE:C1226($Obj_border; "color")  // Black is default
		
	End if 
	
	If ($Obj_edge.top=1)\
		 & ($Obj_edge.bottom=$Obj_d4.rowCount)
		
		// Apply to the column
		
		// special case if the edge is the last one,
		// it should be a borderRight of the last row and not a borderLeft of a row after the last.
		If ($Obj_edge.right=($Obj_d4.columnCount+1))
			$Txt_border:="borderRight"
			$Obj_edge.left:=$Obj_edge.left-1
		End if 
		
		If ($Obj_data.columnDataArray=Null:C1517)
			
			$Obj_data.columnDataArray:=New collection:C1472
			
		End if 
		
		If ($Obj_data.columnDataArray.length<$Obj_edge.left)
			
			$Obj_data.columnDataArray[$Obj_edge.left-1]:=New object:C1471(\
				"style"; New object:C1471)  //
			
		Else 
			
			If ($Obj_data.columnDataArray[$Obj_edge.left-1]=Null:C1517)
				$Obj_data.columnDataArray[$Obj_edge.left-1]:=New object:C1471()
			End if 
			
			If (Value type:C1509($Obj_data.columnDataArray[$Obj_edge.left-1].style)#Is object:K8:27)
				
				$Obj_data.columnDataArray[$Obj_edge.left-1].style:=New object:C1471(\
					"parentName"; $Obj_data.columnDataArray[$Obj_edge.left-1].style)
				
			End if 
		End if 
		
		If ($Obj_data.columnDataArray[$Obj_edge.left-1].style[$Txt_border]=Null:C1517)
			
			$Obj_data.columnDataArray[$Obj_edge.left-1].style[$Txt_border]:=New object:C1471
			
		End if 
		
		If ($Obj_border.color#Null:C1517)
			
			$Obj_data.columnDataArray[$Obj_edge.left-1].style[$Txt_border].color:=$Obj_border.color
			
		End if 
		
		$Obj_data.columnDataArray[$Obj_edge.left-1].style[$Txt_border].style:=$Obj_border.style
		
	Else 
		
		// Apply to the cell
		
		If ($Obj_border.left.length>0)
			
			$Txt_border:="borderLeft"
			
			For ($Lon_left; 0; $Obj_border.left.length-1; 1)
				
				// special case if the edge is the last one,
				// it should be a bottomBorder of the last row and not a topBorder of a row after the last.
				
				$tmp_col:=$Obj_border.left[$Lon_left][1]
				
				If ($tmp_col=$Obj_d4.columnCount)
					$Txt_border:="borderRight"
					$tmp_col:=$tmp_col-1
				Else 
					$Txt_border:="borderLeft"
				End if 
				
				$Txt_row:=String:C10($Obj_border.left[$Lon_left][0])
				$Txt_col:=String:C10($tmp_col)
				
				If ($Obj_dataTable[$Txt_row]=Null:C1517)
					
					$Obj_dataTable[$Txt_row]:=New object:C1471
					
				End if 
				
				If ($Obj_dataTable[$Txt_row][$Txt_col]=Null:C1517)
					
					$Obj_dataTable[$Txt_row][$Txt_col]:=New object:C1471
					
				End if 
				
				If ($Obj_dataTable[$Txt_row][$Txt_col].style=Null:C1517)
					
					$Obj_dataTable[$Txt_row][$Txt_col].style:=New object:C1471
					
				End if 
				
				If (Value type:C1509($Obj_dataTable[$Txt_row][$Txt_col].style)=Is object:K8:27)
					
					$Obj_dataTable[$Txt_row][$Txt_col].style[$Txt_border]:=New object:C1471
					
					If ($Obj_border.color#Null:C1517)  // Black is default
						
						$Obj_dataTable[$Txt_row][$Txt_col].style[$Txt_border].color:=$Obj_border.color
						
					End if 
					
					$Obj_dataTable[$Txt_row][$Txt_col].style[$Txt_border].style:=$Obj_border.style
					
				End if 
			End for 
		End if 
	End if 
End for 

// ================================================================================== ]

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End