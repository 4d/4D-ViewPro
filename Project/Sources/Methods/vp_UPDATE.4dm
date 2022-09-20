//%attributes = {"invisible":true}
/*
***vp_UPDATE*** ( in )
 -> in (Object) -  4DVP object
________________________________________________________
*/
// ----------------------------------------------------
// Project method : vpVersionUpdate
// Database: 4D ViewPro
// ID[DBEA2EC242DA472DAD22D7CDA0BEBDD3]
// Created #3-4-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Update according ViewPro version
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($1)

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($Obj_in)

If (False:C215)
	C_OBJECT:C1216(vp_UPDATE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Obj_in:=$1  // 4DVP object
	
	// Optional parameters
	If ($nbParameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Storage:C1525.ViewPro.available)
	
	Case of 
			
			//______________________________________________________
		: ($Obj_in.version=Null:C1517)
			
			//______________________________________________________
		: ($Obj_in.version=Storage:C1525.ViewPro.version)  // Current version
			
			// NOTHING MORE TO DO
			
			//______________________________________________________
		Else 
			
			// UPDATE ?
			
			//______________________________________________________
	End case 
	
	vp_UPDATE_SJS($Obj_in.spreadJS)
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End