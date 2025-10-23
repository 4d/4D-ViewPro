# VP REMOVE SPAN


**VP REMOVE SPAN** ( *rangeObj* : Object ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj   |Object|->|Range object|

## Description

The `VP REMOVE SPAN` command removes the span from the cells in *rangeObj*.

In *rangeObj*, pass a range object of the cell span. The spanned cells in the range are divided into individual cells.  

## Example

To remove all cell spans from this document:

![](../images/cmd_vpRemoveSpan1.PNG)

```4d
 //find all cell spans
 $span:=VP Get spans(VP All("ViewProArea"))

 
  //remove the cell spans
 VP REMOVE SPAN($span)
```

Result:

![](../images/cmd_vpRemoveSpan2.PNG)

## See also

[VP ADD SPAN](VP%20ADD%20SPAN.md)<br/>
[VP Get spans](VP%20Get%20spans.md)