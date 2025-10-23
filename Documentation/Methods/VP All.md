# VP All


**VP All** ( *vpAreaName* : Text { ; *sheet* : Integer } )  : Object



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName| Text|->|4D View Pro area form object name|
|sheet|Integer|->|Sheet index (current sheet if omitted)|
|Result|Object|<-|Range object of all cells|

## Description

The `VP ALL` command returns a new range object referencing all cells.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

In the optional *sheet* parameter, you can designate a specific spreadsheet where the range will be defined (counting begins at 0). If omitted or if you pass `vk current sheet`, the current spreadsheet is used.

## Example  

You want to define a range object for all of the cells of the current spreadsheet:

```4d
$all:=VP All("ViewProArea") // all cells of the current sheet
```

## See also

[VP Cell](vp-cell)<br/>
[VP Cells](vp-cells)<br/>
[VP Column](VP%20Column.md)<br/>
[VP Combine ranges](VP%20Combine%20ranges.md)<br/>
[VP Name](VP%20Name.md)<br/>
[VP Row](VP%20Row.md)