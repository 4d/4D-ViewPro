# VP Font to object


**VP Font to object** (  *font* : Text ) : Object




|Parameter|Type| |Description|
|---|---|---|---|
|font  |Text|->|Font shorthand string|  
|Result  |Object|<-|Font object|



## Description

The `VP Font to object` utility command returns an object from a font shorthand string. This object can then be used to set or get font property settings via object notation.

In the *font* parameter, pass a font shorthand string to specify the different properties of a font (e.g., "12 pt Arial"). You can learn more about font shorthand strings [in this page](https://www.w3schools.com/cssref/pr_font_font.asp) for example.

The returned object contains defined font attributes as properties. For more information about the available properties, see the [VP Object to font](VP%20Object%20to%20font.md) command.

## Example 1

This code:

```4d
$font:=VP Font to object("16pt arial")
```

will return the following $font object:

```4d
{

family:arial
size:16pt
}
```

## Example 2  

See example for [`VP Object to font`](VP%20Object%20to%20font.md).

## See also

[4D View Pro Style Objects and Style Sheets](../configuring.md#style-objects--style-sheets)<br/>
[VP Object to font](VP%20Object%20to%20font.md)<br/>
[VP SET CELL STYLE](VP%20SET%20CELL%20STYLE.md)<br/>
[VP SET DEFAULT STYLE](VP%20SET%20DEFAULT%20STYLE.md)