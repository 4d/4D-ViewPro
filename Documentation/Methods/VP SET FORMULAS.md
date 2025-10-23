# VP SET FORMULAS


**VP SET FORMULAS** ( *rangeObj* : Object ; *formulasCol* : Collection ) 



|Parameter|Type||Description|
|---|---|---|---|
|rangeObj |Object|->|Cell range object|
|formulasCol |Collection|->|Collection of formulas|

## Description

The `VP SET FORMULAS` command assigns a collection of formulas starting at the specified cell range.

In *rangeObj*, pass a range of the cell (created with [VP Cell](VP%20Cell.md)) whose formula you want to specify. If *rangeObj* includes multiple ranges, only the first range is used.

The *formulasCol* is a two-dimensional collection:

* The first-level collection contains subcollections of formulas. Each subcollection defines a row.
* Each subcollection defines cell values for the row. Values must be text elements containing the formulas to assign to the cells.

> If the formula is a string, use the period `.` as numerical separator and the comma `,` as parameter separator.
> If a 4D method is used, it must be allowed with the [`VP SET ALLOWED METHODS`](VP%20SET%20ALLOWED%20METHODS.md) command.

You remove the formulas in *rangeObj* by replacing them with an empty string ("").

## Example 1

```4d
$formulas:=New collection
$formulas.push(New collection("MAX(B11,C11,D11)";"myMethod(G4)")) // First row
$formulas.push(New collection("SUM(B11:D11)";"AVERAGE(B11:D11)")) // Second row

 
VP SET FORMULAS(VP Cell("ViewProArea";6;3);$formulas) // Set the cells with the formulas
```

*myMethod*:

```4d
$0:=$1*3.33
```

![](../images/cmd_vpSetFormulas.PNG)

## Example 2

To remove formulas:

```4d
$formulas:=New collection
$formulas.push(New collection("";"")) // first collection
$formulas.push(New collection("";"")) // second collection
 
VP SET FORMULAS(VP Cell("ViewProArea";0;0);$formulas) // Assign to cells
```

## See also

[VP Get Formulas](VP%20Get%20formulas.md)<br/>
[VP GET VALUES](VP%20Get%20values.md)<br/>
[VP SET FORMULA](VP%20SET%20FORMULA.md)<br/>
[VP SET VALUES](VP%20SET%20VALUES.md)