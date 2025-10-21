//%attributes = {"invisible":true}
#DECLARE($area : Text; $interface : Text; $formulaBar : Boolean)

If (vp_initStorage)
	
	var $obj:=OBJECT Get value:C1743($area)
	
	If ($obj=Null:C1517)
		$obj:=New object:C1471
		OBJECT SET VALUE:C1742($area; $obj)
	End if 
	
	If ($obj.ViewPro=Null:C1517)
		$obj.ViewPro:=New object:C1471
	End if 
	
	$obj.ViewPro.area:=$area
	$obj.ViewPro.inited:=True:C214
	$obj.ViewPro.interface:=$interface
	$obj.ViewPro.formulaBar:=$formulaBar
	$obj.ViewPro.commandBuffers:=New collection:C1472
	$obj.ViewPro.callbacks:=New object:C1471
	$obj.ViewPro.events:=New object:C1471
	
	$obj.getCurrentSheet:=Formula:C1597(vp_makeSheet(This:C1470.ViewPro.area; VP Get current sheet(This:C1470.ViewPro.area)))
	$obj.setCurrentSheet:=Formula:C1597(VP SET CURRENT SHEET(This:C1470.ViewPro.area; $area))
	
	$obj.getSheet:=Formula:C1597(vp_makeSheet(This:C1470.ViewPro.area; $area))
	$obj.getSheetByName:=Formula:C1597(vp_getSheetByName)
	
End if 
