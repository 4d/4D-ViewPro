# VP Name

<!-- REF #_method_.VP Name.Syntax -->
**VP Name** ( *vpAreaName* : Text ; *rangeName* : Text { ; *sheet* : Integer }  ) : Object <!-- END REF -->

<!-- REF #_method_.VP Name.Params -->

|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName|Text|->|4D View Pro area form object name|
|rangeName|Text|->|Existing range name|
|sheet|Integer|->|Range location (current sheet if omitted)|
|Result|Object|<-|Range object of name|<!-- END REF -->

## Description

The `VP Name` command <!-- REF #_method_.VP Name.Summary -->returns a new range object referencing a named range<!-- END REF -->.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

The *rangeName* parameter specifies an existing named cell range.

In the optional *sheet* parameter, you can designate a specific spreadsheet where *rangeName* is defined. If omitted, the current spreadsheet is used by default. You can explicitly select the current spreadsheet or the entire workbook with the following constants:

* `vk current sheet`
* `vk workbook`  

## Example

You want to give a value to the "Total" named range.

```4d
// name the B5 cell as Total
VP ADD RANGE NAME(VP Cell("ViewProArea";1;4);"Total")
$name:=VP Name("ViewProArea";"Total")
VP SET NUM VALUE($name;285;"$#,###.00")
```

## See also

[VP ADD RANGE NAME](VP%20ADD%20RANGE%20NAME.md)<br/>
[VP ALL](VP%20All.md)<br/>
[VP Cell](VP%20Cell.md)<br/>
[VP Cells](VP%20Cells.md)<br/>
[VP Column](VP%20Column.md)<br/>
[VP Combine ranges](VP%20Combine%20ranges.md)<br/>
[VP Get names](VP%20Get%20names.md)<br/>
[VP REMOVE NAME](VP%20REMOVE%20NAME.md)<br/>
[VP Row](VP%20Row.md)