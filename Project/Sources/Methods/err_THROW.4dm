//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : THROW
// ID[C0A2A993242342CC9DF5E2C7F733283E]
// Created #18-5-2017 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($error : Object)

If (False:C215)
	C_OBJECT:C1216(err_THROW; $1)
End if 

If (Asserted:C1132($error#Null:C1517))
	
	If ($error.component=Null:C1517)
		
		$error.component:=err_component
		
	End if 
	
	$error.deferred:=True:C214  // (Structure file#Structure file(*))
	
	_4D THROW ERROR:C1520($error)
	
End if 