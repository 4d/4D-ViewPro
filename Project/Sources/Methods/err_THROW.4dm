//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : THROW
// ID[C0A2A993242342CC9DF5E2C7F733283E]
// Created #18-5-2017 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($error : Object)

If (Asserted:C1132($error#Null:C1517))
	
	$error.component:=$error.component || err_component
	$error.deferred:=True:C214
	
	_4D THROW ERROR:C1520($error)
	
End if 