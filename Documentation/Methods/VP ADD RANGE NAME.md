# VP ADD RANGE NAME



**VP ADD RANGE NAME** ( *rangeObj* : Object ; *name* : Text { ; *options* : Object } )



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj| Object|->|Range object |
|name|Text|->|Name for the fomula|
|options|Object|->|Options for the named formula|

## Description

The `VP ADD RANGE NAME` command creates or modifies a named range in the open document.

>Named ranges created by this command are saved with the document.

In *rangeObj*, pass the range that you want to name and in *name*, pass the new name for the range. If the name is already used within the same scope, the new named range replaces the existing one. Note that you can use the same name for different scopes (see below).

You can pass an object with additional properties for the named range in *options*. The following properties are supported:

|Property |Type|Description|
|---|---|---|
|scope| Number| Scope for the range. You can pass the sheet index (counting begins at 0) or use the following constants: <li>`vk current sheet`</li><li>`vk workbook`</li>The scope determines whether a range name is local to a given worksheet (*scope*=sheet index or `vk current sheet`), or global across the entire workbook (*scope*=`vk workbook`).|
|comment|Text|Comment associated to named range|

>* A named range is actually a named formula containing coordinates. `VP ADD RANGE NAME` facilitates the creation of named ranges, but you can also use the [`VP ADD FORMULA NAME`](VP%20ADD%20FORMULA%20NAME.md) method to create named ranges.
> * Formulas defining named ranges can be retrieved with the [`VP Get formula by name`](VP%20Get%20formula%20by%20name.md) method.

## Example  

You want to create a named range for a cell range:

```4d
$range:=VP Cell("ViewProArea";2;10)
VP ADD RANGE NAME($range;"Total1")
```

## See also

[VP Get names](VP%20Get%20names.md)<br/>
[VP Name](VP%20Name.md)