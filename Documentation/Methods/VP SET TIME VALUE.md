# VP SET TIME VALUE


**VP SET TIME VALUE** ( *rangeObj* : Object ; *timeValue* : Text { ; *formatPattern* : Text }  ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|timeValue |Time|->|Time value to set|
|formatPattern |Text|->|Format of value|

## Description

The `VP SET TIME VALUE` command assigns a specified time value to a designated cell range.

In *rangeObj*, pass a range of the cell(s) (created for example with [`VP Cell`](VP%20Cell.md) or [`VP Column`](VP%20Column.md)) whose value you want to specify. If *rangeObj* includes multiple cells, the value specified will be repeated in each cell.

The *timeValue* parameter specifies a time expressed in seconds to be assigned to the *rangeObj*.

The optional *formatPattern* defines a [pattern](../configuring.md#cell-format) for the *timeValue* parameter.


## Example

```4d
//Set the value to the current time
VP SET TIME VALUE(VP Cell("ViewProArea";5;2);Current time)
 
//Set the value to a specific time with a designated format
VP SET TIME VALUE(VP Cell("ViewProArea";5;2);?12:15:06?;vk pattern long time)
```

## See also

[Cell Format](../configuring.md#cell-format)<br/>
[VP SET DATE TIME VALUE](VP%20SET%20DATE%20TIME%20VALUE.md)<br/>
[VP SET VALUE](VP%20SET%20VALUE.md)