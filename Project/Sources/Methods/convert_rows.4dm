//%attributes = {"invisible":true}
/*
result := ***convert_rows*** ( d4 )
 -> d4 (Collection)
 <- result (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_rows
// Database: Convert4DView
// ID[468E356A18C34DFD99B01837ABCE059B]
// Created #26-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 11:00:27
// ----------------------------------------------------
// Description:
// Convert 4D View rows properties into SpreadJS rows properties
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_COLLECTION:C1488($1)

C_LONGINT:C283($row)
C_REAL:C285($kNum_sizeConversionFactor)
C_OBJECT:C1216($Obj_dataTable; $Obj_new; $Obj_result)
C_COLLECTION:C1488($Coll_d4; $Coll_rows)

If (False:C215)
	C_OBJECT:C1216(convert_rows; $0)
	C_COLLECTION:C1488(convert_rows; $1)
End if 

// ----------------------------------------------------
// Initialisations

// Required parameters
$Coll_d4:=$1

$kNum_sizeConversionFactor:=0.06666666666667

$Coll_rows:=New collection:C1472

$Obj_dataTable:=New object:C1471

$Obj_result:=New object:C1471(\
"rows"; $Coll_rows; \
"dataTable"; $Obj_dataTable)

// ----------------------------------------------------
For ($row; 1; $Coll_d4.length-1; 1)
	
	$Obj_new:=New object:C1471
	
	If ($Coll_d4[$row]#Null:C1517)
		
		$Obj_new.size:=Choose:C955($Coll_d4[$row].height#Null:C1517; Round:C94($Coll_d4[$row].height*$kNum_sizeConversionFactor; 0); 20)
		
		If ($Coll_d4[$row].visible#Null:C1517)
			
			If ($Coll_d4[$row].visible)
				
				// NOTHING MORE TO DO - Visible is the default value
				
			Else 
				
				$Obj_new.visible:=$Coll_d4[$row].visible
				
			End if 
		End if 
		
		If ($Coll_d4[$row].title#Null:C1517)
			
			$Obj_dataTable[String:C10($row-1)]:=New object:C1471
			$Obj_dataTable[String:C10($row-1)]["0"]:=New object:C1471(\
				"value"; $Coll_d4[$row].title)
			
		End if 
	End if 
	
	$Coll_rows[$row-1]:=$Obj_new
	
End for 

// Remove empty dataTable if any
If (OB Is empty:C1297($Obj_dataTable))
	
	OB REMOVE:C1226($Obj_result; "dataTable")
	
End if 

// ----------------------------------------------------
// Return
$0:=$Obj_result

// ----------------------------------------------------
// End