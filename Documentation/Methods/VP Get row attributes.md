# VP Get row attributes


**VP Get row attributes** ( rangeObj : Object ) : Collection



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj  |Object|->|Range object|
|Result  |Collection|<-|Collection of row properties|

## Description

The `VP Get row attributes` command returns a collection of properties for any row in the *rangeObj*.

In *rangeObj*, pass an object containing a range of the rows whose attributes will be retrieved.

The returned collection contains any properties for the rows, whether or not they have been set by the [VP SET ROW ATTRIBUTES](VP%20SET%20ROW%20ATTRIBUTES.md) method.

## Example

The following code returns a collection of the attributes within the given range:

```4d
var $range : Object
var $attr : Collection
 
$range:=VP Column("ViewProArea";1;2)
$attr:=VP Get row attributes($range)
```

![](../images/cmd_vpGetRowAttributes.PNG)

## See also

[VP Get column attributes](VP%20Get%20column%20attributes.md)<br/>
[VP SET COLUMN ATTRIBUTES](VP%20SET%20COLUMN%20ATTRIBUTES.md)<br/>
[VP SET ROW ATTRIBUTES](VP%20SET%20ROW%20ATTRIBUTES.md)