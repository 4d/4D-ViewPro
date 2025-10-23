# VP COLUMN AUTOFIT


**VP COLUMN AUTOFIT** ( *rangeObj* : Object )



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj| Object|->|Range object|

## Description

The `VP COLUMN AUTOFIT` command automatically sizes the column(s) in *rangeObj* according to their contents.

In *rangeObj*, pass a range object containing a range of the columns whose size will be automatically handled.

## Example  

The following columns are all the same size and don't display some of the text:

![](../images/cmd_vpColumnAutoFit1.PNG)

Selecting the columns and running this code:

```4d
 VP COLUMN AUTOFIT(VP Get selection("ViewProarea"))
```

... resizes the columns to fit the size of the contents:

![](../images/cmd_vpColumnAutoFit2.PNG)

## See also

[VP ROW AUTOFIT](VP%20ROW%20AUTOFIT.md)