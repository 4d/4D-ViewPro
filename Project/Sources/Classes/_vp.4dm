property area : Text
property _formats : Collection
property wookbook : cs:C1710._workbook

Class constructor($area : Text)
	
	This:C1470.inited:=False:C215
	This:C1470.area:=$area
	
	//This.wookbook:=cs._workbook.new(This.area)
	
	This:C1470._formats:=[\
		{extension: ".4vp"; import: True:C214}; \
		{extension: ".xlsx"; import: True:C214}; \
		{extension: ".pdf"; import: False:C215}; \
		{extension: ".csv"; import: True:C214}; \
		{extension: ".txt"; import: True:C214}; \
		{extension: ".sjs"; import: True:C214}\
		]
	
	This:C1470.inited:=True:C214
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function cell($column : Integer; $row : Integer; $sheet : Integer) : cs:C1710._cell
	
	If (Count parameters:C259>=3)
		
		return cs:C1710._cell.new(This:C1470.area; $column; $row; $sheet)
		
	Else 
		
		return cs:C1710._cell.new(This:C1470.area; $column; $row)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function column($column : Integer; $columCount : Integer; $sheet : Integer) : cs:C1710._column
	
	If (Count parameters:C259>=3)
		
		return cs:C1710._column.new(This:C1470.area; $column; $columCount; $sheet)
		
	Else 
		
		return cs:C1710._column.new(This:C1470.area; $column; $columCount)
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function range($column : Integer; $row : Integer; $columCount : Integer; $rowCount : Integer; $sheet : Integer) : cs:C1710._range
	
	If (Count parameters:C259>=4)
		
		return cs:C1710._range.new(This:C1470.area; $column; $row; $columCount; $rowCount; $sheet)
		
	Else 
		
		return cs:C1710._range.new(This:C1470.area; $column; $row; $columCount; $rowCount)
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get exportFormats() : Collection
	
	If (This:C1470.inited)
		
		return This:C1470._formats.extract("extension")
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get importFormats() : Collection
	
	If (This:C1470.inited)
		
		return This:C1470._formats.query("import = :1"; True:C214).extract("extension")
		
	End if 
	
	//MARK:-[Document]
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function save($tgt : Object) : Boolean
	
	var $name : Text
	
	Case of 
			
			//______________________________________________________
		: (OB Instance of:C1731($tgt; 4D:C1709.File))
			
			DOCUMENT:=$tgt.platformPath
			
			//______________________________________________________
		: (OB Instance of:C1731($tgt; 4D:C1709.Folder))
			
			$name:=Select document:C905($tgt.platformPath; This:C1470.exportFormats.join(";"); "Save as:"; Use sheet window:K24:11+File name entry:K24:17)
			
			If (Not:C34(Bool:C1537(OK)))
				
				return 
				
			End if 
			
			//______________________________________________________
		Else 
			
			$name:=Select document:C905(8858; This:C1470.exportFormats.join(";"); "Save as:"; Use sheet window:K24:11+File name entry:K24:17)
			
			If (Not:C34(Bool:C1537(OK)))
				
				return 
				
			End if 
			
			//______________________________________________________
	End case 
	
	VP EXPORT DOCUMENT(This:C1470.area; DOCUMENT)
	
	return True:C214
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function load($src : Object; $options : Object) : Boolean
	
	var $name : Text
	
	Case of 
			
			//______________________________________________________
		: (OB Instance of:C1731($src; 4D:C1709.File))
			
			DOCUMENT:=$src.platformPath
			
			//______________________________________________________
		: (OB Instance of:C1731($src; 4D:C1709.Folder))
			
			$name:=Select document:C905($src.platformPath; This:C1470.importFormats.join(";"); "Open:"; Use sheet window:K24:11)
			
			If (Not:C34(Bool:C1537(OK)))
				
				return 
				
			End if 
			
			//______________________________________________________
		Else 
			
			$name:=Select document:C905(8858; This:C1470.importFormats.join(";"); "Open:"; Use sheet window:K24:11)
			
			If (Not:C34(Bool:C1537(OK)))
				
				return 
				
			End if 
			
			//______________________________________________________
	End case 
	
	VP IMPORT DOCUMENT(This:C1470.area; DOCUMENT; $options)
	
	return True:C214
	
	//MARK:-[Sheet]
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getCurrentSheetIndex() : Integer
	
	return VP Get current sheet(This:C1470.area)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getCurrentSheetName() : Text
	
	return VP Get sheet name(This:C1470.area)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getSheetCount() : Integer
	
	return VP Get sheet count(This:C1470.area)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getCurrentSheet() : Object
	
	return {\
		index: This:C1470.sheet; \
		name: This:C1470.sheetName\
		}
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getSheetName($index : Integer) : Text
	
	return VP Get sheet name(This:C1470.area; $index)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getSheetOptions($index : Integer) : Text
	
	return VP Get sheet name(This:C1470.area; $index)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function addSheet($index : Integer; $name : Text)
	
	VP ADD SHEET(This:C1470.area; Count parameters:C259>=1 ? $index : 9999; $name)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function appendSheet($name : Text)
	
	This:C1470.addSheet(9999; $name)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function insertSheet($index : Integer; $name : Text)
	
	This:C1470.addSheet($index; $name)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function removeSheet($index : Integer)
	
	$index:=Count parameters:C259>=1 ? $index : -1
	VP REMOVE SHEET(This:C1470.area; $index)
	
	//MARK:-[Cell]
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getCurrentCell() : cs:C1710._cell
	
	return VP Get active cell(This:C1470.area)
	
	//MARK:-[Utilities]
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function showInspector()
	
	WA OPEN WEB INSPECTOR:C1736(*; This:C1470.area)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setCustomFunctions($functions : Object) : cs:C1710._vp
	
	VP SET CUSTOM FUNCTIONS(This:C1470.area; $functions)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function recomputeFormulas() : cs:C1710._vp
	
	VP RECOMPUTE FORMULAS(This:C1470.area)
	
	return This:C1470
	