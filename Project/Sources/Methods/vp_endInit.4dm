//%attributes = {"invisible":true}
var $1 : Text
var $2 : Text
var $3 : Boolean
If (False:C215)
	C_TEXT:C284(vp_endInit; $1)  // area name
	C_TEXT:C284(vp_endInit; $2)  // interface
	C_BOOLEAN:C305(vp_endInit; $3)
End if 

If (vp_initStorage)
	
	var $obj : Object
	$obj:=OBJECT Get value:C1743($1)
	
	If ($obj=Null:C1517)
		$obj:=New object:C1471
		OBJECT SET VALUE:C1742($1; $obj)
	End if 
	
	If ($obj.ViewPro=Null:C1517)
		$obj.ViewPro:=New object:C1471
	End if 
	
	$obj.ViewPro.area:=$1
	$obj.ViewPro.inited:=True:C214
	$obj.ViewPro.interface:=$2
	$obj.ViewPro.formulaBar:=$3
	$obj.ViewPro.commandBuffers:=New collection:C1472
	$obj.ViewPro.callbacks:=New object:C1471
	$obj.ViewPro.events:=New object:C1471
	
	$obj.getCurrentSheet:=Formula:C1597(vp_makeSheet(This:C1470.ViewPro.area; VP Get current sheet(This:C1470.ViewPro.area)))
	$obj.setCurrentSheet:=Formula:C1597(VP SET CURRENT SHEET(This:C1470.ViewPro.area; $1))
	
	$obj.getSheet:=Formula:C1597(vp_makeSheet(This:C1470.ViewPro.area; $1))
	$obj.getSheetByName:=Formula:C1597(vp_getSheetByName)
	
End if 
