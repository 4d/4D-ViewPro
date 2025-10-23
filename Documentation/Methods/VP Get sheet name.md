# VP Get sheet name


**VP Get sheet name** ( *vpAreaName* : Text ; *sheet* : Integer ) : Text



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName| Text|->|4D View Pro area form object name|
|sheet| Integer|->|Sheet index|
|Function result|Text|<-|Sheet name|

## Description

The `VP Get sheet name` command returns the name of a sheet based on its index in *vpAreaName*.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *sheet*, pass the index of the sheet whose name will be returned.

If the passed sheet index does not exist, the method returns an empty name.

>Indexing starts at 0.

## Example

Get the name of the third sheet in the document:

```4d
$sheetName:=VP Get sheet name("ViewProArea";2)
```



## See also

[VP Get sheet index](VP%20Get%20sheet%20index.md)