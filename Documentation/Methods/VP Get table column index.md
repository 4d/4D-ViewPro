# VP Get table column index




**VP Get table column index** ( *vpAreaName* : Text ; *tableName* : Text ; *columnName* : Text {; *sheet* : Integer } ) : Integer



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|tableName|Text|->|Table name|
|columnName|Text|->|Name of the table column|
|sheet   |Integer|->|Sheet index (current sheet if omitted)|
|Result |Integer|<-|Index of *columnName*|


## Description

The `VP Get table column index` command returns the index of the *columnName* in the *tableName*.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *columnName*, pass the name of the table column for which you want to get the index. 

In *sheet*, pass the index of the target sheet. If no index is specified or if you pass -1, the command applies to the current sheet.

>Indexing starts at 0.

If *tableName* or *columnName* is not found, the command returns -1. 

## Example

```4d
	// Search the column id according the column name
var $id : Integer
$id:=VP Get table column index($area; $tableName; "Weight price")
	// Remove the column by id
VP REMOVE TABLE COLUMNS($area; $tableName; $id)
```



## See also

[VP CREATE TABLE](VP%20CREATE%20TABLE.md)<br/>
[VP Find table](VP%20Find%20table.md)<br/>
[VP Get table column attributes](vp%20get%20table%20column%20attributes.md)<br/>
[VP SET TABLE COLUMN ATTRIBUTES](VP%20SET%20TABLE%20COLUMN%20ATTRIBUTES.md)