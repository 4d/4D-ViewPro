# VP SET DATE VALUE


**VP SET DATE VALUE** ( *rangeObj* : Object ; *dateValue* : Date { ; *formatPattern* : Text } ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|dateValue |Date|->|Date value to set|
|formatPattern |Text|->|Format of value|

## Description

The `VP SET DATE VALUE` command assigns a specified date value to a designated cell range.

In *rangeObj*, pass a range of the cell(s) whose value you want to specify. If *rangeObj* includes multiple cells, the value specified will be repeated in each cell.

The *dateValue* parameter specifies a date value to be assigned to the *rangeObj*.

The optional *formatPattern* defines a pattern for the *dateValue* parameter. Pass any custom format or you can use one of the following constants:

|Constant|Description|Default US pattern|
|---|---|---|
|`vk pattern long date`|ISO 8601 format for the full date|"dddd, dd MMMM yyyy"|
|`vk pattern month day`|ISO 8601 format for the month and day|"MMMM dd"|
|`vk pattern short date`|Abbreviated ISO 8601 format for the date|"MM/dd/yyyy"|
|`vk pattern year month`|ISO 8601 format for the month and year|"yyyy MMMM"|

For information on patterns and formatting characters, please refer to the [Date and time formats](../configuring.md#date-and-time-formats) section.

## Example

```4d
//Set the cell value to the current date
VP SET DATE VALUE(VP Cell("ViewProArea";4;2);Current date))
 
//Set the cell value to a specific date with a designated format
VP SET DATE VALUE(VP Cell("ViewProArea";4;4);Date("12/25/94");"d/m/yy ")
VP SET DATE VALUE(VP Cell("ViewProArea";4;6);!2005-01-15!;vk pattern month day)
```

## See also

[4D View Pro cell format](../configuring.md#cell-format)<br/>
[VP SET DATE TIME VALUE](VP%20SET%20DATE%20TIME%20VALUE.md)<br/>
[VP SET VALUE](VP%20SET%20VALUE.md)