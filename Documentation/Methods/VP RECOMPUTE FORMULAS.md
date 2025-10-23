# VP RECOMPUTE FORMULAS


**VP RECOMPUTE FORMULAS** ( *vpAreaName* : Text ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName   |Text|->|4D View Pro area form object name|

## Description

The `VP RECOMPUTE FORMULAS` command immediately evaluates all formulas in *vpAreaName*. By default, 4D automatically computes formulas when they are inserted, imported, or exported. `VP RECOMPUTE FORMULAS` allows you to force the compute at any time (e.g, in case modifications are made to the formulas or if the formulas contain calls to the database). The command launches the execution of the [VP FLUSH COMMANDS](VP%20FLUSH%20COMMANDS.md) command to execute any stored commands and clear the command buffer, then calculates all formulas in the workbook.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

>Be sure the [VP SUSPEND COMPUTING](VP%20SUSPEND%20COMPUTING.md) command has not been executed before using `VP RECOMPUTE FORMULAS`, otherwise the command does nothing.


## Example

To refresh all formulas in the workbook:

```4d
VP RECOMPUTE FORMULAS("ViewProArea")
```

## See also

[VP RESUME COMPUTING](VP%20RESUME%20COMPUTING.md)<br/>
[VP SUSPEND COMPUTING](VP%20SUSPEND%20COMPUTING.md)