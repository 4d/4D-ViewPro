# VP SET NUM VALUE


**VP SET NUM VALUE** ( *rangeObj* : Object ; *numberValue* : Number { ; *formatPattern* : Text } ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|numberValue |Number|->|Number value to set|
|formatPattern |Text|->|Format of value|

## Description

The `VP SET NUM VALUE` command assigns a specified numeric value to a designated cell range.

In *rangeObj*, pass a range of the cell(s) (created for example with [`VP Cell`](VP%20Cell.md) or [`VP Column`](VP%20Column.md)) whose value you want to specify. If *rangeObj* includes multiple cells, the value specified will be repeated in each cell.

The *numberValue* parameter specifies a numeric value to be assigned to the *rangeObj*.

The optional *formatPattern* defines a [pattern](../configuring.md#cell-format) for the *numberValue* parameter.

## Example

```4d
//Set the cell value to 2
VP SET NUM VALUE(VP Cell("ViewProArea";3;2);2)
 
//Set the cell value and format it in dollars
VP SET NUM VALUE(VP Cell("ViewProArea";3;2);12.356;"_($* #,##0.00_)")
```

## See also

[Cell format](../configuring.md#cell-format)<br/>
[VP SET VALUE](VP%20SET%20VALUE.md)