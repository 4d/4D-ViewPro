# VP SET DATE TIME VALUE

<!-- REF #_method_.VP SET DATE TIME VALUE.Syntax -->
**VP SET DATE TIME VALUE** ( *rangeObj* : Object ; *dateValue* : Date ; *timeValue* : Time {; *formatPattern* : Text } ) <!-- END REF -->

<!-- REF #_method_.VP SET DATE TIME VALUE.Params -->


|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|dateValue |Date|->|Date value to set|
|timeValue |Time|->|Time value to set|
|formatPattern |Text|->|Format of value|<!-- END REF -->

## Description

The `VP SET DATE TIME VALUE` command <!-- REF #_method_.VP SET DATE TIME VALUE.Summary -->assigns a specified date and time value to a designated cell range<!-- END REF -->.

In *rangeObj*, pass a range of the cell(s) (created for example with [`VP Cell`](VP%20Cell.md) or [`VP Column`](VP%20Column.md)) whose value you want to specify. If *rangeObj* includes multiple cells, the value specified will be repeated in each cell.

The *dateValue* parameter specifies a date value to be assigned to the *rangeObj*.

The *timeValue* parameter specifies a time value (expressed in seconds) to be assigned to the *rangeObj*.

The optional *formatPattern* defines a pattern for the *dateValue* and *timeValue* parameters. For information on patterns and formatting characters, please refer to the [Date and time formats](../configuring.md#date-and-time-formats) section.

## Example

```4d
//Set the cell value as the current date and time
VP SET DATE TIME VALUE(VP Cell("ViewProArea";6;2);Current time;Current date;vk pattern full date time)
 
//Set the cell value as the 18th of December
VP SET DATE TIME VALUE(VP Cell("ViewProArea";3;9);!2024-12-18!;?14:30:10?;vk pattern sortable date time)
```

## See also

[4D View Pro cell format](../configuring.md#cell-format)<br/>
[VP SET DATE VALUE](VP%20SET%20DATE%20VALUE.md)<br/>
[VP SET TIME VALUE](VP%20SET%20TIME%20VALUE.md)<br/>
[VP SET VALUE](VP%20SET%20VALUE.md)