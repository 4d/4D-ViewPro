//%attributes = {"invisible":true}
#DECLARE($param1 : Text; $param2 : Text; $param3 : Boolean)

If (vp_initStorage)
	
	var $obj : Object
	$obj:=OBJECT Get value:C1743($param1)
	
	If ($obj=Null:C1517)
		$obj:=New object:C1471
		OBJECT SET VALUE:C1742($param1; $obj)
	End if 
	
	If ($obj.ViewPro=Null:C1517)
		$obj.ViewPro:=New object:C1471
	End if 
	
	$obj.ViewPro.area:=$param1
	$obj.ViewPro.inited:=True:C214
	$obj.ViewPro.interface:=$param2
	$obj.ViewPro.formulaBar:=$param3
	$obj.ViewPro.commandBuffers:=New collection:C1472
	$obj.ViewPro.callbacks:=New object:C1471
	$obj.ViewPro.events:=New object:C1471
	
	$obj.getCurrentSheet:=Formula:C1597(vp_makeSheet(This:C1470.ViewPro.area; VP Get current sheet(This:C1470.ViewPro.area)))
	$obj.setCurrentSheet:=Formula:C1597(VP SET CURRENT SHEET(This:C1470.ViewPro.area; $param1))
	
	$obj.getSheet:=Formula:C1597(vp_makeSheet(This:C1470.ViewPro.area; $param1))
	$obj.getSheetByName:=Formula:C1597(vp_getSheetByName)
	
End if 
