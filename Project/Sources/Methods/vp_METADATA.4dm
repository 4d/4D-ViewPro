//%attributes = {"invisible":true}
/*
***vp_METADATA*** ( document )
-> document (Object)
________________________________________________________
*/
#DECLARE($documentObject : Object)

// ----------------------------------------------------
// Initialisations
var $nbParameters:=Count parameters:C259

err_TRY

If (Check_parameters_count(1; $nbParameters))
	
	// ----------------------------------------------------
	
	//update version
	$documentObject.version:=Storage:C1525.ViewPro.version
	
	//update dates {
	var $date:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
	
	If ($documentObject.dateCreation=Null:C1517)
		
		$documentObject.dateCreation:=$date
		
	End if 
	
	$documentObject.dateModified:=$date
	
End if 

err_FINALLY
