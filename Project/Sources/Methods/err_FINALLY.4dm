//%attributes = {"invisible":true}
// Project method : FINALLY
// ID[60889CD973B541919706019315ECEAA7]
// Created #18-5-2017 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($method : Text)

If (False:C215)
	C_TEXT:C284(err_FINALLY; $1)
End if 

var err : Object

If (Count parameters:C259>=1)
	
	ON ERR CALL:C155($method)
	
Else 
	
	ON ERR CALL:C155(Is compiled mode:C492 ? "noError" : "")
	
End if 

If (Num:C11(err.count)>0)
	
	// If(OB Is defined(err;"component"))
	//$Txt_component:=err.component
	// Else
	//  // Keep default
	//$Txt_component:=err_component
	// End if
	// If(True)
	//  // If(OB Is defined(err;"description"))
	//  //THROW ERROR($Txt_component;err.code;err.description)
	//  // Else
	//  //THROW ERROR($Txt_component;err.code;err)
	//  // End if
	// Else
	// If(OB Is defined(err;"description"))
	//THROW ERROR(OB New("component";$Txt_component;"code";err.code;"description";err.description))
	// Else
	//THROW ERROR(OB New("component";$Txt_component;"code";err.code))
	// End if
	// End if
	
End if 