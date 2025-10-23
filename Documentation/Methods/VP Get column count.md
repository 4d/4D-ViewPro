# VP Get column count


**VP Get column count** ( *vpAreaName* : Text { ; *sheet* :  Integer } ) : Integer



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName  |Text|->|4D View Pro area from object name|
|sheet  |Integer|->|Sheet index (current sheet if omitted)|
|Result  |Integer|<-|Total number of columns |

## Description

The `VP Get column count` command returns the total number of columns from the designated *sheet*.

In *vpAreaName*, pass the name property of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

You can define where to get the column count in the optional *sheet* parameter using the sheet index (counting begins at 0). If omitted or if you pass `vk current sheet`, the current spreadsheet is used.

## Example

The following code returns the number of columns in the 4D View Pro area:

```4d
C_INTEGER($colCount)
$colCount:=VP Get column count("ViewProarea")
```

## See also

[VP Get row count](VP%20Get%20row%20count.md)<br/>
[VP SET COLUMN COUNT](VP%20SET%20COLUMN%20COUNT.md)<br/>
[VP SET ROW COUNT](VP%20SET%20ROW%20COUNT.md)