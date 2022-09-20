//%attributes = {"invisible":true}
/*
***FINALLY*** ( Param_1 )
 -> Param_1 (Text)
________________________________________________________
*/
  // ----------------------------------------------------
  // Project method : FINALLY
  // ID[60889CD973B541919706019315ECEAA7]
  // Created #18-5-2017 by Vincent de Lachaux
  // ----------------------------------------------------
C_TEXT:C284($1)

If (False:C215)
	C_TEXT:C284(FINALLY ;$1)
End if 

C_OBJECT:C1216(err)

  // ----------------------------------------------------
If (Count parameters:C259>=1)
	
	ON ERR CALL:C155($1)
	
Else 
	
	If (Is compiled mode:C492)
		
		ON ERR CALL:C155("noError")
		
	Else 
		
		ON ERR CALL:C155("")
		
	End if 
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

  // ----------------------------------------------------