<!---->
# VP REMOVE TABLE SHEET

**VP REMOVE TABLE SHEET** ( *vpAreaName* : Text ; *name* : Text )

| Parameter    | Type    | Description |
|-------------|---------|-------------|
| vpAreaName  | Text    | 4D View Pro area form object name |
| name        | Text    | Name of the sheet tab to remove |

## Description

The `VP REMOVE TABLE SHEET` command removes a TableSheet tab previously created with [VP ADD TABLE SHEET](VP%20ADD%20TABLE%20SHEET.md) from the 4D View Pro area.

The command removes both the sheet tab and its associated DataManager view. The underlying data source is **not** removed — use [VP REMOVE DATA SOURCE](VP%20REMOVE%20DATA%20SOURCE.md) to unregister it separately.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *name*, pass the name of the sheet tab to remove. This must match the sheet tab name (which defaults to the *name* parameter used in `VP ADD TABLE SHEET`, or the *sheetName* option if one was provided).

## Examples

### Remove a single TableSheet

```4d
VP REMOVE TABLE SHEET("ViewProArea"; "Employees")
```

### Full cleanup: remove sheet then data source

```4d
// Remove the TableSheet view first
VP REMOVE TABLE SHEET("ViewProArea"; "Employees")

// Then remove the data source from the DataManager
VP REMOVE DATA SOURCE("ViewProArea"; "Employees")
```

### Remove multiple TableSheet views

```4d
VP REMOVE TABLE SHEET("ViewProArea"; "AllProducts")
VP REMOVE TABLE SHEET("ViewProArea"; "Summary")

// The shared data source can be removed after all views are gone
VP REMOVE DATA SOURCE("ViewProArea"; "Products")
```

## See also

[VP ADD TABLE SHEET](VP%20ADD%20TABLE%20SHEET.md)<br/>
[VP REMOVE DATA SOURCE](VP%20REMOVE%20DATA%20SOURCE.md)
