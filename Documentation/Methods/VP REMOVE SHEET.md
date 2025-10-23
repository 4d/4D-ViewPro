# VP REMOVE SHEET


**VP REMOVE SHEET** ( *vpAreaName* : Text ; *index*: Integer ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|index  |Integer|->|Index of the sheet to remove|

## Description

The `VP REMOVE SHEET` command removes the sheet with the specified *index* from the document loaded in *vpAreaName*.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *index*, pass the index of the sheet to remove. If the passed *index* does not exist, the command does nothing.

>Indexing starts at 0.

## Example

The document currently has three sheets:

![](../images/vp-sheet-3.png)

Remove the third sheet:

```4d
VP REMOVE SHEET("ViewProArea";2)
```

![](../images/vp-sheet-2.png)

## See also

[VP ADD SHEET](VP%20ADD%20SHEET.md)