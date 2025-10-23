# VP Get workbook options

### 



**VP Get workbook options** ( *vpAreaName* : Text ) : Object



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName  |Text|->|4D View Pro area form object name|
|Result |Object|<-|Object containing the workbook options|

## Description

`VP Get workbook options` 
returns an object containing all the workbook options in *vpAreaName*

In *vpAreaName*, pass the name of the 4D View Pro area.

The returned object contains all the workbook options (default and modified ones), in the workbook.

The list of workbook options is referenced in [`VP SET WORKBOOK OPTIONS`'s description](VP%20SET%20WORKBOOK%20OPTIONS.md).

## Example

```4d
var $workbookOptions : Object

$workbookOptions:=VP Get workbook options("ViewProArea")
```

## See also

[VP SET WORKBOOK OPTIONS](VP%20SET%20WORKBOOK%20OPTIONS.md)