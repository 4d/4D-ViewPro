# VP ROW AUTOFIT


**VP ROW AUTOFIT** ( *rangeObj* : Object) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj  |Object|->|Range object|

## Description

The `VP ROW AUTOFIT` command automatically sizes the row(s) in *rangeObj* according to their contents.

In *rangeObj*, pass a range object containing a range of the rows whose size will be automatically handled.
  
## Example

The following rows don't correctly display the text:

![](../images/cmd_vpRowAutoFit1.PNG)

```4d
 VP ROW AUTOFIT(VP Row("ViewProArea";1;2))
```

Result:

![](../images/cmd_vpRowAutoFit2.PNG)

## See also

[VP Column autofit](VP%20COLUMN%20AUTOFIT.md)