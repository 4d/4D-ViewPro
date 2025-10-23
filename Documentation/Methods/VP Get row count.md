# VP Get row count


**VP Get row count** ( *vpAreaName* : Text {; *sheet* : Integer } ) : Integer



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName  |Text|->|4D View Pro area from object name|
|sheet  |Integer|->|Sheet index (current sheet if omitted)|
|Result  |Integer|<-|Total number of rows|

## Description

The `VP Get row count` command returns the total number of rows from the designated *sheet*.

In *vpAreaName*, pass the name property of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

You can define where to get the row count in the optional *sheet* parameter using the sheet index (counting begins at 0). If omitted or if you pass `vk current sheet`, the current spreadsheet is used.

## Example

The following code returns the number of rows in the 4D View Pro area:

```4d
var $rowCount : Integer
$rowCount:=VP Get row count("ViewProarea")
```

## See also

[VP Get column count](VP%20Get%20column%20count.md)<br/>
[VP SET COLUMN COUNT](VP%20SET%20COLUMN%20COUNT.md)<br/>
[VP SET ROW COUNT](VP%20SET%20ROW%20COUNT.md)