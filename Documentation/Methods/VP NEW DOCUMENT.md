# VP NEW DOCUMENT


**VP NEW DOCUMENT** ( *vpAreaName* : Text ) 



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName   |Text|->|4D View Pro area form object name|



## Description

The `VP NEW DOCUMENT` command loads and display a new, default document in the 4D View Pro form area object *vpAreaName*. The new empty document replaces any data already inserted in the area.

In *vpAreaName*, pass the name of the 4D View Pro area. If you pass a name that does not exist, an error is returned.  

## Example

You want to display an empty document in the "myVPArea" form object:

```4d
VP NEW DOCUMENT("myVPArea")
```

## See also

[VP IMPORT DOCUMENT](VP%20IMPORT%20DOCUMENT.md)

---