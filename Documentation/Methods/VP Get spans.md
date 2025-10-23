# VP Get spans


**VP Get spans** ( *rangeObj* : Object ) : Object



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj  |Object|->|Range object|
|Result  |Object|<-|Object of cell spans in the defined range|

## Description

The `VP Get spans` command retrieves the cell spans in the designated *rangeObj*.

In *rangeObj*, pass a range of cell spans you want to retrieve. If *rangeObj* does not contain a cell span, an empty range is returned.

## Example

You want to center the text for the spanned cells in this document:

![](../images/cmd_vpGetSpans.PNG)

```4d
// Search for all cell spans 
$range:=VP Get spans(VP All("ViewProArea"))
 
//center text
$style:=New object("vAlign";vk vertical align center;"hAlign";vk horizontal align center)
VP SET CELL STYLE($range;$style)
```

## See also

[VP ADD SPAN](VP%20ADD%20SPAN.md)<br/>
[VP REMOVE SPAN](VP%20REMOVE%20SPAN.md)