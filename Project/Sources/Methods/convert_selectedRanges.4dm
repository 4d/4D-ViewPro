//%attributes = {"invisible":true}
/*
selection := ***convert_selectedRanges*** ( d4 )
 -> d4 (Object)
 <- selection (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_selectedRanges
// Database: Convert4DView
// ID[260D79225804411F95756D9D4D93E4A0]
// Created #26-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 11:00:49
// ----------------------------------------------------
// Definition:
//    "SelectionModel": {
//      "title": "SelectionModel",
//      "description": "Represent a data model for cell selection.",
//      "type": "object",
//      "properties": {
//        "selectionPolicy": {
//          "$ref": "#/definitions/SelectionPolicy",
//          "default": 2
//        },
//        "selectionUnit": {
//          "$ref": "#/definitions/SelectionUnit",
//          "default": 0
//        },
//        "activeSelectedRangeIndex": {
//          "type": "integer"
//        },
//        "length": {
//          "type": "integer",
//          "minimum": 0
//        }
//      },
//      "patternProperties": {
//        "[0-9]+": {
//          "$ref": "#/definitions/Range"
//        }
//      }
//    },
//    "SelectionPolicy": {
//      "title": "SelectionPolicy",
//      "description": "Specifies how users can select items in the control. single:0, range:1, multiRange:2.",
//      "enum": [
//        0,
//        1,
//        2
//      ]
//    },
//    "SelectionUnit": {
//      "title": "SelectionUnit",
//      "description": "Specifies the smallest unit users or the application can select. cell:0, row:1, column:2.",
//      "enum": [
//        0,
//        1,
//        2
//      ]
//    },
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_LONGINT:C283($Lon_i; $nbParameters)
C_OBJECT:C1216($Obj_d4; $Obj_selection)

If (False:C215)
	C_OBJECT:C1216(convert_selectedRanges; $0)
	C_OBJECT:C1216(convert_selectedRanges; $1)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Obj_d4:=$1
	
	// Optional parameters
	If ($nbParameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Obj_selection:=New object:C1471(\
"SelectionPolicy"; 2; \
"length"; $Obj_d4.selectedRanges.length)

For ($Lon_i; 0; $Obj_d4.selectedRanges.length-1; 1)
	
	$Obj_selection[String:C10($Lon_i)]:=New object:C1471(\
		"row"; $Obj_d4.selectedRanges[$Lon_i].top-1; \
		"rowCount"; $Obj_d4.selectedRanges[$Lon_i].bottom-$Obj_d4.selectedRanges[$Lon_i].top+1; \
		"col"; $Obj_d4.selectedRanges[$Lon_i].left-1; \
		"colCount"; $Obj_d4.selectedRanges[$Lon_i].right-$Obj_d4.selectedRanges[$Lon_i].left+1)
	
	If ($Obj_selection[String:C10($Lon_i)].row>=$Obj_d4.rowCount)
		$Obj_selection[String:C10($Lon_i)].row:=$Obj_d4.rowCount-1
		$Obj_selection[String:C10($Lon_i)].rowCount:=1
	Else 
		If (($Obj_selection[String:C10($Lon_i)].row+$Obj_selection[String:C10($Lon_i)].rowCount)>=$Obj_d4.rowCount)
			$Obj_selection[String:C10($Lon_i)].rowCount:=$Obj_d4.rowCount-$Obj_selection[String:C10($Lon_i)].row
		End if 
	End if 
	
	If ($Obj_selection[String:C10($Lon_i)].col>=$Obj_d4.columnCount)
		$Obj_selection[String:C10($Lon_i)].col:=$Obj_d4.columnCount-1
		$Obj_selection[String:C10($Lon_i)].colCount:=1
	Else 
		If (($Obj_selection[String:C10($Lon_i)].col+$Obj_selection[String:C10($Lon_i)].colCount)>=$Obj_d4.columnCount)
			$Obj_selection[String:C10($Lon_i)].colCount:=$Obj_d4.columnCount-$Obj_selection[String:C10($Lon_i)].col
		End if 
	End if 
	
	If ($Obj_d4.currentCellRow>=$Obj_d4.selectedRanges[$Lon_i].top)\
		 & ($Obj_d4.currentCellRow<=$Obj_d4.selectedRanges[$Lon_i].bottom)\
		 & ($Obj_d4.currentCellColumn>=$Obj_d4.selectedRanges[$Lon_i].left)\
		 & ($Obj_d4.currentCellColumn<=$Obj_d4.selectedRanges[$Lon_i].right)
		
		// Set as the active range
		$Obj_selection.activeSelectedRangeIndex:=$Lon_i
		
	End if 
End for 

// ----------------------------------------------------
// Return
$0:=$Obj_selection

// ----------------------------------------------------
// End