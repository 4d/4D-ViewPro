# VP REMOVE STYLESHEET


**VP REMOVE STYLESHEET** ( *vpAreaName* : Text ; *styleName* : Text { ; *sheet* : Integer } ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName   |Text|->|4D View Pro area form object name|
|styleName   |Text|->|Name of style to remove|
|sheet|Integer|->|Sheet index (current sheet if omitted)|

## Description

The `VP REMOVE STYLESHEET` command removes the style sheet passed in the *styleName* from the *vpAreaName*.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

Pass the style sheet to remove in the *styleName* parameter.

You can define where to remove the style in the optional *sheet* parameter using the sheet index (counting begins at 0) or with the following constants:

* `vk current sheet`
* `vk workbook`

## Example

To remove the *GreenDashDotStyle* style object from the current sheet:

```4d
VP REMOVE STYLESHEET("ViewProArea";"GreenDashDotStyle")
```

## See also

[VP ADD STYLESHEET](VP%20ADD%20STYLESHEET.md)<br/>
[VP Get stylesheet](VP%20Get%20stylesheet.md)<br/>
[VP Get stylesheets](VP%20Get%20stylesheets.md)