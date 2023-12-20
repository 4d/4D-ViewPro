property \
allowUserDragMerge; \
allowAutoCreateHyperlink; \
allowContextMenu; \
allowCopyPasteExcelStyle; \
allowDynamicArray; \
allowExtendPasteRange; \
allowSheetReorder; \
allowUndo; \
allowUserDeselect; \
allowUserDragDrop; \
allowUserDragFill; \
allowUserEditFormula; \
allowUserResize; \
allowUserZoom; \
calcOnDemand; \
cutCopyIndicatorVisible; \
enableAccessibility; \
enableFormulaTextbox; \
highlightInvalidData; \
iterativeCalculation; \
newTabVisible; \
pasteSkipInvisibleRange; \
scrollbarMaxAlign; \
scrollbarShowMax; \
scrollByPixel; \
scrollIgnoreHidden; \
showDragDropTip; \
showDragFillSmartTag; \
showDragFillTip; \
showHorizontalScrollbar; \
showVerticalScrollbar; \
tabEditable; \
tabNavigationVisible; \
tabStripVisible; \
useTouchLayout\
 : Boolean

property \
autoFitType; \
backgroundImageLayout; \
columnResizeMode; \
copyPasteHeaderOptions; \
defaultDragFillType; \
iterativeCalculationMaximumChange; \
iterativeCalculationMaximumIterations; \
numbersFitMode; \
referenceStyle; \
resizeZeroIndicator; \
rowResizeMode; \
scrollbarAppearance; \
scrollPixel; \
showResizeTip; \
showScrollTip; \
tabStripPosition; \
tabStripRatio; \
tabStripWidth\
 : Integer

property \
backColor; \
cutCopyIndicatorBorderColor; \
grayAreaBackColor\
 : Text

property \
backgroundImage\
 : Variant

property \
customList\
 : Collection

// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Class constructor($area : Text)
	
	This:C1470.area:=$area
	
	var $o : Object
	$o:={\
		allowAutoCreateHyperlink: True:C214; \
		allowContextMenu: True:C214; \
		allowCopyPasteExcelStyle: True:C214; \
		allowDynamicArray: False:C215; \
		allowExtendPasteRange: False:C215; \
		allowSheetReorder: True:C214; \
		allowUndo: True:C214; \
		allowUserDeselect: True:C214; \
		allowUserDragDrop: True:C214; \
		allowUserDragFill: True:C214; \
		allowUserDragMerge: False:C215; \
		allowUserEditFormula: True:C214; \
		allowUserResize: True:C214; \
		allowUserZoom: True:C214; \
		autoFitType: 0; \
		backColor: "white"; \
		backgroundImage: Null:C1517; \
		backgroundImageLayout: 0; \
		calcOnDemand: False:C215; \
		columnResizeMode: 0; \
		copyPasteHeaderOptions: 3; \
		customList: []; \
		cutCopyIndicatorBorderColor: "#217346"; \
		cutCopyIndicatorVisible: True:C214; \
		defaultDragFillType: 5; \
		enableAccessibility: False:C215; \
		enableFormulaTextbox: True:C214; \
		grayAreaBackColor: Null:C1517; \
		highlightInvalidData: False:C215; \
		iterativeCalculation: True:C214; \
		iterativeCalculationMaximumChange: 0.01; \
		iterativeCalculationMaximumIterations: 1000; \
		newTabVisible: True:C214; \
		numbersFitMode: 0; \
		pasteSkipInvisibleRange: False:C215; \
		referenceStyle: 0; \
		resizeZeroIndicator: 1; \
		rowResizeMode: 0; \
		scrollByPixel: False:C215; \
		scrollIgnoreHidden: False:C215; \
		scrollPixel: 5; \
		scrollbarAppearance: 0; \
		scrollbarMaxAlign: False:C215; \
		scrollbarShowMax: True:C214; \
		showDragDropTip: True:C214; \
		showDragFillSmartTag: True:C214; \
		showDragFillTip: True:C214; \
		showHorizontalScrollbar: True:C214; \
		showResizeTip: 0; \
		showScrollTip: 0; \
		showVerticalScrollbar: True:C214; \
		tabEditable: True:C214; \
		tabNavigationVisible: True:C214; \
		tabStripPosition: 0; \
		tabStripRatio: 0.5; \
		tabStripVisible: True:C214; \
		tabStripWidth: 80; \
		useTouchLayout: False:C215\
		}
	
	This:C1470[""]:={options: $o}
	
	var $key : Text
	
	$o:=VP Get workbook options($area)
	
	For each ($key; $o)
		
		This:C1470[""].options[$key]:=$o[$key]
		
	End for each 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get options() : Object
	
	return This:C1470[""].options
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set options($o : Object)
	
	This:C1470[""].options:=$o
	
	VP SET WORKBOOK OPTIONS(This:C1470.area; $o)
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowAutoCreateHyperlink() : Boolean
	
	return This:C1470[""].options.allowAutoCreateHyperlink
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowAutoCreateHyperlink($value : Boolean)
	
	This:C1470[""].options.allowAutoCreateHyperlink:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowAutoCreateHyperlink: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowContextMenu() : Boolean
	
	return This:C1470[""].options.allowContextMenu
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowContextMenu($value : Boolean)
	
	This:C1470[""].options.allowContextMenu:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowContextMenu: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowCopyPasteExcelStyle() : Boolean
	
	return This:C1470[""].options.allowCopyPasteExcelStyle
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowCopyPasteExcelStyle($value : Boolean)
	
	This:C1470[""].options.allowCopyPasteExcelStyle:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowCopyPasteExcelStyle: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowDynamicArray() : Boolean
	
	return This:C1470[""].options.allowDynamicArray
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowDynamicArray($value : Boolean)
	
	This:C1470[""].options.allowDynamicArray:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowDynamicArray: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowExtendPasteRange() : Boolean
	
	return This:C1470[""].options.allowExtendPasteRange
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowExtendPasteRange($value : Boolean)
	
	This:C1470[""].options.allowExtendPasteRange:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowExtendPasteRange: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowSheetReorder() : Boolean
	
	return This:C1470[""].options.allowSheetReorder
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowSheetReorder($value : Boolean)
	
	This:C1470[""].options.allowSheetReorder:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowSheetReorder: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUndo() : Boolean
	
	return This:C1470[""].options.allowUndo
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUndo($value : Boolean)
	
	This:C1470[""].options.allowUndo:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUndo: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUserDeselect() : Boolean
	
	return This:C1470[""].options.allowUserDeselect
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUserDeselect($value : Boolean)
	
	This:C1470[""].options.allowUserDeselect:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUserDeselect: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUserDragDrop() : Boolean
	
	return This:C1470[""].options.allowUserDragDrop
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUserDragDrop($value : Boolean)
	
	This:C1470[""].options.allowUserDragDrop:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUserDragDrop: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUserDragFill() : Boolean
	
	return This:C1470[""].options.allowUserDragFill
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUserDragFill($value : Boolean)
	
	This:C1470[""].options.allowUserDragFill:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUserDragFill: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUserDragMerge() : Boolean
	
	return This:C1470[""].options.allowUserDragMerge
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUserDragMerge($value : Boolean)
	
	This:C1470[""].options.allowUserDragMerge:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUserDragMerge: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUserEditFormula() : Boolean
	
	return This:C1470[""].options.allowUserEditFormula
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUserEditFormula($value : Boolean)
	
	This:C1470[""].options.allowUserEditFormula:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUserEditFormula: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUserResize() : Boolean
	
	return This:C1470[""].options.allowUserResize
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUserResize($value : Boolean)
	
	This:C1470[""].options.allowUserResize:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUserResize: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get allowUserZoom() : Boolean
	
	return This:C1470[""].options.allowUserZoom
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set allowUserZoom($value : Boolean)
	
	This:C1470[""].options.allowUserZoom:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {allowUserZoom: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get autoFitType() : Integer
	
	return This:C1470[""].options.autoFitType
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set autoFitType($value : Integer)
	
	This:C1470[""].options.autoFitType:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {autoFitType: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get backColor() : Text
	
	return This:C1470[""].options.backColor
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set backColor($value : Text)
	
	This:C1470[""].options.backColor:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {backColor: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get backgroundImage() : Variant
	
	return This:C1470[""].options.backgroundImage
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set backgroundImage($value : Variant)
	
	This:C1470[""].options.backgroundImage:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {backgroundImage: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get backgroundImageLayout() : Integer
	
	return This:C1470[""].options.backgroundImageLayout
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set backgroundImageLayout($value : Integer)
	
	This:C1470[""].options.backgroundImageLayout:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {backgroundImageLayout: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get calcOnDemand() : Boolean
	
	return This:C1470[""].options.calcOnDemand
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set calcOnDemand($value : Boolean)
	
	This:C1470[""].options.calcOnDemand:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {calcOnDemand: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get columnResizeMode() : Integer
	
	return This:C1470[""].options.columnResizeMode
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set columnResizeMode($value : Integer)
	
	This:C1470[""].options.columnResizeMode:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {columnResizeMode: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get copyPasteHeaderOptions() : Integer
	
	return This:C1470[""].options.copyPasteHeaderOptions
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set copyPasteHeaderOptions($value : Integer)
	
	This:C1470[""].options.copyPasteHeaderOptions:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {copyPasteHeaderOptions: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get customList() : Collection
	
	return This:C1470[""].options.customList
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set customList($value : Collection)
	
	This:C1470[""].options.customList:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {customList: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get cutCopyIndicatorBorderColor() : Text
	
	return This:C1470[""].options.cutCopyIndicatorBorderColor
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set cutCopyIndicatorBorderColor($value : Text)
	
	This:C1470[""].options.cutCopyIndicatorBorderColor:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {cutCopyIndicatorBorderColor: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get cutCopyIndicatorVisible() : Boolean
	
	return This:C1470[""].options.cutCopyIndicatorVisible
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set cutCopyIndicatorVisible($value : Boolean)
	
	This:C1470[""].options.cutCopyIndicatorVisible:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {cutCopyIndicatorVisible: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get defaultDragFillType() : Integer
	
	return This:C1470[""].options.defaultDragFillType
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set defaultDragFillType($value : Integer)
	
	This:C1470[""].options.defaultDragFillType:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {defaultDragFillType: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get enableAccessibility() : Boolean
	
	return This:C1470[""].options.enableAccessibility
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set enableAccessibility($value : Boolean)
	
	This:C1470[""].options.enableAccessibility:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {enableAccessibility: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get enableFormulaTextbox() : Boolean
	
	return This:C1470[""].options.enableFormulaTextbox
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set enableFormulaTextbox($value : Boolean)
	
	This:C1470[""].options.enableFormulaTextbox:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {enableFormulaTextbox: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get grayAreaBackColor() : Variant
	
	return This:C1470[""].options.grayAreaBackColor
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set grayAreaBackColor($value : Variant)
	
	This:C1470[""].options.grayAreaBackColor:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {grayAreaBackColor: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get highlightInvalidData() : Boolean
	
	return This:C1470[""].options.highlightInvalidData
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set highlightInvalidData($value : Boolean)
	
	This:C1470[""].options.highlightInvalidData:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {highlightInvalidData: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get iterativeCalculation() : Boolean
	
	return This:C1470[""].options.iterativeCalculation
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set iterativeCalculation($value : Boolean)
	
	This:C1470[""].options.iterativeCalculation:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {iterativeCalculation: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get iterativeCalculationMaximumChange() : Real
	
	return This:C1470[""].options.iterativeCalculationMaximumChange
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set iterativeCalculationMaximumChange($value : Real)
	
	This:C1470[""].options.iterativeCalculationMaximumChange:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {iterativeCalculationMaximumChange: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get iterativeCalculationMaximumIterations() : Integer
	
	return This:C1470[""].options.iterativeCalculationMaximumIterations
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set iterativeCalculationMaximumIterations($value : Integer)
	
	This:C1470[""].options.iterativeCalculationMaximumIterations:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {iterativeCalculationMaximumIterations: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get newTabVisible() : Boolean
	
	return This:C1470[""].options.newTabVisible
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set newTabVisible($value : Boolean)
	
	This:C1470[""].options.newTabVisible:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {newTabVisible: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get numbersFitMode() : Integer
	
	return This:C1470[""].options.numbersFitMode
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set numbersFitMode($value : Integer)
	
	This:C1470[""].options.numbersFitMode:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {numbersFitMode: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get pasteSkipInvisibleRange() : Boolean
	
	return This:C1470[""].options.pasteSkipInvisibleRange
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set pasteSkipInvisibleRange($value : Boolean)
	
	This:C1470[""].options.pasteSkipInvisibleRange:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {pasteSkipInvisibleRange: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get referenceStyle() : Integer
	
	return This:C1470[""].options.referenceStyle
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set referenceStyle($value : Integer)
	
	This:C1470[""].options.referenceStyle:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {referenceStyle: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get resizeZeroIndicator() : Integer
	
	return This:C1470[""].options.resizeZeroIndicator
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set resizeZeroIndicator($value : Integer)
	
	This:C1470[""].options.resizeZeroIndicator:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {resizeZeroIndicator: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get rowResizeMode() : Integer
	
	return This:C1470[""].options.rowResizeMode
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set rowResizeMode($value : Integer)
	
	This:C1470[""].options.rowResizeMode:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {rowResizeMode: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get scrollByPixel() : Boolean
	
	return This:C1470[""].options.scrollByPixel
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set scrollByPixel($value : Boolean)
	
	This:C1470[""].options.scrollByPixel:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {scrollByPixel: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get scrollIgnoreHidden() : Boolean
	
	return This:C1470[""].options.scrollIgnoreHidden
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set scrollIgnoreHidden($value : Boolean)
	
	This:C1470[""].options.scrollIgnoreHidden:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {scrollIgnoreHidden: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get scrollPixel() : Integer
	
	return This:C1470[""].options.scrollPixel
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set scrollPixel($value : Integer)
	
	This:C1470[""].options.scrollPixel:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {scrollPixel: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get scrollbarAppearance() : Integer
	
	return This:C1470[""].options.scrollbarAppearance
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set scrollbarAppearance($value : Integer)
	
	This:C1470[""].options.scrollbarAppearance:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {scrollbarAppearance: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get scrollbarMaxAlign() : Boolean
	
	return This:C1470[""].options.scrollbarMaxAlign
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set scrollbarMaxAlign($value : Boolean)
	
	This:C1470[""].options.scrollbarMaxAlign:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {scrollbarMaxAlign: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get scrollbarShowMax() : Boolean
	
	return This:C1470[""].options.scrollbarShowMax
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set scrollbarShowMax($value : Boolean)
	
	This:C1470[""].options.scrollbarShowMax:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {scrollbarShowMax: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get showDragDropTip() : Boolean
	
	return This:C1470[""].options.showDragDropTip
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set showDragDropTip($value : Boolean)
	
	This:C1470[""].options.showDragDropTip:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {showDragDropTip: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get showDragFillSmartTag() : Boolean
	
	return This:C1470[""].options.showDragFillSmartTag
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set showDragFillSmartTag($value : Boolean)
	
	This:C1470[""].options.showDragFillSmartTag:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {showDragFillSmartTag: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get showDragFillTip() : Boolean
	
	return This:C1470[""].options.showDragFillTip
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set showDragFillTip($value : Boolean)
	
	This:C1470[""].options.showDragFillTip:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {showDragFillTip: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get showHorizontalScrollbar() : Boolean
	
	return This:C1470[""].options.showHorizontalScrollbar
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set showHorizontalScrollbar($value : Boolean)
	
	This:C1470[""].options.showHorizontalScrollbar:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {showHorizontalScrollbar: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get showResizeTip() : Integer
	
	return This:C1470[""].options.showResizeTip
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set showResizeTip($value : Integer)
	
	This:C1470[""].options.showResizeTip:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {showResizeTip: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get showScrollTip() : Integer
	
	return This:C1470[""].options.showScrollTip
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set showScrollTip($value : Integer)
	
	This:C1470[""].options.showScrollTip:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {showScrollTip: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get showVerticalScrollbar() : Boolean
	
	return This:C1470[""].options.showVerticalScrollbar
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set showVerticalScrollbar($value : Boolean)
	
	This:C1470[""].options.showVerticalScrollbar:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {showVerticalScrollbar: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get tabEditable() : Boolean
	
	return This:C1470[""].options.tabEditable
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set tabEditable($value : Boolean)
	
	This:C1470[""].options.tabEditable:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {tabEditable: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get tabNavigationVisible() : Boolean
	
	return This:C1470[""].options.tabNavigationVisible
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set tabNavigationVisible($value : Boolean)
	
	This:C1470[""].options.tabNavigationVisible:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {tabNavigationVisible: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get tabStripPosition() : Integer
	
	return This:C1470[""].options.tabStripPosition
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set tabStripPosition($value : Integer)
	
	This:C1470[""].options.tabStripPosition:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {tabStripPosition: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get tabStripRatio() : Real
	
	return This:C1470[""].options.tabStripRatio
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set tabStripRatio($value : Real)
	
	This:C1470[""].options.tabStripRatio:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {tabStripRatio: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get tabStripVisible() : Boolean
	
	return This:C1470[""].options.tabStripVisible
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set tabStripVisible($value : Boolean)
	
	This:C1470[""].options.tabStripVisible:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {tabStripVisible: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get tabStripWidth() : Integer
	
	return This:C1470[""].options.tabStripWidth
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set tabStripWidth($value : Integer)
	
	This:C1470[""].options.tabStripWidth:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {tabStripWidth: $value})
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function get useTouchLayout() : Boolean
	
	return This:C1470[""].options.useTouchLayout
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function set useTouchLayout($value : Boolean)
	
	This:C1470[""].options.useTouchLayout:=$value
	VP SET WORKBOOK OPTIONS(This:C1470.area; {useTouchLayout: $value})
	