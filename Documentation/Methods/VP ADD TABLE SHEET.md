<!---->
# VP ADD TABLE SHEET

**VP ADD TABLE SHEET** ( *vpAreaName* : Text ; *name* : Text ; *source* : Text {; *options* : Object} )

| Parameter    | Type    | Description |
|-------------|---------|-------------|
| vpAreaName  | Text    | 4D View Pro area form object name |
| name        | Text    | Name for the new sheet tab and DataManager view |
| source      | Text    | Name of the data source registered with `VP ADD DATA SOURCE` |
| options     | Object  | Additional options |

## Description

The `VP ADD TABLE SHEET` command creates a new TableSheet tab in the 4D View Pro area and binds it to a data source previously registered with [VP ADD DATA SOURCE](VP%20ADD%20DATA%20SOURCE.md).

A TableSheet is a special SpreadJS sheet type designed to display data from the [DataManager](https://developer.mescius.com/spreadjs/docs/features/data-manager). Unlike regular sheets where you place data cell by cell, a TableSheet automatically renders all rows and columns from the data source, with built-in support for sorting, filtering, and editing.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *name*, pass the name for the new sheet tab. This name is also used as the DataManager view name. It must be unique among existing sheets.

In *source*, pass the name of a data source previously registered with `VP ADD DATA SOURCE`. The data source must exist in the DataManager before calling this command.

In *options*, you can pass an object with the following properties:

| Property   | Type | Default | Description |
|-----------|------|---------|-------------|
| sheetName | Text | *name*  | Custom display name for the sheet tab, if different from the view name. |
| columns   | Collection | (empty) | Array of column configuration objects for the DataManager view. When omitted, all columns are auto-generated from the data source schema. See [Column configuration](#column-configuration) below. |
| defaultColumnWidth | Number | (auto) | Default width in pixels for columns that don't specify a width. |

### Column configuration

Each object in the `columns` collection defines a view column. Columns are displayed in the order they appear in the collection.

| Property | Type | Description |
|----------|------|-------------|
| value | Text | Field name, dot-notation related field (e.g., `"department.name"`), or formula (e.g., `"=[@salary] * 12"`). |
| caption | Text | Column header label. Defaults to field name. |
| width | Number or Text | Width in pixels (`150`) or star sizing (`"*"`, `"2*"`). |
| style | Object | Cell style (e.g., `{hAlign: "right"}`). |
| headerStyle | Object | Header style (e.g., `{font: "bold 14pt Calibri"}`). |
| headerFit | Text | Header layout: `"normal"`, `"vertical"`, or `"stack"`. |
| showNullAs | Text | Display text for null values. |
| showEmptyAs | Text | Display text for empty values. |
| readonly | Boolean | Column-level read-only. |
| required | Boolean | Column-level required. |
| defaultValue | Variant | Default value for new rows. |
| validator | Object | Validation rule (e.g., `{type: "number"; min: 0; max: 100}`). |
| formatter | Text | Template syntax (e.g., `'{{=[@firstName] & " " & [@lastName]}}'`). |
| conditionalFormats | Collection | Array of conditional format rule objects. |

#### Value types

- **Field**: `"lastName"` — direct table field
- **Related field**: `"department.name"` — dot notation through a registered relationship
- **Formula**: `"=[@salary] * 12"` — computed column (`@` references the current row)
- **Row template**: `"=[@]"` — full row access for formatters

#### Conditional format rules

```4d
// Formula-based conditional format
{ruleType: "formulaRule"; formula: "@ > 50"; style: {backColor: "pink"}}
```

## Examples

### Display a DataClass as a TableSheet

```4d
// Register the data source
VP ADD DATA SOURCE("ViewProArea"; ds.Employee; {name: "Employees"})

// Create a TableSheet to display it
VP ADD TABLE SHEET("ViewProArea"; "Employees"; "Employees")
```

### Display in-memory data as a TableSheet

```4d
// Register a Collection as a data source
var $data:=[{name: "Alice"; score: 95}; {name: "Bob"; score: 82}]
VP ADD DATA SOURCE("ViewProArea"; $data; {name: "Scores"})

// Create a TableSheet
VP ADD TABLE SHEET("ViewProArea"; "Scores"; "Scores")
```

### Multiple views of the same data source

```4d
VP ADD DATA SOURCE("ViewProArea"; ds.Product; {name: "Products"})

// Full view
VP ADD TABLE SHEET("ViewProArea"; "AllProducts"; "Products")

// Second view with a different sheet tab name
VP ADD TABLE SHEET("ViewProArea"; "ProductsSummary"; "Products"; \
  {sheetName: "Summary"})
```

### Custom column configuration

```4d
VP ADD DATA SOURCE("ViewProArea"; ds.Employee; {name: "Employees"})
VP ADD DATA SOURCE("ViewProArea"; ds.Department)

VP ADD TABLE SHEET("ViewProArea"; "Employees"; "Employees"; {\
  columns: [\
    {value: "lastName"; caption: "Last Name"; width: 200}; \
    {value: "firstName"; caption: "First Name"; width: 150}; \
    {value: "salary"; width: 120; style: {hAlign: "right"}}; \
    {value: "department.name"; caption: "Department"; width: 200}\
  ]\
})
```

### Computed columns and formatting

```4d
VP ADD TABLE SHEET("ViewProArea"; "StaffView"; "Employees"; {\
  columns: [\
    {value: "=[@]"; caption: "Full Name"; width: 250; \
      formatter: "{{=[@firstName] & \" \" & [@lastName]}}"}; \
    {value: "salary"; width: 120}; \
    {value: "=[@salary] * 12"; caption: "Annual Salary"; width: 150}\
  ]; \
  defaultColumnWidth: 120\
})
```

## See also

[VP ADD DATA SOURCE](VP%20ADD%20DATA%20SOURCE.md)<br/>
[VP REMOVE TABLE SHEET](VP%20REMOVE%20TABLE%20SHEET.md)
