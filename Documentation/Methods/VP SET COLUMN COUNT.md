# VP SET COLUMN COUNT


**VP SET COLUMN COUNT** ( *vpAreaName* : Text , *columnCount* : Integer { , *sheet* : Integer } ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName|Text|->|4D View Pro area form object name|
|columnCount|Integer|->|Number of columns|
|sheet|Integer|->|Sheet index (current sheet if omitted)|

## Description

The `VP SET COLUMN COUNT` command defines the total number of columns in *vpAreaName*.


In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

Pass the total number of columns in the *columnCount* parameter. *columnCount* must be greater than 0.

In the optional *sheet* parameter, you can designate a specific spreadsheet where the *columnCount* will be applied (counting begins at 0). If omitted, the current spreadsheet is used by default. You can explicitly select the current spreadsheet with the following constant:

* `vk current sheet`

## Example

The following code defines five columns in the 4D View Pro area:

```4d
VP SET COLUMN COUNT("ViewProArea";5)
```

![](../images/cmd_vpSetColumnCount.PNG)

## See also

[VP Get column count](VP%20Get%20column%20count.md)<br/>
[VP Get row count](VP%20Get%20row%20count.md)<br/>
[VP SET ROW COUNT](VP%20SET%20ROW%20COUNT.md)