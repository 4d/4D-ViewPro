# VP SET BOOLEAN VALUE


**VP SET BOOLEAN VALUE** ( *rangeObj* : Object  ; *boolValue* : Boolean) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj   |Object|->|Range object|
|boolValue    |Boolean|->|Boolean value to set|

## Description

The `VP SET BOOLEAN VALUE` command assigns a specified boolean value to a designated cell range.

In *rangeObj*, pass a range of the cell(s) (created for example with [`VP Cell`](VP%20Cell.md) or [`VP Column`](VP%20Column.md)) whose value you want to specify. If *rangeObj* includes multiple cells, the value specified will be repeated in each cell.


The *boolValue* parameter allows you to pass the boolean value (**True** or **False**) that will be assigned to the *rangeObj*.
  
## Example

```4d
//Set the cell value as False
VP SET BOOLEAN VALUE(VP Cell("ViewProArea";3;2);False)
```

## See also

[VP SET VALUE](VP%20SET%20VALUE.md)