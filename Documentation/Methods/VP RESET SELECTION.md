# VP RESET SELECTION

<!-- REF #_method_.VP RESET SELECTION.Syntax -->
**VP RESET SELECTION** ( *vpAreaName* : Text { ; *sheet* : Integer } ) <!-- END REF -->

<!-- REF #_method_.VP RESET SELECTION.Params -->

|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName   |Text|->|4D View Pro area form object name|
|sheet    |Integer|->|Sheet index (current sheet if omitted)|<!-- END REF -->

## Description

The `VP RESET SELECTION` command <!-- REF #_method_.VP RESET SELECTION.Summary -->deselects all cells, resulting in no current selection or visible active cell<!-- END REF -->.

> A default active cell (cell A1) remains defined for 4D View Pro commands.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

In the optional *sheet* parameter, you can designate a specific spreadsheet where the range will be defined (counting begins at 0). If omitted, the current spreadsheet is used by default. You can explicitly select the current spreadsheet with the following constant:

* `vk current sheet`
  
## Example

You want to deselect all cells (the active cell and any selected cells):

```4d
VP RESET SELECTION("myVPArea")
```

## See also

[VP ADD SELECTION](VP%20ADD%20SELECTION.md)<br/>
[VP Get active cell](VP%20Get%20active%20cell.md)<br/>
[VP Get selection](VP%20Get%20selection.md)<br/>
[VP SET ACTIVE CELL](VP%20SET%20ACTIVE%20CELL.md)<br/>
[VP SET SELECTION](VP%20SET%20SELECTION.md)<br/>
[VP SHOW CELL](VP%20SHOW%20CELL.md)