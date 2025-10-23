# VP SUSPEND COMPUTING


**VP SUSPEND COMPUTING** ( *vpAreaName* : Text ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|

## Description

The `VP SUSPEND COMPUTING` command stops the calculation of all formulas in *vpAreaName*. This command is useful when you want to suspend calculations in this 4D View Pro area so you can manually make modifications to formulas without encountering errors before you've finished making the changes.

The command pauses the calculation service in 4D View Pro. Formulas that have already been calculated remain unchanged, however any formulas added after `VP SUSPEND COMPUTING` command  is executed are not calculated.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.

>The 4D View Pro calculation service maintains a counter of suspend/resume actions. Therefore, each execution of `VP SUSPEND COMPUTING` command  must be balanced by a corresponding execution of the `VP RESUME COMPUTING` command. Any formula impacted by modifications made while calculations are suspended will be recalculated when the command is executed.

## Example

You've added two buttons to the form so that the user can suspend/resume calculations:

![](../images/cmd_vpStopCalculations.PNG)

The Suspend Computing button code:

```4d
 //pause calculations while users enter information
 If(FORM Event.code=On Clicked)
 
    VP SUSPEND COMPUTING("ViewProArea")
 
 End if
```

```4d
If(FORM Event.code=On Clicked)
 
    VP RESUME COMPUTING("ViewProArea")
 
End if
```

## See also

[VP RECOMPUTE FORMULAS](VP%20RECOMPUTE%20FORMULAS.md)<br/>
[VP RESUME COMPUTING](VP%20RESUME%20COMPUTING.md)