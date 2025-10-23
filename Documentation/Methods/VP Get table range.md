# VP Get table range




**VP Get table range** ( *vpAreaName* : Text ; *tableName* : Text {; *onlyData* : Integer {; *sheet* : Integer }} ) : Object



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|tableName|Text|->|Table name|
|onlyData|Integer|->|`vk table full range` (default) or `vk table data range`|
|sheet   |Integer|->|Sheet index (current sheet if omitted)|
|Result  |Object|<-|Range that contains the table|

## Description

The `VP Get table range` command returns the range of *tableName*.

In *vpAreaName*, pass the name of the 4D View Pro area.

In the *onlyData* parameter, you can pass one of the following constants to indicate if you want to get the data only:

|Constant|Value|Description|
|---|---|---|
|`vk table full range`|0|Get the cell range for the table area with footer and header (default if omitted)|
|`vk table data range`|1|Get the cell range for the table data area only|

In *sheet*, pass the index of the target sheet. If no index is specified, the command applies to the current sheet.

>Indexing starts at 0.

If *tableName* is not found, the command returns **null**. 

## See also

[VP RESIZE TABLE](VP%20RESIZE%20TABLE.md)<br/>
[VP Find table](VP%20Find%20table.md)