# VP SET ACTIVE CELL


**VP SET ACTIVE CELL** ( *rangeObj* : Object) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj   |Object|->|Range object|

## Description

The `VP SET ACTIVE CELL` command defines a specified cell as active.

In *rangeObj*, pass a range containing a single cell as an object (see [VP Cell](VP%20Cell.md)). If *rangeObj* is not a cell range or contains multiple ranges, the first cell of the first range is used.
  
## Example

To set the cell in column D, row 5 as the active cell:

```4d
$activeCell:=VP Cell("myVPArea";3;4)
VP SET ACTIVE CELL($activeCell)
```

![](../images/cmd_vpSetActiveCell.PNG)

## See also

[VP ADD SELECTION](VP%20ADD%20SELECTION.md)<br/>
[VP Get active cell](VP%20Get%20active%20cell.md)<br/>
[VP Get selection](VP%20Get%20selection.md)<br/>
[VP RESET SELECTION](VP%20RESET%20SELECTION.md)<br/>
[VP SET SELECTION](VP%20SET%20SELECTION.md)<br/>
[VP SHOW CELL](VP%20SHOW%20CELL.md)