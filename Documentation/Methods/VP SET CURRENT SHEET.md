# VP SET CURRENT SHEET


**VP SET CURRENT SHEET** ( *vpAreaName* : Text ; *sheet* : Integer)



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName| Text|->|4D View Pro area form object name|
|sheet|Integer|<-|Index of the new current sheet|

## Description

The `VP SET CURRENT SHEET` command sets the current sheet in *vpAreaName* . The current sheet is the selected sheet in the document.


In *vpAreaName*, pass the name of the 4D View Pro area.

In *sheet*, pass the index of the sheet to be set as current sheet. If the index passed is inferior to 0 or exceeds the number of sheets, the command does nothing.

> Indexing starts at 0.

## Example

The document's current sheet is the first sheet:

![first-sheet-selected](../images/vp-sheet-3-select.png)

Set the current sheet to the third sheet:

```4d
VP SET CURRENT SHEET("ViewProArea";2)
```

![](../images/vp-sheet-3-select.png)

## See also

[VP Get current sheet](VP%20Get%20current%20sheet.md)