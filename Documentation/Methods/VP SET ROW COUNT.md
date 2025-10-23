# VP SET ROW COUNT


**VP SET ROW COUNT** ( *vpAreaName* : Text ; *rowCount* : Integer { ; *sheet* : Integer }  ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|rowCount |Integer|->|Number of rows|
|sheet|Integer|->|Sheet index (current sheet if omitted)|

## Description

The `VP SET ROW COUNT` command defines the total number of rows in *vpAreaName*.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

Pass the total number of rows in the *rowCount* parameter. *rowCount* must be greater than 0.

In the optional *sheet* parameter, you can designate a specific spreadsheet where the *rowCount* will be applied (counting begins at 0). If omitted, the current spreadsheet is used by default. You can explicitly select the current spreadsheet with the following constant:

* `vk current sheet`

## Example

The following code defines five rows in the 4D View Pro area:

```4d
VP SET ROW COUNT("ViewProArea";5)
```

![](../images/cmd_vpSetRowCount.PNG)

## See also

[VP Get column count](VP%20Get%20column%20count.md)<br/>
[VP get row-count](VP%20Get%20row%20count.md)<br/>
[VP SET COLUMN COUNT](VP%20SET%20COLUMN%20COUNT.md)