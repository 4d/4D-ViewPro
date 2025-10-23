# VP SET SELECTION


**VP SET SELECTION** ( *rangeObj* : Object  ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object of cells|

## Description

The `VP SET SELECTION` command defines the specified cells as the selection and the first cell as the active cell.

In *rangeObj*, pass a range object of cells to designate as the current selection.

## Example

```4d
$currentSelection:=VP Combine ranges(VP Cells("myVPArea";3;2;1;6);VP Cells("myVPArea";5;7;1;7))
VP SET SELECTION($currentSelection)
```

![](../images/cmd_vpSetSelection.PNG)

## See also

[VP Get active cell](VP%20Get%20active%20cell.md)<br/>
[VP Get selection](VP%20Get%20selection.md)<br/>
[VP RESET SELECTION](VP%20RESET%20SELECTION.md)<br/>
[VP SET ACTIVE CELL](VP%20SET%20ACTIVE%20CELL.md)<br/>
[VP ADD SELECTION](vp-add-selection)<br/>
[VP SHOW CELL](VP%20SHOW%20CELL.md)