# VP DELETE COLUMNS


**VP DELETE COLUMNS** ( *rangeObj* : Object )



|Parameter|Type| |Description|
|---|---|---|---|
|rangeObj| Object|->|Range object|

## Description

The `VP DELETE COLUMNS` command removes the columns in the *rangeObj*.

In *rangeObj*, pass an object containing a range of columns to remove. If the passed range contains:

* both columns and rows, only the columns are removed.
* only rows, the command does nothing.

>Columns are deleted from right to left.

## Example  

To delete columns selected by the user (in the image below columns B, C, and D):

![](../images/cmd_vpDeleteColumns.PNG)

use the following code:

```4d
VP DELETE COLUMNS(VP Get selection("ViewProArea"))
```

## See also

[VP DELETE ROWS](VP%20DELETE%20ROWS.md)<br/>
[VP INSERT COLUMNS](VP%20INSERT%20COLUMNS.md)<br/>
[VP INSERT ROWS](VP%20INSERT%20ROWS.md)