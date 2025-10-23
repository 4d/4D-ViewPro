# VP Get table theme





**VP Get table theme** ( *vpAreaName* : Text ; *tableName* : Text {; *sheet* : Integer } ) : cs.ViewPro.TableTheme



|Parameter|Type| |Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|tableName|Text|->|Table name|
|sheet   |Integer|->|Sheet index (current sheet if omitted)|
|Result|[cs.ViewPro.TableTheme](../classes.md#tabletheme)|<-|Current table theme property values|


## Description

The `VP Get table theme` command returns the current theme propertie values of the *tableName*. A table theme can be set using the [`VP CREATE TABLE`](VP%20CREATE%20TABLE.md) or [`VP SET TABLE THEME`](VP%20SET%20TABLE%20THEME.md) commands, or through the interface. 

In *vpAreaName*, pass the name of the 4D View Pro area and in *tableName*, the name of the table. 

In *sheet*, pass the index of the target sheet. If no index is specified or if you pass -1, the command applies to the current sheet.

The command returns an object of the [cs.ViewPro.TableTheme](../classes.md#tabletheme) class with properties and values that describe the current table theme. 


## Example

The command returns a full `theme` object even if a [native SpreadJS theme](https://developer.mescius.com/spreadjs/api/classes/GC.Spread.Sheets.Tables.TableThemes) name was used to define the theme.

```4d
var $param : cs.ViewPro.TableTheme
$param:=cs.ViewPro.TableTheme.new()
$param.theme:="dark10" //use of a native theme name

VP SET TABLE THEME("ViewProArea"; "ContextTable"; $param)
$vTheme:=VP Get table theme("ViewProArea"; "ContextTable")
$result:=Asserted(Value type($vTheme.theme)=Is object) //true
```


## See also

[VP CREATE TABLE](VP%20CREATE%20TABLE.md)<br/>
[VP SET TABLE THEME](VP%20SET%20TABLE%20THEME.md)