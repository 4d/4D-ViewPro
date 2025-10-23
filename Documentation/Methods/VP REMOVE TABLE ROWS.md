# VP REMOVE TABLE ROWS




**VP REMOVE TABLE ROWS** ( *vpAreaName* : Text ; *tableName* : Text ; *row* : Integer {; *count* : Integer {; *sheet* : Integer }}} )



|Parameter|Type||Description|
|---|---|---|---|
|vpAreaName |Text|->|4D View Pro area form object name|
|tableName|Text|->|Table name|
|row|Integer|->|Index in the table of the starting row to remove|
|count|Integer|->|Number of rows to remove (must be >0) |
|sheet   |Integer|->|Sheet index (current sheet if omitted)|

## Description

The `VP REMOVE TABLE ROWS` command removes one or *count* row(s) from the specified *tableName* at the specified *row* index. The command removes values and styles.

This command removes rows from the *tableName* table, NOT from the sheet. The total number of rows of the sheet is not impacted by the command. Data present below the table (if any) are automatically moved up according to the number of removed rows.

If the *tableName* table is bound to a [data context](VP%20SET%20DATA%20CONTEXT.md), the command removes element(s) from the collection. 

If *tableName* does not exist, nothing happens.


## Example

To remove two rows from 3rd row of the "dataTable" table:

```4d
VP REMOVE TABLE ROWS("ViewProArea"; "dataTable"; 3; 2)
```

## See also

[VP INSERT TABLE ROWS](VP%20INSERT%20TABLE%20ROWS.md)<br/>
[VP REMOVE TABLE COLUMNS](VP%20REMOVE%20TABLE%20COLUMNS.md)