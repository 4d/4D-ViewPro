# VP DELETE ROWS


**VP DELETE ROWS** ( *rangeObj* : Object )



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj| Object|->|Range object|

## Description

The `VP DELETE ROWS` command removes the rows  in the *rangeObj*.

In *rangeObj*, pass an object containing a range of rows  to remove. If the passed range contains:

* both columns and rows, only the rows  are removed.
* only columns, the command does nothing.

>Rows are deleted from bottom to top.

## Example  

To delete rows selected by the user (in the image below rows 1, 2, and 3):

![](../images/cmd_vpDeleteRows.PNG)

use the following code:

```4d

 VP DELETE ROWS(VP Get selection("ViewProArea"))
```

## See also

[VP DELETE ROWS](VP%20DELETE%20COLUMNS.md)<br/>
[VP INSERT COLUMNS](VP%20INSERT%20COLUMNS.md)<br/>
[VP INSERT ROWS](VP%20INSERT%20ROWS.md)