# VP Get sheet count


**VP Get sheet count** ( *vpAreaName* : Text ) : Integer



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName| Text|->|4D View Pro area form object name|
|Function result|Integer|<-|Number of sheets|

## Description

The `VP Get sheet count` command returns the number of sheets in the document loaded in *vpAreaName*.

In *vpAreaName*, pass the name of the 4D View Pro area.

## Example

In the following document:

![](../images/vp-sheet-3.png)

Get the sheet count and set the current sheet to the last sheet:

```4d
 $count:=VP Get sheet count("ViewProArea")
  //set the current sheet to the last sheet (indexing starts at 0)
 VP SET CURRENT SHEET("ViewProArea";$count-1)
```

![](../images/vp-sheet-3-select.png)

## See also

[VP Get sheet index](VP%20Get%20sheet%20index.md)<br/>
[VP SET SHEET COUNT](VP%20SET%20SHEET%20COUNT.md)