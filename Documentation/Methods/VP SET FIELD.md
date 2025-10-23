# VP SET FIELD


**VP SET FIELD** ( *rangeObj* : Object ; *field* : Pointer { ; *formatPattern* : Text } ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|field |Pointer|->|Reference to field in virtual structure|
|formatPattern |Text|->|Format of field|

## Description

The `VP SET FIELD` command assigns a 4D database virtual field to a designated cell range.

In *rangeObj*, pass a range of the cell(s) whose value you want to specify. If *rangeObj* includes multiple cells, the specified field will be linked in each cell.

The *field* parameter specifies a 4D database [virtual field](../formulas.md#referencing-fields-using-the-virtual-structure) to be assigned to the *rangeObj*. The virtual structure name for *field* can be viewed in the formula bar. If any of the cells in *rangeObj* have existing content, it will be replaced by *field*.

The optional *formatPattern* defines a pattern for the *field* parameter. You can pass any valid [custom format](../configuring.md#cell-format).

## Example

```4d
VP SET FIELD(VP Cell("ViewProArea";5;2);->[TableName]Field)
```

## See also

[VP SET VALUE](VP%20SET%20VALUE.md)