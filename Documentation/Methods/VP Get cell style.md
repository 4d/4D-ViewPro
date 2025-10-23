# VP Get cell style


**VP Get cell style** (  *rangeObj* : Object ) : Object



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj  |Object|->|Range object|
|Result  |Object|<-|Style object|

## Description

The `VP Get cell style` command returns a [style object](../configuring.md#style-objects) for the first cell in the *rangeObj*.

In *rangeObj*, pass a range containing the style to retrieve.

* If *rangeObj* contains a cell range, the cell style is returned.
* If *rangeObj* contains a range that is not a cell range, the style of the first cell in the range is returned.
* If *rangeObj* contains several ranges, only the style of the first cell in the first range is returned.

## Example

To get the details about the style in the selected cell (B2):

![](../images/cmd_vpGetCellStyle.PNG)

This code:

```4d
$cellStyle:=VP Get cell style(VP Get selection("myDoc"))
```

... will return this object:

```4d
{
  "backColor":"Azure",
  "borderBottom":
   {
     "color":#800080,
     "style":5
   }
  "font":"8pt Arial",
  "foreColor":"red",
  "hAlign":1,
  "isVerticalText":"true",
  "vAlign":0
}
```

## See also

[VP GET DEFAULT STYLE](VP%20Get%20default%20style.md)<br/>
[VP SET CELL STYLE](VP%20SET%20CELL%20STYLE.md)