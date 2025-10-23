# VP SET DEFAULT STYLE


**VP SET DEFAULT STYLE** ( *vpAreaName* : Text ; *styleObj* : Object { ; *sheet* : Integer } ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|styleObj |Object|->|Style object|
|sheet|Integer|->|Sheet index (default = current sheet)|

## Description

The `VP SET DEFAULT STYLE` command defines the style in the *styleObj* as the default style for a *sheet*.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

The *styleObj* lets you pass an object containing style settings. You can use an existing style sheet or you can create a new style. For more information, see the [Style objects](../configuring.md#style-objects) paragraph.

In the optional *sheet* parameter, you can designate a specific spreadsheet where the style will be defined. If omitted, the current spreadsheet is used by default. You can explicitly select the current spreadsheet with the following constant:

* `vk current sheet`

## Example

```4d
$style:=New object
$style.hAlign:=vk horizontal align left
$style.font:="12pt papyrus"
$style.backColor:="#E6E6FA" //light purple color
 
VP SET DEFAULT STYLE("myDoc";$style)
```

![](../images/cmd_vpSetDefaultStyle.PNG)

## See also

[VP ADD STYLESHEET](VP%20ADD%20STYLESHEET.md)<br/>
[VP Font to object](VP%20Font%20to%20object.md)<br/>
[VP Get default style](VP%20Get%20default%20style.md)<br/>
[VP Object to font](VP%20Object%20to%20font.md)<br/>
[VP SET BORDER](VP%20SET%20BORDER.md)<br/>
[VP SET CELL STYLE](VP%20SET%20CELL%20STYLE.md)