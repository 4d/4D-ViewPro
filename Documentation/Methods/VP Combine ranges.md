# VP Combine ranges

<!-- REF #_method_.VP Combine ranges.Syntax -->
**VP Combine ranges** ( *rangeObj* : Object ; *otherRangeObj* : Object {;...*otherRangeObjN* : Object }  ) : Object<!-- END REF -->

<!-- REF #_method_.VP Combine ranges.Params -->

|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj| Object|->|Range object|
|otherRangeObj| Object|->|Range object|
|Result| Object|<-|Object containing a combined range|<!-- END REF -->

## Description

The `VP Combine Ranges` command <!-- REF #_method_.VP Combine ranges.Summary -->returns a new range object that incorporates two or more existing range objects<!-- END REF -->. All of the ranges must be from the same 4D View Pro area.

In *rangeObj*, pass the first range object.

In *otherRangeObj*, pass another range object(s) to combine with *rangeObj*.

>The command incorporates *rangeObj* and *otherRangeObj* objects by reference.

## Example  

You want to combine cell, column, and row range objects in a new, distinct range object:

```4d
 $cell:=VP Cell("ViewProArea";2;4) // C5
 $column:=VP Column("ViewProArea";3) // column D
 $row:=VP Row("ViewProArea";9) // row 10
 
 $combine:=VP Combine ranges($cell;$column;$row)
```

## See also

[VP All](VP%20All.md)<br/>
[VP Cells](VP%20Cells.md)<br/>
[VP Column](VP%20Column.md)<br/>
[VP Name](VP%20Name.md)<br/>
[VP Row](VP%20Row.md)<br/>
[VP SET COLUMN ATTRIBUTES](VP%20SET%20COLUMN%20ATTRIBUTES.md)