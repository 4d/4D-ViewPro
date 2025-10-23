# VP Get default style


**VP Get default style** ( *vpAreaName* : Text { ; *sheet* :  Integer } ) : Object



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName  |Text|->|4D View Pro area from object name|
|sheet  |Integer|->|Sheet index (current sheet if omitted)|
|Result  |Object|<-|Default style settings |

## Description

The `VP Get default style` command returns a default style object for a sheet. The returned object contains basic document rendering properties as well as the default style settings (if any) previously set by the [VP SET DEFAULT STYLE](VP%20SET%20DEFAULT%20STYLE.md) method. For more information about style properties, see [Style Objects & Style Sheets](../configuring.md#style-objects--style-sheets).

In *vpAreaName*, pass the name property of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

You can define where to get the column count in the optional *sheet* parameter using the sheet index (counting begins at 0). If omitted or if you pass `vk current sheet`, the current spreadsheet is used.

## Example

To get the details about the default style for this document:

![](../images/cmd_vpGetDefaultStyle.PNG)

This code:

```4d
$defaultStyle:=VP Get default style("myDoc")
```

will return this information in the *$defaultStyle* object:

```4d
{
 backColor:#E6E6FA,
 hAlign:0,
 vAlign:0,
 font:12pt papyrus
}
```

## See also

[VP Get cell style](VP%20Get%20cell%20style.md)<br/>
[VP SET DEFAULT STYLE](VP%20SET%20DEFAULT%20STYLE.md)