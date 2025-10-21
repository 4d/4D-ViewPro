//%attributes = {"invisible":true}
#DECLARE($area : Text; $sheet : Integer) : Object

var $out:=New object:C1471("area"; $area; "sheet"; $sheet)
$out.cell:=Formula:C1597(VP Cell(This:C1470.area; $1; $2; This:C1470.sheet))
$out.cells:=Formula:C1597(VP Cells(This:C1470.area; $1; $2; $3; $4; This:C1470.sheet))
$out.column:=Formula:C1597(VP Column(This:C1470.area; $1; Choose:C955(Count parameters:C259>1; $2; 1); This:C1470.sheet))
$out.row:=Formula:C1597(VP Row(This:C1470.area; $1; Choose:C955(Count parameters:C259>1; $2; 1); This:C1470.sheet))
$out.all:=Formula:C1597(VP All(This:C1470.area; This:C1470.sheet))
$out.name:=Formula:C1597(VP Name(This:C1470.area; $1; This:C1470.sheet))
$out.getActiveCell:=Formula:C1597(VP Get active cell(This:C1470.area; This:C1470.sheet))
$out.getSelection:=Formula:C1597(VP Get selection(This:C1470.area; This:C1470.sheet))
$out.setActiveCell:=Formula:C1597(VP SET ACTIVE CELL(VP Cell(This:C1470.area; $1; $2; This:C1470.sheet)))
$out.setSelection:=Formula:C1597(VP SET SELECTION($1))

return $out