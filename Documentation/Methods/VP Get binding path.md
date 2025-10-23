# VP Get binding path




**VP Get binding path** ( *rangeObj* : Object ) : Text



|Parameter|Type||Description|
|---|---|---|---|
| rangeObj | Object | -> | Range object |
| Result  | Text | <- | Name of the attribute bound to the cell |

## Description

The `VP Get binding path` command returns the name of the attribute bound to the cell specified in *rangeObj*.

In *rangeObj*, pass an object that is either a cell range or a combined range of cells. Note that:

* If *rangeObj* is a range with several cells, the command returns the attribute name linked to the first cell in the range.
* If *rangeObj* contains several ranges of cells, the command returns the attribute name linked to the first cell of the first range.

## Example


```4d
var $p; $options : Object
var $myAttribute : Text

$p:=New object
$p.firstName:="Freehafer"
$p.lastName:="Nancy"

VP SET DATA CONTEXT("ViewProArea"; $p)

VP SET BINDING PATH(VP Cell("ViewProArea"; 0; 0); "firstName")
VP SET BINDING PATH(VP Cell("ViewProArea"; 1; 0); "lastName")

$myAttribute:=VP Get binding path(VP Cell("ViewProArea"; 1; 0)) // "lastName"
```

## See also

[VP SET BINDING PATH](VP%20SET%20BINDING%20PATH.md)<br/>
[VP Get data context](VP%20Get%20data%20context.md)<br/>
[VP SET DATA CONTEXT](VP%20Get%20data%20context.md)