<!---->
# VP REMOVE DATA SOURCE

**VP REMOVE DATA SOURCE** ( *vpAreaName* : Text ; *name* : Text )

| Parameter   | Type | Description |
|------------|------|-------------|
| vpAreaName | Text | 4D View Pro area form object name |
| name       | Text | Name of the data source to remove |

## Description

The `VP REMOVE DATA SOURCE` command removes a data source previously registered with [VP ADD DATA SOURCE](VP%20ADD%20DATA%20SOURCE.md) from the SpreadJS DataManager.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *name*, pass the name of the DataManager table to remove. This is either:

- The dataclass name (when `VP ADD DATA SOURCE` was called without a custom `name` option).
- The custom name specified in the `options.name` parameter of `VP ADD DATA SOURCE`.

If no data source with the given name exists, the command does nothing.

> Removing a data source also removes any relationships associated with it in the DataManager.

## Examples

### Remove a DataClass data source

```4d
// Add
VP ADD DATA SOURCE("ViewProArea"; ds.Employee)

// Remove
VP REMOVE DATA SOURCE("ViewProArea"; "Employee")
```

### Remove a custom-named data source

```4d
// Add with custom name
VP ADD DATA SOURCE("ViewProArea"; ds.Employee; {name: "Staff"})

// Remove using the custom name
VP REMOVE DATA SOURCE("ViewProArea"; "Staff")
```

### Remove a custom data source

```4d
// Add
VP ADD DATA SOURCE("ViewProArea"; "ExternalProducts"; {\
  remote: {read: "https://api.example.com/products"}\
})

// Remove
VP REMOVE DATA SOURCE("ViewProArea"; "ExternalProducts")
```

## See also

[VP ADD DATA SOURCE](VP%20ADD%20DATA%20SOURCE.md)
