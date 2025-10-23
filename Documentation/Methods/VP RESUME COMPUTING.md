# VP RESUME COMPUTING


**VP RESUME COMPUTING** ( *vpAreaName* : Text ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName   |Text|->|4D View Pro area form object name|

## Description

The `VP RESUME COMPUTING` command  restarts the calculation of formulas in *vpAreaName*.

The command reactivates the calculation service in 4D View Pro. Any formulas impacted by changes made while calculations were suspended are updated, and formulas added after `VP RESUME COMPUTING` is executed are calculated.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

> The 4D View Pro calculation service maintains a counter of suspend/resume actions. Therefore, each execution of `VP RESUME COMPUTING` must be balanced by a corresponding execution of the [VP SUSPEND COMPUTING](VP%20SUSPEND%20COMPUTING.md) command.
  
## Example

See example in [VP SUSPEND COMPUTING](VP%20SUSPEND%20COMPUTING.md).

## See also

[VP RECOMPUTE FORMULAS](VP%20RECOMPUTE%20FORMULAS.md)<br/>
[VP SUSPEND COMPUTING](VP%20SUSPEND%20COMPUTING.md)