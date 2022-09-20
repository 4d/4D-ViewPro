//%attributes = {"invisible":true}
C_LONGINT:C283($1)
C_TEXT:C284($2)

If (False:C215)
	C_LONGINT:C283(THROW_CALLBACK ;$1)
	C_TEXT:C284(THROW_CALLBACK ;$2)
End if 

errCB_err.errorCode:=$1
errCB_err.errorMessage:=$2
