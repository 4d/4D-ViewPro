# VP SET VALUE


**VP SET VALUE** ( *rangeObj* : Object ; *valueObj* : Object ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|valueObj  |Object|->|Cell values and format options|

## Description

The `VP SET VALUE` command assigns a specified value to a designated cell range.

The command allows you to use a generic code to set and format the types of values in *rangeObj*, whereas other commands, such as [`VP SET TEXT VALUE`](VP%20SET%20TEXT%20VALUE.md) and [`VP SET NUM VALUE`](VP%20SET%20NUM%20VALUE.md), reduce the values to specific types.

In *rangeObj*, pass a range of the cell(s) (created for example with [`VP Cell`](vp-cell) or [`VP Column`](VP%20Column.md)) whose value you want to specify. If *rangeObj* includes multiple cells, the value specified will be repeated in each cell.

The parameter *valueObj* is an object that includes properties for the value and the [format](../configuring.md#cell-format) to assign to *rangeObj*. It can include the following properties :

|Property| Type |Description|
|---|---|---|
|value| Integer, Real, Boolean, Text, Date, Null| Value to assign to *rangeObj* (except- time). Pass null to erase the content of the cell.|
|time |Real |Time value (in seconds) to assign to *rangeObj*|
|format |Text| Pattern for value/time property. For information on patterns and formatting characters, please refer to the [Cell Format](../configuring.md#cell-format) paragraph.

## Example

```4d
//Set the cell value as False
VP SET VALUE(VP Cell("ViewProArea";3;2);New object("value";False))
 
//Set the cell value as 2
VP SET VALUE(VP Cell("ViewProArea";3;2);New object("value";2))
 
//Set the cell value as $125,571.35
VP SET VALUE(VP Cell("ViewProArea";3;2);New object("value";125571.35;"format";"_($* #,##0.00_)"))
 
//Set the cell value as Hello World!
VP SET VALUE(VP Cell("ViewProArea";3;2);New object("value";"Hello World!"))
 
//Set the cell value as current date
VP SET VALUE(VP Cell("ViewProArea";4;2);New object("value";Current date))
 
//Set the cell value as current hour
VP SET VALUE(VP Cell("ViewProArea";5;2);New object("time";Current hour))
 
//Set the cell value as specific date and time
VP SET VALUE(VP Cell("ViewProArea";3;9);New object("value";!2024-12-18!);"time";?14:30:10?;"format";vk pattern full date time))
 
//Erase cell content
VP SET VALUE(VP Cell("ViewProArea";3;9);New object("value";Null))
```

## See also

[Cell Format](../configuring.md#cell-format)<br/>
[VP Get values](VP%20Get%20value.md)<br/>
[VP SET VALUE](VP%20SET%20VALUE.md)<br/>
[VP SET BOOLEAN VALUE](VP%20SET%20BOOLEAN%20VALUE.md)<br/>
[VP SET DATE TIME VALUE](VP%20SET%20DATE%20TIME%20VALUE.md)<br/>
[VP SET FIELD](VP%20SET%20FIELD.md)<br/>
[VP SET FORMULA](VP%20SET%20FORMULA.md)<br/>
[VP SET NUM VALUE](VP%20SET%20NUM%20VALUE.md)<br/>
[VP SET TEXT VALUE](VP%20SET%20TEXT%20VALUE.md)<br/>
[VP SET TIME VALUE](VP%20SET%20TIME%20VALUE.md)