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
#DECLARE($Obj_in : Object)

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
