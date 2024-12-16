//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
/*
viewPro := ***VP Convert from 4D View*** ( view )
-> view (BLOB)
<- viewPro (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : VP Convert from 4D View
// Database: Convert4DView
// ID[B649331C6D8A40BFB3FD5CFDA614ED4F]
// Created #4-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Convert a 4D View document to 4D View Pro document
// ----------------------------------------------------
// Declarations
#DECLARE($Blb_view : Blob)->$Obj_viewPro : Object

var $Lon_i : Integer
var $Obj_columns; $Obj_d4; $Obj_dataTable; $Obj_rows; $Obj_style : Object
var $Coll_namedStyles; $stylesheets : Collection

vp_initStorage_no_licence_check

var $nbParameters:=Count parameters:C259

err_TRY

If (Check_parameters_count(1; $nbParameters))
	
End if 

If (BLOB size:C605($Blb_view)=0)
	
	// Error Load 4D View document
	err_THROW({component: "MISC"; code: 10600})
	
Else 
	
	$Obj_d4:=Load 4D View document:C1528($Blb_view)
	
	If (OB Is defined:C1231($obj_d4; "error"))
		
		err_THROW({code: 20})  // 4D View document is corrupted and cannot be converted
		
	Else 
		
		convert_smartResize($Obj_d4)
		convert_apply_styleRanges($Obj_d4)
		
		// Releasing memory the large objects that are no longer useful
		SET BLOB SIZE:C606($Blb_view; 0)
		
		// Initialize default values
		$Obj_d4._default:=New object:C1471
		
		//compatibility SJS 11 : the sheet name must be same as the object !
		//$Obj_d4._default.sheetName:=Get localized string("Convert_sheet")
		$Obj_d4._default.sheetName:="Sheet1"
		
		$Obj_d4._default.sizeConversionFactor:=0.06666666666667
		$Obj_d4._default.zoomFactor:=1
		
		// CREATE THE VIEWPRO OBJECT ====================================================== [
		$Obj_viewPro:=New object:C1471(\
			"version"; Storage:C1525.ViewPro.version; \
			"dateCreation"; Replace string:C233(String:C10(!1958-08-08!; ISO date GMT:K1:10; Time:C179(Num:C11($Obj_d4.creationTime))); "1958-08-08"; $Obj_d4.creationDate); \
			"dateModified"; Replace string:C233(String:C10(!1958-08-08!; ISO date GMT:K1:10; Time:C179(Num:C11($Obj_d4.modificationTime))); "1958-08-08"; $Obj_d4.modificationDate))
		
		// All others document informations are stored into the meta tag [
		$Obj_viewPro.meta:=New object:C1471
		
		If (Length:C16($Obj_d4.title)>0)
			
			$Obj_viewPro.meta.title:=$Obj_d4.title
			
		End if 
		
		If (Length:C16($Obj_d4.author)>0)
			
			$Obj_viewPro.meta.author:=$Obj_d4.author
			
		End if 
		
		If (Length:C16($Obj_d4.subject)>0)
			
			$Obj_viewPro.meta.subject:=$Obj_d4.subject
			
		End if 
		
		If (Length:C16($Obj_d4.company)>0)
			
			$Obj_viewPro.meta.company:=$Obj_d4.company
			
		End if 
		
		If (Length:C16($Obj_d4.note)>0)
			
			$Obj_viewPro.meta.note:=$Obj_d4.note
			
		End if 
		
		If (OB Is empty:C1297($Obj_viewPro.meta))
			
			OB REMOVE:C1226($Obj_viewPro; "meta")
			
		End if 
		//]
		
		// ================================================================================ ]
		
		// CREATE THE SPREADJS OBJECT ===================================================== [
		$Obj_viewPro.spreadJS:=New object:C1471
		$Obj_viewPro.spreadJS.version:=Storage:C1525.ViewPro.spreadJSVersion
		$Obj_viewPro.spreadJS.tabStripVisible:=False:C215  // Default is true
		//$Obj_viewPro.spreadJS.sheetCount:=1  // Default is 1
		//$Obj_viewPro.spreadJS.activeSheetIndex:=1  // Default is 1
		$Obj_viewPro.spreadJS.AutoFitType:=1  // cell:0 (default), cellWithHeader:1
		
		// STYLE-SHEETS ================================================================== [
		// Keep the default style definition in a temporary key
		$Obj_d4._defaultStyle:=convert_defaultStyle($Obj_d4)
		
		// ================================================================================
		// =            #TO_DO : Detect style for even and odd to create 2 styles         =
		// ================================================================================
		
		$Coll_namedStyles:=New collection:C1472
		$stylesheets:=convert_styleSheets($Obj_d4)
		// Append headers' style
		$Coll_namedStyles[$Coll_namedStyles.length]:=convert_headerStyles($Obj_d4)
		
		// Append default style [
		$Obj_style:=OB Copy:C1225($Obj_d4._defaultStyle)
		
		ARRAY TEXT:C222($tTxt_keys; 0x0000)
		
		OB GET PROPERTY NAMES:C1232($Obj_style; $tTxt_keys)
		
		For ($Lon_i; 1; Size of array:C274($tTxt_keys); 1)
			
			If (Position:C15("_"; $tTxt_keys{$Lon_i})=1)
				
				OB REMOVE:C1226($Obj_style; $tTxt_keys{$Lon_i})
				
			End if 
		End for 
		
		$Coll_namedStyles[$Coll_namedStyles.length]:=$Obj_style
		//]
		
		// remove empty styles
		For ($Lon_i; $Coll_namedStyles.length-1; 0; -1)
			If ($Coll_namedStyles[$Lon_i]=Null:C1517)
				$Coll_namedStyles.remove($Lon_i)
			End if 
		End for 
		
		
		For ($Lon_i; $stylesheets.length-1; 0; -1)
			If ($stylesheets[$Lon_i]=Null:C1517)
				$stylesheets.remove($Lon_i)
			End if 
		End for 
		
		$Obj_viewPro.spreadJS.namedStyles:=$Coll_namedStyles
		
		// ================================================================================ ]
		
		// CREATE THE SHEETS OBJECT ======================================================= [
		$Obj_viewPro.spreadJS.sheets:=New object:C1471
		
		// ================================================================================ ]
		
		// CREATE THE SHEET ONE OBJECT ==================================================== [
		$Obj_viewPro.spreadJS.sheets.Sheet1:=New object:C1471
		$Obj_viewPro.spreadJS.sheets.Sheet1.name:=$Obj_d4._default.sheetName
		$Obj_viewPro.spreadJS.sheets.Sheet1.theme:="Office"
		$Obj_viewPro.spreadJS.sheets.Sheet1.allowCellOverflow:=True:C214  // Allow text to overflow into adjacent cells
		$Obj_viewPro.spreadJS.sheets.Sheet1.allowUserEditFormula:=True:C214  // Allow users to enter formulas in cells
		$Obj_viewPro.spreadJS.sheets.Sheet1.allowUserDragDrop:=True:C214  // Allow the user to drag and drop cells
		
		// Set the number of columns and rows
		$Obj_viewPro.spreadJS.sheets.Sheet1.columnCount:=$Obj_d4.columnCount
		$Obj_viewPro.spreadJS.sheets.Sheet1.rowCount:=$Obj_d4.rowCount
		
		// Defaults Field - Indicates the default row height and column width of the sheet.
		$Obj_viewPro.spreadJS.sheets.Sheet1.defaults:=New object:C1471
		$Obj_viewPro.spreadJS.sheets.Sheet1.defaults.rowHeight:=Round:C94($Obj_d4.rowHeight*$Obj_d4._default.sizeConversionFactor; 0)
		$Obj_viewPro.spreadJS.sheets.Sheet1.defaults.colWidth:=Round:C94($Obj_d4.columnWidth*$Obj_d4._default.sizeConversionFactor; 0)
		$Obj_viewPro.spreadJS.sheets.Sheet1.defaults.rowHeaderColWidth:=Round:C94($Obj_d4.rowHeaderWidth*$Obj_d4._default.sizeConversionFactor; 0)
		$Obj_viewPro.spreadJS.sheets.Sheet1.defaults.colHeaderRowHeight:=Round:C94($Obj_d4.columnHeaderHeight*$Obj_d4._default.sizeConversionFactor; 0)
		
		// Headers {
		If (Not:C34($Obj_d4.showRowHeaders))  // Default is true
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.rowHeaderVisible:=$Obj_d4.showRowHeaders
			
		End if 
		
		If (Not:C34($Obj_d4.showColumnHeaders))  // Default is true
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.colHeaderVisible:=$Obj_d4.showColumnHeaders
			
		End if 
		//}
		
		// Scrollbars {
		If (Not:C34($Obj_d4.showHScrollbar))  // Default is true
			
			$Obj_viewPro.spreadJS.showHorizontalScrollbar:=$Obj_d4.showHScrollbar
			
		End if 
		
		If (Not:C34($Obj_d4.showVScrollbar))  // Default is true
			
			$Obj_viewPro.spreadJS.showVerticalScrollbar:=$Obj_d4.showVScrollbar
			
		End if 
		//}
		
		// Selection {
		If ($Obj_d4.selectedRanges.length>0)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.selections:=convert_selectedRanges($Obj_d4)
			
			If ($Obj_d4.currentCellRow>1)  // Default is 0
				
				$Obj_viewPro.spreadJS.sheets.Sheet1.activeRow:=$Obj_d4.currentCellRow-1
				
			End if 
			
			If ($Obj_d4.currentCellColumn>1)  // Default is 0
				
				$Obj_viewPro.spreadJS.sheets.Sheet1.activeCol:=$Obj_d4.currentCellColumn-1
				
			End if 
			
		Else 
			
			// No selection
			$Obj_viewPro.spreadJS.sheets.Sheet1.selections:=New object:C1471(\
				"length"; 0)
			
		End if 
		//}
		
		// Gridlines {
		$Obj_viewPro.spreadJS.sheets.Sheet1.gridline:=Choose:C955($Obj_d4.showGrid; New object:C1471(\
			"showHorizontalGridline"; $Obj_d4.hGridVisible; \
			"showVerticalGridline"; $Obj_d4.vGridVisible); \
			New object:C1471("showHorizontalGridline"; False:C215; "showVerticalGridline"; False:C215))
		
		$Obj_viewPro.spreadJS.sheets.Sheet1.gridline.color:=convert_color($Obj_d4.hGridColor; False:C215)
		//}
		
		// ================================================================================ ]
		
		// Columns ======================================================================== [
		$Obj_columns:=convert_columns($Obj_d4.columns)
		
		If ($Obj_columns.columns.length>0)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.columns:=$Obj_columns.columns
			
		End if 
		
		$Obj_viewPro.spreadJS.sheets.Sheet1.colHeaderData:=New object:C1471
		
		If ($Obj_columns.dataTable#Null:C1517)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.colHeaderData.dataTable:=$Obj_columns.dataTable
			
		End if 
		
		$Obj_viewPro.spreadJS.sheets.Sheet1.colHeaderData.defaultDataNode:=New object:C1471(\
			"style"; "headers")
		
		// ================================================================================ ]
		
		// Rows =========================================================================== [
		$Obj_rows:=convert_rows($Obj_d4.rows)
		
		If ($Obj_rows.rows.length>0)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.rows:=$Obj_rows.rows
			
		End if 
		
		$Obj_viewPro.spreadJS.sheets.Sheet1.rowHeaderData:=New object:C1471
		
		If ($Obj_rows.dataTable#Null:C1517)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.rowHeaderData.dataTable:=$Obj_rows.dataTable
			
		End if 
		
		$Obj_viewPro.spreadJS.sheets.Sheet1.rowHeaderData.defaultDataNode:=New object:C1471(\
			"style"; "headers")
		
		// ================================================================================ ]
		
		// Data =========================================================================== [
		// With default style sheet
		$Obj_viewPro.spreadJS.sheets.Sheet1.data:=New object:C1471(\
			"defaultDataNode"; New object:C1471("style"; \
			"cells"))
		
		$Obj_dataTable:=convert_datatable($Obj_d4)
		
		$Obj_viewPro.spreadJS.sheets.Sheet1.data.dataTable:=$Obj_dataTable
		
		If (Bool:C1537($Obj_d4.isProtected))
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.isProtected:=True:C214
			
		End if 
		
		$Obj_viewPro.spreadJS.sheets.Sheet1.namedStyles:=$stylesheets
		
		// Apply the style sets if any
		//$Coll_namedStyles:=convert_styleRanges ($Obj_d4;$Obj_viewPro)
		
		If ($Coll_namedStyles.length>0)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.namedStyles:=$stylesheets.concat($Coll_namedStyles)
			
		End if 
		
		// Apply borders if any
		convert_BORDERS($Obj_d4; $Obj_viewPro.spreadJS.sheets.Sheet1.data)
		
		If (OB Is empty:C1297($Obj_dataTable))
			
			OB REMOVE:C1226($Obj_viewPro.spreadJS.sheets.Sheet1.data; "dataTable")
			
		End if 
		
		// ================================================================================== ]
		
		// Named cells
		If ($Obj_d4.cellNames.length>0)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.names:=convert_cellNames($Obj_d4)
			
		End if 
		
		If ($Obj_d4.zoom=Null:C1517)
			$obj_d4.zoom:=100
		End if 
		
		// Zoom
		$Obj_d4.zoom:=$Obj_d4.zoom*$Obj_d4._default.zoomFactor
		
		Case of 
				
				//______________________________________________________
			: ($Obj_d4.zoom=100)
				
				// NOTHING MORE TO DO - Default is 1.0
				
				//______________________________________________________
			: ($Obj_d4.zoom<25)
				
				$Obj_viewPro.spreadJS.sheets.Sheet1.zoomFactor:=0.25
				
				//______________________________________________________
			: ($Obj_d4.zoom>400)
				
				$Obj_viewPro.spreadJS.sheets.Sheet1.zoomFactor:=4
				
				//______________________________________________________
			Else 
				
				$Obj_viewPro.spreadJS.sheets.Sheet1.zoomFactor:=Round:C94($Obj_d4.zoom/100; 2)
				
				//______________________________________________________
		End case 
		
		If ($Obj_d4.pictures.length>0)
			
			$Obj_viewPro.spreadJS.sheets.Sheet1.floatingObjects:=convert_pictures($Obj_d4.pictures; $Obj_viewPro)
			
		End if 
		
		If ($Obj_d4.printSettings#Null:C1517)
			
			// not working
			$Obj_viewPro.spreadJS.sheets.Sheet1.printInfo:=convert_printSettings($Obj_d4)
			
		End if 
	End if 
End if 

err_FINALLY

