var $vp : cs:C1710._vp
var $cell : cs:C1710._cell
var $column : cs:C1710._column
var $workbook : cs:C1710._workbook
var $range : cs:C1710._range
var $o : Object
var $value
var $values : Collection
var $picture : Picture
var $blb : Blob
var $t : Text

$vp:=Form:C1466.vp
$cell:=$vp.getCurrentCell()
$workbook:=cs:C1710._workbook.new($vp.area)

Case of 
		
		//mark:-Data Sources
	: (True:C214)
		
		If (Shift down:C543)
			
			// ── CLEANUP: remove table sheets, then data sources ──

			VP REMOVE TABLE($vp.area; "PeopleTable")

			VP REMOVE TABLE SHEET($vp.area; "Departments (ORDA)")
			VP REMOVE TABLE SHEET($vp.area; "Employees")
			VP REMOVE TABLE SHEET($vp.area; "People")
			VP REMOVE TABLE SHEET($vp.area; "Products")
			VP REMOVE TABLE SHEET($vp.area; "Books")
			VP REMOVE TABLE SHEET($vp.area; "Scores")
			VP REMOVE TABLE SHEET($vp.area; "Departments")
			VP REMOVE TABLE SHEET($vp.area; "Staff")

			VP REMOVE DATA SOURCE($vp.area; "Department")
			VP REMOVE DATA SOURCE($vp.area; "Employees")
			VP REMOVE DATA SOURCE($vp.area; "People")
			VP REMOVE DATA SOURCE($vp.area; "Products")
			VP REMOVE DATA SOURCE($vp.area; "Books")
			VP REMOVE DATA SOURCE($vp.area; "Scores")
			VP REMOVE DATA SOURCE($vp.area; "Departments")
			VP REMOVE DATA SOURCE($vp.area; "Staff")
			
		Else 
			
			// ── 1. DataClass mode with auto-relationship ──
			// Department registered first; Employee has relatedEntity "department" → Department
			// Relationship is deferred until Employee is registered
			VP ADD DATA SOURCE($vp.area; ds:C1482.Department)

			VP ADD DATA SOURCE($vp.area; ds:C1482.Employee; {\
				name: "Employees"; \
				fields: ["lastName"; "firstName"; "salary"; "departmentID"]; \
				readOnly: True:C214\
				})

			VP ADD TABLE SHEET($vp.area; "Departments (ORDA)"; "Department"; {\
				columns: [\
					{value: "ID"; width: 60}; \
					{value: "name"; caption: "Name"; width: 250}\
				]\
				})
			VP ADD TABLE SHEET($vp.area; "Employees"; "Employees"; {\
				columns: [\
					{value: "lastName"; caption: "Last Name"; width: 200}; \
					{value: "firstName"; caption: "First Name"; width: 150}; \
					{value: "salary"; width: 120; style: {hAlign: "right"}}; \
					{value: "department.name"; caption: "Department"; width: 200}\
				]\
				})
			
			// ── 2. Collection mode (in-memory) with schema ──
			var $people:=[{id: 1; firstName: "Alice"; lastName: "Martin"; age: 30; birthday: "1994-03-15"; city: "Paris"}; \
				{id: 2; firstName: "Bob"; lastName: "Dupont"; age: 25; birthday: "1999-07-22"; city: "London"}; \
				{id: 3; firstName: "Charlie"; lastName: "Smith"; age: 35; birthday: "1989-11-08"; city: "Berlin"}; \
				{id: 4; firstName: "Diana"; lastName: "Jones"; age: 28; birthday: "1996-01-30"; city: "Madrid"}; \
				{id: 5; firstName: "Eve"; lastName: "Garcia"; age: 42; birthday: "1982-09-05"; city: "Rome"}]
			
			VP ADD DATA SOURCE($vp.area; $people; {\
				name: "People"; \
				schema: {\
					columns: {\
						id: {dataType: "number"; isPrimaryKey: True:C214}; \
						firstName: {dataType: "string"}; \
						lastName: {dataType: "string"}; \
						age: {dataType: "number"}; \
						birthday: {dataType: "date"}; \
						city: {dataType: "string"}\
					}\
				}\
				})
			
			// ── 3. CSV mode (in-memory) ──
			var $csv:="name,price,quantity,inStock\nWidget,9.99,100,true\nGadget,24.99,50,true\nDoohickey,4.99,200,false\nThingamajig,14.99,75,true\nWhatchamacallit,7.49,150,false"
			
			VP ADD DATA SOURCE($vp.area; $csv; {\
				name: "Products"; \
				schema: {type: "csv"}\
				})
			
			// ── 4. XML mode (in-memory) ──
			var $xml:="<library><book><title>4D Programming</title><author>John</author><price>49.99</price></book><book><title>SpreadJS Guide</title><author>Jane</author><price>39.99</price></book><book><title>ORDA Deep Dive</title><author>Paul</author><price>29.99</price>"+"</book></library>"
			
			VP ADD DATA SOURCE($vp.area; $xml; {\
				name: "Books"; \
				schema: {type: "xml"; dataPath: "library.book"}\
				})
			
			// ── 5. ColumnJson mode (in-memory) ──
			var $scores:={\
				name: ["Alice"; "Bob"; "Charlie"; "Diana"]; \
				score: [95; 87; 92; 78]; \
				grade: ["A"; "B+"; "A-"; "C+"]\
				}

			VP ADD DATA SOURCE($vp.area; $scores; {name: "Scores"})

			// ── Create TableSheet views for in-memory data sources ──

			VP ADD TABLE SHEET($vp.area; "People"; "People"; {\
				columns: [\
					{value: "id"; caption: "ID"; width: 60}; \
					{value: "firstName"; caption: "First Name"; width: 150}; \
					{value: "lastName"; caption: "Last Name"; width: 150}; \
					{value: "age"; width: 80; style: {hAlign: "right"}}; \
					{value: "birthday"; caption: "Birthday"; width: 180}; \
					{value: "city"; width: 120}\
				]\
				})
			VP ADD TABLE SHEET($vp.area; "Products"; "Products"; {\
				columns: [\
					{value: "name"; caption: "Product"; width: 180}; \
					{value: "price"; width: 100; style: {hAlign: "right"}}; \
					{value: "quantity"; caption: "Qty"; width: 80; style: {hAlign: "right"}}; \
					{value: "inStock"; caption: "In Stock"; width: 100}\
				]\
				})
			VP ADD TABLE SHEET($vp.area; "Books"; "Books"; {\
				columns: [\
					{value: "title"; width: 200}; \
					{value: "author"; width: 150}; \
					{value: "price"; width: 100; style: {hAlign: "right"}}\
				]\
				})
			VP ADD TABLE SHEET($vp.area; "Scores"; "Scores"; {\
				columns: [\
					{value: "name"; width: 150}; \
					{value: "score"; width: 100; style: {hAlign: "right"}}; \
					{value: "grade"; width: 80}\
				]\
				})

			// ── VP CREATE TABLE: regular table on Sheet 1 bound to DataManager source ──
			VP SET CURRENT SHEET($vp.area; 0)
			VP CREATE TABLE(VP Cells($vp.area; 0; 0; 1; 1); "PeopleTable"; "People")

			// ── 6. Relationships: two collections with manual relationship ──
			var $departments:=[{ID: 1; name: "Engineering"}; \
				{ID: 2; name: "Marketing"}; \
				{ID: 3; name: "Sales"}]

			VP ADD DATA SOURCE($vp.area; $departments; {\
				name: "Departments"; \
				schema: {\
					columns: {\
						ID: {dataType: "number"; isPrimaryKey: True:C214}; \
						name: {dataType: "string"}\
					}\
				}\
				})

			var $staff:=[{ID: 1; firstName: "Alice"; departmentID: 1}; \
				{ID: 2; firstName: "Bob"; departmentID: 2}; \
				{ID: 3; firstName: "Charlie"; departmentID: 1}; \
				{ID: 4; firstName: "Diana"; departmentID: 3}]

			VP ADD DATA SOURCE($vp.area; $staff; {\
				name: "Staff"; \
				schema: {\
					columns: {\
						ID: {dataType: "number"; isPrimaryKey: True:C214}; \
						firstName: {dataType: "string"}; \
						departmentID: {dataType: "number"}\
					}\
				}; \
				relationships: {\
					department: {on: "Staff.departmentID = Departments.ID"}\
				}\
				})

			VP ADD TABLE SHEET($vp.area; "Departments"; "Departments"; {\
				columns: [\
					{value: "ID"; width: 60}; \
					{value: "name"; caption: "Department"; width: 200}\
				]\
				})
			VP ADD TABLE SHEET($vp.area; "Staff"; "Staff"; {\
				columns: [\
					{value: "ID"; width: 60}; \
					{value: "firstName"; caption: "First Name"; width: 150}; \
					{value: "departmentID"; caption: "Dept ID"; width: 80}\
				]\
				})
		End if 
		
		//______________________________________________________
		//mark:-ACI0105390
	: (False:C215)
		
		VP EXPORT TO BLOB($vp.area; {Formula: Null:C1517})
		
		//______________________________________________________
	: (Macintosh option down:C545)
		
		METHOD OPEN PATH:C1213("[projectForm]/TESTS/test")
		
	: (Macintosh control down:C544)
		
		$t:=File:C1566("/RESOURCES/DEV/exporte.pdf").platformPath
		$o:={formula: Formula:C1597(ALERT:C41("test export")); format: vk pdf format:K89:21}
		
		VP EXPORT DOCUMENT("ViewProArea"; $t; $o)
		
		//______________________________________________________
	: (True:C214)
		
		$o:={formula: Formula:C1597(ALERT:C41("test")); format: vk pdf format:K89:21}
		VP IMPORT FROM OBJECT("ViewProArea"; VP Export to object("ViewProArea"); $o)
		
		//______________________________________________________
	: (True:C214)
		
		$t:=File:C1566("/RESOURCES/DEV/Objects.4vp").platformPath
		$o:={formula: Formula:C1597(ALERT:C41("test"))}
		VP IMPORT DOCUMENT("ViewProArea"; $t; $o)
		
		//MARK:ACI0103752
		//______________________________________________________
	: (True:C214)
		
		$t:=File:C1566("/RESOURCES/DEV/percentage_issue.4PV").platformPath
		DOCUMENT TO BLOB:C525($t; $blb)
		$o:=VP Convert from 4D View($blb)
		VP IMPORT FROM OBJECT("ViewProArea"; $o)
		
		//______________________________________________________
	: (True:C214)
		
		$o:=VP Export to object($vp.area)
		$picture:=VP Convert to picture($o)
		WRITE PICTURE FILE:C680(Folder:C1567(fk desktop folder:K87:19).file("test.svg").platformPath; $picture; ".svg")
		SHOW ON DISK:C922(Folder:C1567(fk desktop folder:K87:19).file("test.svg").platformPath)
		
		//______________________________________________________
	: (True:C214)
		
		$value:=VP Get value($cell)  // $cell.getValue()
		$values:=VP Get values($cell)
		
		If (Shift down:C543)
			ALERT:C41("value:"+_dev_myObject($value.value)+"\nvalues: "+_dev_myObject($values.first().first()))
		End if 
		
		//______________________________________________________
	: (True:C214)  // Set current cell value as an object
		
		//$cell.setFormula("OBJECT(\"key\", \"value\")")
		
		//______________________________________________________
	: (True:C214)
		
		var $formula : Object
		$formula:=VP Get formula by name($vp.area; "toto")
		
		//______________________________________________________
	: (True:C214)  // Set current cell value as Null
		
		$cell.setValue(Null:C1517)
		
		//______________________________________________________
	: (True:C214)
		
		If (Shift down:C543)
			
			$vp.appendSheet("1")
			$vp.appendSheet("2")
			$vp.appendSheet("3")
			$vp.appendSheet("4")
			$vp.appendSheet("5")
			$vp.appendSheet("6")
			
		Else 
			
			$vp.removeSheet(2)
			
		End if 
		
		//______________________________________________________
	: (True:C214)
		
		//$vp.appendSheet()
		
		
		//$vp.insertSheet(2)
		//$vp.insertSheet(2; "INSERT")
		
		//______________________________________________________
	: (True:C214)
		
		var $sheetOption : cs:C1710.sheetOptions
		$sheetOption:=cs:C1710.sheetOptions.new($vp.area)
		
		//______________________________________________________
	: (True:C214)
		
		$range:=$vp.range(1; 15; 1; 10)
		
		$values:=[\
			["hello"]; \
			["world"]; \
			[Current date:C33]; \
			[Current time:C178]; \
			[Pi:K30:1]; \
			[MAXLONG:K35:2]; \
			[]; \
			[]; \
			["hello"]; \
			["world"]\
			]
		
		VP SET VALUES($range; $values)
		
		//______________________________________________________
	: (False:C215)  // Get column 1 values
		
		$column:=$vp.column(1)
		$values:=$column.getValues()
		
		//______________________________________________________
	: (False:C215)
		
		// $o:=vp_runFunction($vp.area; "GC.Spread.Sheets.Designer.getCommand(GC.Spread.Sheets.Designer.CommandNames.SpreadSettingCalculation)"; {})
		$o:=vp_runFunction($vp.area; "designer.getCommand(designer.CommandNames.SpreadSettingCalculation)")
		
		// "GC.Spread.Sheets.Designer.getCommand(GC.Spread.Sheets.Designer.CommandNames.SpreadSettingCalculation);"
		
		//______________________________________________________
	: (False:C215)
		
		$value:=$cell.getReference({mode: "absolute"; sheet: True:C214})
		
		//______________________________________________________
	: (False:C215)  // Set current cell value as object
		
		$cell.setValue({\
			toto: "Hello World"; \
			number: 12; \
			ob: {toto: "Hello World"; number: 24}})
		
		// On the same line
		$vp.cell($cell.ranges[0].column+1; $cell.ranges[0].row).setFormula("="+$cell.getReference()+".ob.number*2")
		
		// $o:=vp_runFunction($vp.area; "Utils.updateFormulaBar")
		
		//______________________________________________________
	: (True:C214)  // Set current cell value as text
		
		$cell.setValue("Hello World")
		
		//______________________________________________________
	: (True:C214)  // Get current cell value
		
		$value:=$cell.getValue()
		
		//______________________________________________________
End case 