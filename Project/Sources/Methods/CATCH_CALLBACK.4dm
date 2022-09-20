//%attributes = {"invisible":true}
ARRAY LONGINT:C221($codeArray;0)
ARRAY TEXT:C222($intCompArray;0)
ARRAY TEXT:C222($txtArray;0)
C_LONGINT:C283($i)

GET LAST ERROR STACK:C1015($codeArray;$intCompArray;$txtArray)

If (Not:C34(OB Is defined:C1231(errCB_err;"errors")))
	errCB_err.errors:=New collection:C1472()
End if 

For ($i;1;Size of array:C274($codeArray))
	errCB_err.errors.push(New object:C1471("code";$codeArray{$i};"message";$txtArray{$i}))
End for 