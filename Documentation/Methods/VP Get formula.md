# VP Get formula


**VP Get formula** ( *rangeObj* : Object) : Text



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj  |Object|->|Range object|
|Result  |Text|<-|Formula|



## Description

The `VP Get formula` command retrieves the formula from a designated cell range.

In *rangeObj*, pass a range whose formula you want to retrieve. If *rangeObj* designates multiple cells or multiple ranges, the formula of the first cell is returned. If *rangeObj* is a cell that does not contain a formula, the method returns an empty string.

## Example

```4d
  //set a formula
VP SET FORMULA(VP Cell("ViewProArea";5;2);"SUM($A$1:$C$10)")
 
$result:=VP Get formula(VP Cell("ViewProArea";5;2)) // $result="SUM($A$1:$C$10)"
```

## See also

[VP Get formulas](VP%20Get%20formulas.md)<br/>
[VP SET FORMULA](VP%20SET%20FORMULA.md)<br/>
[VP SET ROW COUNT](VP%20SET%20ROW%20COUNT.md)