//%attributes = {"invisible":true}

If (Feature.with("OBJECT_API"))
	
	C_OBJECT:C1216($1)
	$1.setValue:=Formula:C1597(vp_setValue(This:C1470; $1; $2))
	$1.setNumValue:=Formula:C1597(VP SET NUM VALUE(This:C1470; $1; $2))
	$1.setTextValue:=Formula:C1597(VP SET TEXT VALUE(This:C1470; $1; $2))
	$1.setDateValue:=Formula:C1597(VP SET DATE VALUE(This:C1470; $1; $2))
	$1.setDateTimeValue:=Formula:C1597(VP SET DATE TIME VALUE(This:C1470; $1; $2; $3))
	$1.setTimeValue:=Formula:C1597(VP SET TIME VALUE(This:C1470; $1; $2))
	
	$1.getValue:=Formula:C1597(VP Get value(This:C1470))
	
	$1.setStyle:=Formula:C1597(VP SET CELL STYLE(This:C1470; $1))
	
	$1.setBackColor:=Formula:C1597(VP SET CELL STYLE(This:C1470; New object:C1471("backColor"; $1)))
	$1.getBackColor:=Formula:C1597(VP Get cell style(This:C1470).backColor)
	
End if 
