# VP SET SHEET NAME


**VP SET SHEET NAME** ( *vpAreaName* : Text ; *name* : Text {; *sheet*: Integer} )



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|name|Text|->|New name for the sheet|
|sheet|Integer|->|Index of the sheet to be renamed|

## Description

The `VP SET SHEET NAME` command renames a sheet in the document loaded in *vpAreaName*.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *name*, pass a new name for the sheet.

In *sheet*, pass the index of the sheet to rename.

> Indexing starts at 0.

If no *sheet* is passed, the command renames the current sheet.

The new name cannot contain the following characters: `*, :, [, ], ?,\,/`

The command does nothing if:

* the new name contains forbidden characters
* the new name's value is blank
* the new name already exists
* the passed *sheet* index does not exist

## Example

Set the third sheet's name to "Total first quarter":

```4d
VP SET SHEET NAME("ViewProArea";"Total first quarter";2)
```

![](../images/vp-sheet-index-name.png)