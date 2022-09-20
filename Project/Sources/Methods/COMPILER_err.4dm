//%attributes = {"invisible":true}
C_TEXT:C284(err_component)

C_OBJECT:C1216(err)

If (False:C215)
	
	//___________________________________
	C_OBJECT:C1216(CATCH; $1)
	
	//___________________________________
	C_BOOLEAN:C305(Check_parameters_count; $0)
	C_LONGINT:C283(Check_parameters_count; $1)
	C_LONGINT:C283(Check_parameters_count; $2)
	
	//___________________________________
	C_BOOLEAN:C305(vp_continue; $0)
	
	//___________________________________
	C_TEXT:C284(FINALLY; $1)
	
	//___________________________________
	C_OBJECT:C1216(THROW; $1)
	
End if 