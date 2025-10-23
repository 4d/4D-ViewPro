# VP SET TEXT VALUE


**VP SET TEXT VALUE** ( *rangeObj* : Object ; *textValue* : Text { ; *formatPattern* : Text }  ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|textValue |Text|->|Text value to set|
|formatPattern |Text|->|Format of value|

## Description

The `VP SET TEXT VALUE` command assigns a specified text value to a designated cell range.

In *rangeObj*, pass a range of the cell(s) (created for example with [`VP Cell`](VP%20Cell.md) or [`VP Column`](VP%20Column.md)) whose value you want to specify. If *rangeObj* includes multiple cells, the value specified will be repeated in each cell.

The *textValue* parameter specifies a text value to be assigned to the *rangeObj*.


The optional *formatPattern* defines a [pattern](../configuring.md#cell-format) for the *textValue* parameter.

## Example

```4d
VP SET TEXT VALUE(VP Cell("ViewProArea";3;2);"Test 4D View Pro")
```

## See also

[Cell Format](../configuring.md#cell-format)<br/>
[VP SET VALUE](VP%20SET%20VALUE.md)