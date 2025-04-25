# VP ADD SELECTION

<!-- REF #_method_.VP ADD SELECTION.Syntax -->

**VP ADD SELECTION** ( *rangeObj* : Object )<!-- END REF -->

<!-- REF #_method_.VP ADD SELECTION.Params -->

|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj| Object|->|Range object |<!-- END REF -->

## Description

The `VP ADD SELECTION` command <!-- REF #_method_.VP ADD SELECTION.Summary -->adds the specified cells to the currently selected cells<!-- END REF -->.

In *rangeObj*, pass a range object of cells to add to the current selection.

>The active cell is not modified.

## Example  

You have cells currently selected:

![](../images/cmd_vpAddSelection1.PNG)

The following code will add cells to your selection:

```4d
$currentSelection:=VP Cells("myVPArea";3;4;2;3)
VP ADD SELECTION($currentSelection)
```

Result:

![](../images/cmd_vpAddSelection2.PNG)

## See also

[VP Get active cell](VP%20Get%20active%20cell.md)<br/>
[VP Get selection](VP%20Get%20selection.md)<br/>
[VP RESET SELECTION](VP%20RESET%20SELECTION.md)<br/>
[VP SET ACTIVE CELL](VP%20SET%20ACTIVE%20CELL.md)<br/>
[VP SET SELECTION](VP%20SET%20SELECTION.md)<br/>
[VP SHOW CELL](VP%20SHOW%20CELL.md)