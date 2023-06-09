//%attributes = {"invisible":true}
#DECLARE() : Boolean

If (False:C215)
	C_BOOLEAN:C305(err_continue; $0)
End if 

return (Num:C11(err.count)=0)