<!---->
# VP ADD DATA SOURCE

**VP ADD DATA SOURCE** ( *vpAreaName* : Text ; *source* : Variant {; *options* : Object} )

| Parameter    | Type    | Description |
|-------------|---------|-------------|
| vpAreaName  | Text    | 4D View Pro area form object name |
| source      | Variant | 4D DataClass, Collection, or Text |
| options     | Object  | Additional options |

## Description

The `VP ADD DATA SOURCE` command registers a data source in the SpreadJS [DataManager](https://developer.mescius.com/spreadjs/docs/features/data-manager), making it available for TableSheet views, formulas, and data-driven features within the 4D View Pro area.

The command supports three modes:

- **DataClass mode**: pass a `4D.DataClass` object — schema is extracted automatically via ORDA, and CRUD operations are wired through the 4D REST API.
- **Data mode**: pass a `Collection`, an `Object` (column-oriented), or a Text string (CSV/XML) — data is loaded in-memory into the DataManager with no REST endpoints.
- **Custom mode**: pass a Text name and provide URLs in *options* — for any REST API, not limited to 4D.

In *vpAreaName*, pass the name of the 4D View Pro area.

In *source*, pass either:

- A **4D.DataClass** (e.g., `ds.Employee`) to automatically set up the data source from a 4D dataclass.
- A **Collection** (e.g., `[{name: "Alice"; age: 30}; {name: "Bob"; age: 25}]`) to create an in-memory data source from row-oriented local data.
- An **Object** (e.g., `{name: ["Alice"; "Bob"]; age: [30; 25]}`) to create an in-memory data source from column-oriented data (columnJson format).
- A **Text** name (e.g., `"ExternalProducts"`) to register a custom data source with user-provided URLs, or a text string containing CSV/XML data for an in-memory data source.

### DataClass Mode

When *source* is a `4D.DataClass`, the command:

1. Retrieves the dataclass schema (field names and types) via ORDA `getInfo()`.
2. Maps 4D field types to SpreadJS column types (`number`, `date`, `boolean`, `string`).
3. Registers the data source in the DataManager with CRUD operations using the 4D REST API.

Only `storage` kind attributes are included as columns. Relation attributes (`relatedEntity` and `relatedEntities`) are automatically detected and used to create DataManager relationships when both related dataclasses are registered. See [Relationships](#relationships) below.

### Data Mode

When *source* is a **Collection**, an **Object**, or a **Text** without `options.remote`, the command creates an in-memory data source directly from the provided data.

- **Collection**: the collection is passed as a JavaScript array to SpreadJS. Each element of the collection becomes a row. The `options.name` is **required** since no automatic name can be inferred.
- **Object** (columnJson): the object properties represent columns, each containing an array of values. Rows are constructed by aligning values by index. The `options.name` is **required**. Schema defaults to `{type: "columnJson"}` if not provided.
- **Text (CSV/XML)**: the text content is used as inline data. You must provide `options.schema` with a `type` property (`"csv"` or `"xml"`) so SpreadJS knows how to parse it. The `options.name` is **required**.

For XML data, you may also need to specify `options.schema.dataPath` to indicate the path to the repeating elements in the XML structure.

This mode does not use any REST endpoints — the data lives entirely in the SpreadJS DataManager memory.

### Custom Mode

When *source* is a Text **with `options.remote` provided**, the command registers a data source using URLs and schema provided in *options*. This allows binding to any external REST API.

The `options.remote` object is required in custom mode and defines the endpoint for each operation.

## Options

### Common options (both modes)

| Property     | Type    | Default            | Description |
|-------------|---------|-------------------|-------------|
| name        | Text    | dataclass/source name | Custom name for the DataManager table. Allows registering multiple views of the same dataclass with different configurations. |
| readOnly    | Boolean | False              | When True, disables all write operations (create, update, delete). |
| allowCreate | Boolean | True               | Enable entity creation. Ignored if *readOnly* is True. |
| allowUpdate | Boolean | True               | Enable entity updates. Ignored if *readOnly* is True. |
| allowDelete | Boolean | True               | Enable entity deletion. Ignored if *readOnly* is True. |
| autoSync    | Boolean | True               | Auto-commit changes to server. When False, enables batch mode. |
| pageSize    | Integer | 100                | Number of records per page for pagination. |
| primaryKey  | Text    | `"__KEY"` (DataClass mode) | Primary key field name. Required for relationships to work correctly. Automatically set to `"__KEY"` in DataClass mode. |
| relationships | Object | (auto in DataClass mode) | Manual relationship definitions using SpreadJS `on` syntax. See [Relationships](#relationships) below. |

### DataClass mode options

| Property | Type       | Default              | Description |
|----------|-----------|----------------------|-------------|
| fields   | Collection | All storage fields   | Collection of Text values specifying which dataclass fields to expose as columns. When provided, only the listed fields appear in the data source schema. |

### Custom mode options

| Property | Type   | Default    | Description |
|----------|--------|-----------|-------------|
| remote   | Object | (required) | Defines the REST endpoints for each operation. See [Remote object](#remote-object) below. |
| schema   | Object | (optional) | SpreadJS schema definition. See [Schema object](#schema-object) below. |

### Data mode options

| Property | Type   | Default    | Description |
|----------|--------|-----------|-------------|
| name     | Text   | (required) | Name for the DataManager table. Required in data mode since no automatic name can be inferred. |
| schema   | Object | (optional for Collection/Object, required for CSV/XML) | When *source* is a Collection or Object, schema is optional (Object defaults to `{type: "columnJson"}`). When *source* is CSV or XML text, `schema.type` must be `"csv"` or `"xml"`. For XML, `schema.dataPath` specifies the path to repeating elements. |

#### Remote object

The `remote` object defines endpoints for CRUD operations. Each property can be:

- A **URL string** — the command builds a fetch call with appropriate HTTP method.
- An **Object** with `url`, `method`, and optional `headers` properties.

| Property | HTTP Method | Description |
|----------|------------|-------------|
| read     | GET        | Endpoint to fetch records |
| create   | POST       | Endpoint to create a new record |
| update   | PATCH      | Endpoint to update an existing record |
| destroy  | DELETE     | Endpoint to delete a record |
| delete   | DELETE     | Alias for *destroy* |

#### Schema object

The `schema` object follows the SpreadJS DataManager schema format:

```json
{
  "columns": {
    "fieldName": {
      "dataType": "string"
    },
    "price": {
      "dataType": "number"
    }
  }
}
```

Supported `dataType` values: `"string"`, `"number"`, `"date"`, `"boolean"`.

## Relationships

The DataManager supports relationships between tables, allowing TableSheet views to display related data across data sources.

### Automatic relationships (DataClass mode)

When *source* is a `4D.DataClass`, the command automatically detects ORDA relation attributes (`relatedEntity` and `relatedEntities`) and creates corresponding DataManager relationships.

- **`relatedEntity`** (N→1): e.g., `Employee.department` points to `Department` — the employee table gets a foreign key link to the department table.
- **`relatedEntities`** (1→N): the inverse side — handled automatically when the other dataclass is registered.

Both dataclasses must be registered as data sources for the relationship to be created. The registration order does not matter — if the related table is not yet registered, the relationship is deferred and resolved automatically when the second table is added.

### Manual relationships (all modes)

For custom or data mode data sources, you can define relationships explicitly using the `options.relationships` property with SpreadJS `on` syntax:

```4d
VP ADD DATA SOURCE("ViewProArea"; "Orders"; {\
  remote: {read: "https://api.example.com/orders"}; \
  primaryKey: "ID"; \
  relationships: {\
    relatedCustomer: {on: "Orders.CustomerID = Customers.ID"}\
  }\
})
```

The `on` expression format is `"SourceTable.SourceField = TargetTable.TargetField"`.

## Examples

### Basic DataClass binding

Register the `Employee` dataclass with all fields:

```4d
VP ADD DATA SOURCE("ViewProArea"; ds.Employee)
```

### DataClass with field filtering and read-only

Register only specific fields in read-only mode with a custom name:

```4d
var $options:={}
$options.name:="Staff"
$options.fields:=["lastName"; "firstName"; "salary"; "department"]
$options.readOnly:=True

VP ADD DATA SOURCE("ViewProArea"; ds.Employee; $options)
```

### Multiple views of the same DataClass

Create two data sources from the same dataclass with different configurations:

```4d
// Full access view
VP ADD DATA SOURCE("ViewProArea"; ds.Employee; {name: "EmployeeAdmin"})

// Read-only summary view
VP ADD DATA SOURCE("ViewProArea"; ds.Employee; {\
  name: "EmployeeSummary"; \
  fields: ["lastName"; "firstName"; "department"]; \
  readOnly: True\
})
```

### DataClass with selective permissions

Allow viewing and editing, but prevent deletion:

```4d
VP ADD DATA SOURCE("ViewProArea"; ds.Product; {\
  allowDelete: False\
})
```

### Custom data source with external API

Bind to an external REST API:

```4d
VP ADD DATA SOURCE("ViewProArea"; "ExternalProducts"; {\
  remote: {\
    read: {url: "https://api.example.com/products"; method: "GET"}; \
    create: {url: "https://api.example.com/products"; method: "POST"}; \
    update: {url: "https://api.example.com/products"; method: "PUT"}\
  }; \
  schema: {\
    columns: {\
      name: {dataType: "string"}; \
      price: {dataType: "number"}; \
      inStock: {dataType: "boolean"}\
    }\
  }\
})
```

### Custom read-only data source

```4d
VP ADD DATA SOURCE("ViewProArea"; "PublicData"; {\
  remote: {read: "https://api.example.com/data"}; \
  readOnly: True\
})
```

### In-memory data from a Collection

Load a collection of objects as an in-memory data source:

```4d
var $data:=[{name: "Alice"; age: 30; city: "Paris"}; \
  {name: "Bob"; age: 25; city: "London"}; \
  {name: "Charlie"; age: 35; city: "Berlin"}]

VP ADD DATA SOURCE("ViewProArea"; $data; {name: "People"})
```

### In-memory data from an entity selection

Convert an entity selection to a collection and load it in memory:

```4d
var $employees:=ds.Employee.all().toCollection("firstName,lastName,salary")

VP ADD DATA SOURCE("ViewProArea"; $employees; {name: "EmployeeData"})
```

### In-memory CSV data

Load CSV text as an in-memory data source:

```4d
var $csv:="name,price,quantity\nWidget,9.99,100\nGadget,24.99,50\nDoohickey,4.99,200"

VP ADD DATA SOURCE("ViewProArea"; $csv; {\
  name: "Products"; \
  schema: {type: "csv"}\
})
```

### In-memory XML data

Load XML text as an in-memory data source:

```4d
var $xml:="<catalog><book><title>4D Programming</title><price>49.99</price></book><book><title>SpreadJS Guide</title><price>39.99</price></book></catalog>"

VP ADD DATA SOURCE("ViewProArea"; $xml; {\
  name: "Books"; \
  schema: {type: "xml"; dataPath: "catalog.book"}\
})
```

### In-memory column-oriented data (columnJson)

Load column-oriented data as an in-memory data source:

```4d
var $data:={name: ["Alice"; "Bob"; "Charlie"]; \
  score: [95; 87; 92]; \
  grade: ["A"; "B+"; "A-"]}

VP ADD DATA SOURCE("ViewProArea"; $data; {name: "Scores"})
```

Each property of the object is a column, and each array element is a row value. The schema defaults to `{type: "columnJson"}` automatically.

### Related DataClasses with automatic relationships

Register two related dataclasses — relationships are created automatically:

```4d
// Employee has a "department" relatedEntity → Department
// Department has an "employees" relatedEntities → Employee
VP ADD DATA SOURCE("ViewProArea"; ds.Department)
VP ADD DATA SOURCE("ViewProArea"; ds.Employee)

// The DataManager now has a relationship between Employee and Department.
// In a TableSheet, the Employee table can display department fields,
// and the Department table can show related employees.
```

### Manual relationship between custom data sources

```4d
VP ADD DATA SOURCE("ViewProArea"; "Customers"; {\
  remote: {read: "https://api.example.com/customers"}; \
  primaryKey: "ID"\
})

VP ADD DATA SOURCE("ViewProArea"; "Orders"; {\
  remote: {read: "https://api.example.com/orders"}; \
  primaryKey: "ID"; \
  relationships: {\
    relatedCustomer: {on: "Orders.CustomerID = Customers.ID"}\
  }\
})
```

## See also

[VP REMOVE DATA SOURCE](VP%20REMOVE%20DATA%20SOURCE.md)
