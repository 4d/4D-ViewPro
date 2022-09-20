//%attributes = {"invisible":true}
/*
result := ***convert_columns*** ( d4 )
 -> d4 (Collection)
 <- result (Object)
________________________________________________________
*/
  // ----------------------------------------------------
  // Project method : convert_columns
  // Database: Convert4DView
  // ID[21F682B249864F908DE5AADECF99BFBB]
  // Created #26-9-2017 by Vincent de Lachaux
  // ----------------------------------------------------
  // User name (OS): wilofice
  // Date and time: 16-08-17, 10:47:53
  // ----------------------------------------------------
  // Description:
  // Convert 4D View columns properties into SpreadJS columns properties
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($0)
C_COLLECTION:C1488($1)

C_LONGINT:C283($column;$nbParameters)
C_REAL:C285($kNum_sizeConversionFactor)
C_OBJECT:C1216($Obj_dataTable;$Obj_new;$Obj_result)
C_COLLECTION:C1488($Coll_columns;$Coll_d4)

If (False:C215)
	C_OBJECT:C1216(convert_columns ;$0)
	C_COLLECTION:C1488(convert_columns ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1;"Missing parameter"))
	
	  // Required parameters
	$Coll_d4:=$1
	
	  // Optional parameters
	If ($nbParameters>=2)
		
		  // <NONE>
		
	End if 
	
	$kNum_sizeConversionFactor:=0.06666666666667
	
	$Coll_columns:=New collection:C1472
	
	$Obj_dataTable:=New object:C1471(\
		"0";New object:C1471)
	
	$Obj_result:=New object:C1471(\
		"columns";$Coll_columns;\
		"dataTable";$Obj_dataTable)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($column;1;$Coll_d4.length-1;1)
	
	If ($Coll_d4[$column]#Null:C1517)
		
		$Obj_new:=New object:C1471
		
		If ($Coll_d4[$column].width#Null:C1517)
			
			$Obj_new.size:=Round:C94($Coll_d4[$column].width*$kNum_sizeConversionFactor;0)
			
		End if 
		
		If ($Coll_d4[$column].visible#Null:C1517)
			
			If ($Coll_d4[$column].visible)
				
				  // NOTHING MORE TO DO - Visible is the default value
				
			Else 
				
				$Obj_new.visible:=$Coll_d4[$column].visible
				
			End if 
		End if 
		
		If ($Coll_d4[$column].title#Null:C1517)
			
			$Obj_dataTable["0"][String:C10($column-1)]:=New object:C1471(\
				"value";$Coll_d4[$column].title)
			
		End if 
		
		$Coll_columns[$column-1]:=$Obj_new
		
	End if 
End for 

  // Remove empty dataTable if any
If (JSON Stringify:C1217($Obj_dataTable)="{\"0\":{}}")
	
	OB REMOVE:C1226($Obj_result;"dataTable")
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Obj_result

  // ----------------------------------------------------
  // End