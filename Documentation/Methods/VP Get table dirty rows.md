# VP Get table dirty rows



<!-- REF #_method_.VP Get table dirty rows.Syntax -->
**VP Get table dirty rows** ( *vpAreaName* : Text ; *tableName* : Text { ; *reset* : Boolean {; *sheet* : Integer }} ) : Collection<!-- END REF -->

<!-- REF #_method_.VP Get table dirty rows.Params -->

|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|tableName|Text|->|Table name|
|reset|Boolean|->|True to clear the dirty status from the current table, False to keep it untouched. Default=True|
|sheet   |Integer|->|Sheet index (current sheet if omitted)|
|Result |Collection|<-|Collection of objects with all the items modified since the last reset|<!-- END REF -->


## Description

The `VP Get table dirty rows` command <!-- REF #_method_.VP Get table dirty rows.Summary -->returns a collection of *dirty row* objects, containing items that were modified since the last reset in the specified *tableName*<!-- END REF -->.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *tableName*, pass the name of the table for which you want to get the dirty rows. Only modified columns bound to a [data context](VP%20SET%20DATA%20CONTEXT.md) will be taken into account.

By default, calling the command will clear the *dirty* status from the current table. To keep this status untouched, pass `False` in the *reset* parameter. 

In *sheet*, pass the index of the target sheet. If no index is specified or if you pass -1, the command applies to the current sheet.

> Indexing starts at 0.

Each *dirty row* object in the returned collection contains the following properties:

|Property|Type|Description|
|---|---|---|
|item|object|Modified object of the modified row |
|originalItem|object|Object before modification|
|row|integer|Index of the modified row|

If *tableName* is not found or if it does not contain a modified column, the command returns an empty collection. 

## Example

You want to count the number of edited rows:

```4d
var $dirty : Collection
$dirty:=VP Get table dirty rows("ViewProArea"; "ContextTable"; False)
VP SET NUM VALUE(VP Cell("ViewProArea"; 0; 0); $dirty.length)
```

## See also

[VP CREATE TABLE](VP%20CREATE%20TABLE.md)<br/>
[VP Find table](VP%20Find%20table.md)<br/>
[VP SET TABLE COLUMN ATTRIBUTES](VP%20SET%20TABLE%20COLUMN%20ATTRIBUTES.md)<br/>
[VP RESIZE TABLE](VP%20RESIZE%20TABLE.md)