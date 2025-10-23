# VP SET VALUES


**VP SET VALUES** ( *rangeObj* : Object ; *valuesCol* : Collection ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Range object|
|valuesCol  |Collection|->|Collection of values|

## Description

The `VP SET VALUES` command assigns a collection of values starting at the specified cell range.

In *rangeObj*, pass a range for the cell (created with [`VP Cell`](VP%20Cell.md)) whose value you want to specify. The cell defined in the *rangeObj* is used to determine the starting point.

>* If *rangeObj* is not a cell range, only the first cell of the range is used.
>* If *rangeObj* includes multiple ranges, only the first cell of the first range is used.

The *valuesCol* parameter is two-dimensional:


* The first-level collection contains subcollections of values. Each subcollection defines a row. Pass an empty collection to skip a row.
* Each subcollection defines cell values for the row. Values can be Integer, Real, Boolean, Text, Date, Null, or Object. If the value is an object, it can have the following properties:

 |Property| Type |Description|
 |---|---|---|
 |value| Integer, Real, Boolean, Text, Date, Null|  Value in the cell (except- time)|
 |time| Real| Time value (in seconds)|

## Example

```4d
$param:=New collection
$param.push(New collection(1;2;3;False)) //first row, 4 values
$param.push(New collection) //second row, untouched
$param.push(New collection(4;5;Null;"hello";"world")) // third row, 5 values
$param.push(New collection(6;7;8;9)) // fourth row, 4 values
$param.push(New collection(Null;New object("value";Current date;"time";42))) //fifth row, 1 value
   
VP SET VALUES(VP Cell("ViewProArea";2;1);$param)
```

![](../images/cmd_vpSetValues.PNG)

## See also

[VP Get formulas](VP%20Get%20formulas.md)<br/>
[VP Get value](VP%20Get%20value.md)<br/>
[VP Get Values](VP%20Get%20values.md)<br/>
[VP SET FORMULAS](VP%20SET%20FORMULAS.md)<br/>
[VP SET VALUE](VP%20SET%20VALUE.md)