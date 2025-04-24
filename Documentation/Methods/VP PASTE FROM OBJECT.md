# VP PASTE FROM OBJECT



<!-- REF #_method_.PASTE FROM OBJECT.Syntax -->
**VP PASTE FROM OBJECT** ( *rangeObj* : Object ; *dataObject* : Object {; *options* : Longint} )<!-- END REF -->

<!-- REF #_method_.PASTE FROM OBJECT.Params -->

|Parameter|Type||Description|
|---|---|---|---|
|rangeObj|Object|->|Cell range object|
|dataObject|Object|->|Object containing the data to be pasted|
|options|Integer|->|Specifies what is pasted|<!-- END REF -->

## Description

The `VP PASTE FROM OBJECT` command <!-- REF #_method_.PASTE FROM OBJECT.Summary -->pastes the contents, style and formulas stored in *dataObject* to the *rangeObj* object<!-- END REF -->.

In *rangeObj*, pass the cell range object where the values, formatting, and/or formula cells will be pasted. If *rangeObj* refers to more than one cell, only the first one is used.

In *dataObject*, pass the object that contains the cell data, formatting, and formulas to be pasted.

In the optional *options* parameter, you can specify what to paste in the cell range. Possible values:

|Constant|Description|
|---|---|---|
|`vk clipboard options all`|Pastes all data objects, including values, formatting, and formulas.|
|`vk clipboard options formatting`|Pastes only the formatting.|
|`vk clipboard options formulas`|Pastes only the formulas.|
|`vk clipboard options formulas and formatting`|Pastes formulas and formatting.|
|`vk clipboard options values`|Pastes only values.|
|`vk clipboard options value and formatting`|Pastes values and formatting.|

The paste options defined in the [workbook options](VP%20SET%20WORKBOOK%20OPTIONS.md) are taken into account.

If *options* refers to a paste option not present in the copied object (e.g. formulas), the command does nothing.

## Example

See example the example from [VP Copy to object](VP%20Copy%20to%20object.md)

## See also

[VP Copy to object](VP%20Copy%20to%20object.md)<br/>
[VP MOVE CELLS](VP%20MOVE%20CELLS.md)<br/>
[VP Get workbook options](VP%20Get%20workbook%20options.md)<br/>
[VP SET WORKBOOK OPTIONS](VP%20SET%20WORKBOOK%20OPTIONS.md)