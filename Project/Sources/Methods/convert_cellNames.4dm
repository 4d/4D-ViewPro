//%attributes = {"invisible":true}
/*
celNames := ***convert_cellNames*** ( d4 )
» d4 (Object)
<- celNames (Collection)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_cellNames
// Database: Convert4DView
// ID[2BFDF21EE4C04CCE889D229D4A55A9C4]
// Created #26-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Definition:
//    "NameInfo": {
//      "title": "NameInfo",
//      "description": "Represents a custom named expression that can be used by formulas.",
//      "type": "object",
//      "properties": {
//        "name": {
//          "type": "string"
//        },
//        "row": {
//          "type": "integer",
//          "minimum": 0
//        },
//        "col": {
//          "type": "integer",
//          "minimum": 0
//        },
//        "formula": {
//          "type": "string"
//        }
//      }
//    },
// ----------------------------------------------------
// Declarations
#DECLARE($Obj_d4 : Object) : Collection
var $Lon_i : Integer
var $Col_celNames : Collection

// ----------------------------------------------------
// Initialisations

$Col_celNames:=New collection:C1472

// ----------------------------------------------------
For ($Lon_i; 0; $Obj_d4.cellNames.length-1; 1)
	
	//push
	$Col_celNames[$Col_celNames.length]:=New object:C1471(\
		"name"; $Obj_d4.cellNames[$Lon_i].name; \
		"row"; Choose:C955($Obj_d4.cellNames[$Lon_i].row>0; $Obj_d4.cellNames[$Lon_i].row-1; 0); \
		"col"; Choose:C955($Obj_d4.cellNames[$Lon_i].column>0; $Obj_d4.cellNames[$Lon_i].column-1; 0); \
		"formula"; $Obj_d4._default.sheetName+"!$"+convert_indexToLetters($Obj_d4.cellNames[$Lon_i].column)+"$"+String:C10($Obj_d4.cellNames[$Lon_i].row))
	
End for 

// ----------------------------------------------------
// Return
$0:=$Col_celNames

// ----------------------------------------------------
// End