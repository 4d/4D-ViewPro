var $vp : cs:C1710._vp
var $cell : cs:C1710._cell
var $column : cs:C1710._column
var $workbook : cs:C1710._workbook
var $range : cs:C1710._range
var $o : Object
var $value
var $values : Collection

$vp:=Form:C1466.vp
$cell:=$vp.getCurrentCell()
$workbook:=cs:C1710._workbook.new($vp.area)

Case of 
		
		//______________________________________________________
	: (Macintosh option down:C545)
		
		METHOD OPEN PATH:C1213("[projectForm]/TESTS/test")
		
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