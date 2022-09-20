//%attributes = {"invisible":true}
C_OBJECT:C1216($0)
C_TEXT:C284($1)

C_OBJECT:C1216($obj)
$obj:=OBJECT Get value:C1743($1)

If ($obj.ViewPro#Null:C1517)
	$0:=$obj.ViewPro.formulas
Else 
	$0:=Null:C1517
End if 