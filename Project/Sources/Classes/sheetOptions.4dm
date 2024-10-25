property \
allowCellOverflow; \
rowHeaderVisible; \
colHeaderVisible; \
isProtected\
 : Boolean

property \
clipBoardOptions; \
rowHeaderAutoText; \
colHeaderAutoText; \
rowHeaderAutoTextIndex; \
colHeaderAutoTextIndex; \
visible; \
zoom\
 : Integer

property \
sheetTabColor; \
frozenlineColor; \
selectionBackColor; \
selectionBorderColor\
 : Text

property \
gridline; \
sheetAreaOffset; \
protectionOptions\
 : Object

property area : Text
property index : Integer

// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Class constructor($area : Text; $index : Integer)
	
	This:C1470.area:=$area
	This:C1470.index:=Count parameters:C259>=2 ? $index : -1
	
	var $o : Object
	$o:={\
		allowCellOverflow: True:C214; \
		clipBoardOptions: 0; \
		colHeaderAutoText: 2; \
		colHeaderAutoTextIndex: -1; \
		colHeaderVisible: True:C214; \
		frozenlineColor: "Black"; \
		gridline: {color: "rgb(212. 212, 212)"; showVerticalGridline: True:C214; showHorizontalGridline: True:C214}; \
		isProtected: False:C215; \
		protectionOptions: {}; \
		rowHeaderAutoText: 1; \
		rowHeaderAutoTextIndex: -1; \
		rowHeaderVisible: True:C214; \
		sheetAreaOffset: {left: 0; top: 0}; \
		visible: 1; \
		zoom: 1\
		}
	
	This:C1470[""]:={options: $o}
	
	var $key : Text
	
	$o:=VP Get sheet options(This:C1470.area; This:C1470.index)
	
	For each ($key; $o)
		
		This:C1470[""].options[$key]:=$o[$key]
		
	End for each 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get options() : Object
	
	return This:C1470[""].options
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set options($o : Object)
	
	This:C1470[""].options:=$o
	
	VP SET SHEET OPTIONS(This:C1470.area; $o)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowCellOverflow() : Boolean
	
	return This:C1470[""].options.allowCellOverflow
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowCellOverflow($value : Boolean)
	
	This:C1470[""].options.allowCellOverflow:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {allowCellOverflow: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get clipBoardOptions() : Integer
	
	return This:C1470[""].options.clipBoardOptions
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set clipBoardOptions($value : Integer)
	
	This:C1470[""].options.clipBoardOptions:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {clipBoardOptions: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get colHeaderAutoText() : Integer
	
	return This:C1470[""].options.colHeaderAutoText
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set colHeaderAutoText($value : Integer)
	
	This:C1470[""].options.colHeaderAutoText:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {colHeaderAutoText: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get colHeaderAutoTextIndex() : Integer
	
	return This:C1470[""].options.colHeaderAutoTextIndex
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set colHeaderAutoTextIndex($value : Integer)
	
	This:C1470[""].options.colHeaderAutoTextIndex:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {colHeaderAutoTextIndex: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get colHeaderVisible() : Boolean
	
	return This:C1470[""].options.colHeaderVisible
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set colHeaderVisible($value : Boolean)
	
	This:C1470[""].options.colHeaderVisible:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {colHeaderVisible: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get frozenlineColor() : Text
	
	return This:C1470[""].options.frozenlineColor
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set frozenlineColor($value : Text)
	
	This:C1470[""].options.frozenlineColor:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {frozenlineColor: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
	//TODO: Class gridline
Function get gridline() : Object
	
	return This:C1470[""].options.gridline
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set gridline($value : Object)
	
	This:C1470[""].options.gridline:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {gridline: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get isProtected() : Boolean
	
	return This:C1470[""].options.isProtected
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set isProtected($value : Boolean)
	
	This:C1470[""].options.isProtected:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {isProtected: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
	//TODO: Class protectionOptions
Function get protectionOptions() : Object
	
	return This:C1470[""].options.protectionOptions
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set protectionOptions($value : Object)
	
	This:C1470[""].options.protectionOptions:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {protectionOptions: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get rowHeaderAutoText() : Integer
	
	return This:C1470[""].options.rowHeaderAutoText
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set rowHeaderAutoText($value : Integer)
	
	This:C1470[""].options.rowHeaderAutoText:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {rowHeaderAutoText: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get rowHeaderAutoTextIndex() : Integer
	
	return This:C1470[""].options.rowHeaderAutoTextIndex
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set rowHeaderAutoTextIndex($value : Integer)
	
	This:C1470[""].options.rowHeaderAutoTextIndex:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {rowHeaderAutoTextIndex: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get rowHeaderVisible() : Boolean
	
	return This:C1470[""].options.rowHeaderVisible
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set rowHeaderVisible($value : Boolean)
	
	This:C1470[""].options.rowHeaderVisible:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {rowHeaderVisible: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
	//TODO: Class sheetAreaOffset
Function get sheetAreaOffset() : Object
	
	return This:C1470[""].options.sheetAreaOffset
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set sheetAreaOffset($value : Object)
	
	This:C1470[""].options.sheetAreaOffset:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {sheetAreaOffset: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get visible() : Integer
	
	return This:C1470[""].options.visible
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set visible($value : Integer)
	
	This:C1470[""].options.visible:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {visible: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get zoom() : Integer
	
	return This:C1470[""].options.zoom
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set zoom($value : Integer)
	
	This:C1470[""].options.zoom:=$value
	VP SET SHEET OPTIONS(This:C1470.area; {zoom: $value})