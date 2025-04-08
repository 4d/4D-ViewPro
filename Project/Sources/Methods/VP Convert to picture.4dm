//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
#DECLARE($vpObject : Object; $cells : Object)->$result : Picture

err_TRY

// MARK:- Declaration
ARRAY LONGINT:C221($colPos; 0)
ARRAY LONGINT:C221($rowPos; 0)

var $sheets; $table; $cell; $style : Object
var $lineObj; $obj; $defaultStyle : Object
var $namedStyle; $workbook; $parsedStyle; $bcObj : Object
var $strPart : Object
var $svgSource; $svgRef; $elemRef : Text
var $shrinkStr; $defaultFontSize; $fontSize; $valueStr : Text

var $textWidth; $i; $index; $indexColWidth; $indexRowHeight; $rowCount; $colCount; $maxSvgWidth; $maxSvgHeight : Integer
var $iterX; $iterY; $svgHeight; $svgWidth; $x1; $x2; $y1; $y2; $height; $width : Integer
var $defaultColWidth; $defaultRowHeight; $initialColWidth; $initialRowHeight : Integer
var $rightOverflow; $leftOverflow : Integer
var $pos : Integer

var $colWidth; $rowHeight : Real
var $borderOffset : Real
var $pictWidth; $pictHeight : Real
var $pictX; $pictY : Real

var $valCol; $namedStyleCol; $sheetCol; $namedStyleQuery; $bgImgCol : Collection
var $visible; $condition; $cascadingStyleSheet; $borderOrientation; $drawLine; $displayValue : Boolean


// MARK:- Initialize Objects and Constants 
$bcObj:=New object:C1471("bcGrid"; New object:C1471; "bcCol"; New collection:C1472)

svg_defineColorConstant

/// CONSTANTS VALUES ///

NONE_TEXT_ORIENTATION:=360
NONE_BORDER_STYLE:=-1

STR_DLI_DIAGONAL_UP:="du"
STR_DLI_DIAGONAL_DOWN:="dd"
STR_DLI_RIGHT:="hr"
STR_DLI_DOWN:="vb"

EMPTY_STRING:=""

DLI_DIAGONAL_UP:=->STR_DLI_DIAGONAL_UP
DLI_DIAGONAL_DOWN:=->STR_DLI_DIAGONAL_DOWN
DLI_RIGHT:=->STR_DLI_RIGHT
DLI_DOWN:=->STR_DLI_DOWN

NONE_HORIZONTAL_ALIGN:=0
LEFT_HORIZONTAL_ALIGN:=1
CENTER_HORIZONTAL_ALIGN:=2
RIGHT_HORIZONTAL_ALIGN:=3

NONE_VERTICAL_ALIGN:=0
TOP_VERTICAL_ALIGN:=1
CENTER_VERTICAL_ALIGN:=2
BOTTOM_VERTICAL_ALIGN:=3

DEFAULT_LINE_HEIGHT:=17.5997

BORDER_TOP:=0
BORDER_LEFT:=1
BORDER_RIGHT:=2
BORDER_BOTTOM:=3

BORDER_SIZE:=4

FREE:=0
EATER:=1
EATED:=2

////////////////////////

$rowCount:=1000
$colCount:=100

$valCol:=New collection:C1472

$lineObj:=New object:C1471("H"; New object:C1471; "V"; New object:C1471; "lines"; New collection:C1472)

// MARK:- Workbook and Sheets Handling
If (Value type:C1509($vpObject.spreadJS)=Is object:K8:27)
	$workbook:=$vpObject.spreadJS
	
	$sheetCol:=New collection:C1472
	var $s : Text
	For each ($s; $workbook.sheets)
		$sheetCol.push($workbook.sheets[$s])
	End for each 
	
	If (Value type:C1509($workbook.activeSheetIndex)=Is real:K8:4)
		$sheets:=$sheetCol[$vpObject.spreadJS.activeSheetIndex]
	Else 
		$sheets:=$sheetCol[0]
	End if 
	
	Case of 
		: ($cells=Null:C1517)
		: ($cells.ranges=Null:C1517)
		: ($cells.ranges[0]=Null:C1517)
		: ($cells.ranges[0].sheet=Null:C1517)
		: (Value type:C1509($cells.ranges[0].sheet)#Is real:K8:4)
		Else 
			If ($sheetCol.length>$cells.ranges[0].sheet)
				$sheets:=$sheetCol[$cells.ranges[0].sheet]
			End if 
	End case 
	
End if 

// MARK:- Default Styles and Theme
If ($sheets#Null:C1517)
	$table:=$sheets.data.dataTable
	If ($sheets.data.defaultDataNode.style#Null:C1517)
		
		Case of 
			: (Value type:C1509($sheets.data.defaultDataNode.style)=Is object:K8:27)
				$defaultStyle:=$sheets.data.defaultDataNode.style
				
			: (Value type:C1509($sheets.data.defaultDataNode.style)=Is text:K8:3)
				If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
					$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $sheets.data.defaultDataNode.style)
					If ($namedStyleQuery.length>0)
						$defaultStyle:=$namedStyleQuery[0]
					End if 
				End if 
				
		End case 
	End if 
Else 
	$table:=Null:C1517
End if 

//If (inspectObject=1)
//TRACE
//End if

$defaultFontSize:="14.6664px"
$defaultColWidth:=60
$defaultRowHeight:=20

Case of 
	: (Value type:C1509($sheets)#Is object:K8:27)
	: (Value type:C1509($sheets.defaults)#Is object:K8:27)
	Else 
		If (Value type:C1509($sheets.defaults.colWidth)=Is real:K8:4)
			$defaultColWidth:=$sheets.defaults.colWidth
		End if 
		If (Value type:C1509($sheets.defaults.rowHeight)=Is real:K8:4)
			$defaultRowHeight:=$sheets.defaults.rowHeight
		End if 
End case 

Case of 
	: (Value type:C1509($sheets.theme)=Is text:K8:3)
		svg_initDefaultTheme($sheets.theme)
	: (Value type:C1509($sheets.theme)=Is object:K8:27)
		theme:=$sheets.theme
End case 

themeFont:="Calibri"
If ($defaultStyle#Null:C1517)
	If (Value type:C1509($defaultStyle.themeFont)=Is text:K8:3)
		Case of 
			: ($defaultStyle.themeFont="Body")
				themeFont:=theme["bodyFont"]
			: ($defaultStyle.themeFont="Heading")
				themeFont:=theme["headingFont"]
		End case 
	End if 
End if 

// MARK:- Cell Range and Dimensions
var $range : Object:=vp_getCellRange($vpObject; $cells)

If ($sheets.columnCount#Null:C1517)
	$colCount:=Num:C11($sheets.columnCount)
End if 

If ($sheets.rowCount#Null:C1517)
	$rowCount:=Num:C11($sheets.rowCount)
End if 

If ($range.x2>=$colCount)
	$range.x2:=$colCount-1
End if 

If ($range.y2>=$rowCount)
	$range.y2:=$rowCount-1
End if 

// MARK:- Row and Column Positions
var $size : Integer

var $startY : Integer
$startY:=0
For ($iterY; 0; $range.y1-1)
	
	$condition:=False:C215
	$size:=0
	Case of 
		: (Not:C34((Value type:C1509($sheets.rows)=Is collection:K8:32)))
			$condition:=True:C214
		: (Not:C34($sheets.rows.length>$iterY))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.rows[$iterY])=Is object:K8:27))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.rows[$iterY].size)=Is real:K8:4))
			$condition:=True:C214
		Else 
			$size:=$sheets.rows[$iterY].size
	End case 
	
	$visible:=True:C214
	Case of 
		: (Not:C34((Value type:C1509($sheets.rows)=Is collection:K8:32)))
		: (Not:C34($sheets.rows.length>$iterY))
		: (Not:C34(Value type:C1509($sheets.rows[$iterY])=Is object:K8:27))
		: (Value type:C1509($sheets.rows[$iterY].visible)=Is boolean:K8:9)
			$visible:=$sheets.rows[$iterY].visible
	End case 
	
	Case of 
		: (Not:C34($visible))
		: ($condition)
			$startY:=$startY+$defaultRowHeight
		Else 
			$startY:=$startY+$size
	End case 
	
End for 

$rowHeight:=0
APPEND TO ARRAY:C911($rowPos; $rowHeight)
For ($iterY; $range.y1; $rowCount)
	
	$condition:=False:C215
	$size:=0
	Case of 
		: (Not:C34((Value type:C1509($sheets.rows)=Is collection:K8:32)))
			$condition:=True:C214
		: (Not:C34($sheets.rows.length>$iterY))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.rows[$iterY])=Is object:K8:27))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.rows[$iterY].size)=Is real:K8:4))
			$condition:=True:C214
		Else 
			$size:=$sheets.rows[$iterY].size
	End case 
	
	$visible:=True:C214
	Case of 
		: (Not:C34((Value type:C1509($sheets.rows)=Is collection:K8:32)))
		: (Not:C34($sheets.rows.length>$iterY))
		: (Not:C34(Value type:C1509($sheets.rows[$iterY])=Is object:K8:27))
		: (Value type:C1509($sheets.rows[$iterY].visible)=Is boolean:K8:9)
			$visible:=$sheets.rows[$iterY].visible
	End case 
	
	Case of 
		: (Not:C34($visible))
		: ($condition)
			$rowHeight:=$rowHeight+$defaultRowHeight
		Else 
			$rowHeight:=$rowHeight+$size
	End case 
	
	APPEND TO ARRAY:C911($rowPos; $rowHeight)
	
End for 

$svgHeight:=$rowPos{Int:C8($range.y2-$range.y1+2)}
Case of 
	: (Not:C34($visible))
	: ($condition)
		//$svgHeight:=$svgHeight-$defaultRowHeight
	Else 
		$svgHeight:=$svgHeight-$size
End case 

var $startX : Integer
$startX:=0
For ($iterX; 0; $range.x1-1)
	
	$condition:=False:C215
	$size:=0
	Case of 
		: (Not:C34((Value type:C1509($sheets.columns)=Is collection:K8:32)))
			$condition:=True:C214
		: (Not:C34($sheets.columns.length>$iterX))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.columns[$iterX])=Is object:K8:27))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.columns[$iterX].size)=Is real:K8:4))
			$condition:=True:C214
		Else 
			$size:=$sheets.columns[$iterX].size
	End case 
	
	$visible:=True:C214
	Case of 
		: (Not:C34((Value type:C1509($sheets.columns)=Is collection:K8:32)))
		: (Not:C34($sheets.columns.length>$iterX))
		: (Not:C34(Value type:C1509($sheets.columns[$iterX])=Is object:K8:27))
		: (Value type:C1509($sheets.columns[$iterX].visible)=Is boolean:K8:9)
			$visible:=$sheets.columns[$iterX].visible
	End case 
	
	Case of 
		: (Not:C34($visible))
		: ($condition)
			$startX:=$startX+$defaultColWidth
		Else 
			$startX:=$startX+$size
	End case 
	
End for 

$colWidth:=0
APPEND TO ARRAY:C911($colPos; $colWidth)
For ($iterX; $range.x1; $colCount)
	
	$condition:=False:C215
	$size:=0
	Case of 
		: (Not:C34((Value type:C1509($sheets.columns)=Is collection:K8:32)))
			$condition:=True:C214
		: (Not:C34($sheets.columns.length>$iterX))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.columns[$iterX])=Is object:K8:27))
			$condition:=True:C214
		: (Not:C34(Value type:C1509($sheets.columns[$iterX].size)=Is real:K8:4))
			$condition:=True:C214
		Else 
			$size:=$sheets.columns[$iterX].size
	End case 
	
	$visible:=True:C214
	Case of 
		: (Not:C34((Value type:C1509($sheets.columns)=Is collection:K8:32)))
		: (Not:C34($sheets.columns.length>$iterX))
		: (Not:C34(Value type:C1509($sheets.columns[$iterX])=Is object:K8:27))
		: (Value type:C1509($sheets.columns[$iterX].visible)=Is boolean:K8:9)
			$visible:=$sheets.columns[$iterX].visible
	End case 
	
	Case of 
		: (Not:C34($visible))
		: ($condition)
			$colWidth:=$colWidth+$defaultColWidth
		Else 
			$colWidth:=$colWidth+$size
	End case 
	
	APPEND TO ARRAY:C911($colPos; $colWidth)
	
End for 

$svgWidth:=$colPos{Int:C8($range.x2-$range.x1+2)}
Case of 
	: (Not:C34($visible))
	: ($condition)
		//$svgWidth:=$svgWidth-$defaultColWidth
	Else 
		$svgWidth:=$svgWidth-$size
End case 

// MARK:- SVG Initialization
$svgRef:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink"; "version"; "1.1")
XML SET OPTIONS:C1090($svgRef; XML String encoding:K45:21; XML String encoding:K45:21)
DOM SET XML DECLARATION:C859($svgRef; "UTF-8"; True:C214)

If ($defaultStyle#Null:C1517)
	If ($defaultStyle.backColor#Null:C1517)
		$svgSource:=$svgSource+"<rect x=\"0\" y=\"0\" width=\""+String:C10($svgWidth)+"\" height=\""+String:C10($svgHeight)+"\" fill=\""+$defaultStyle.backColor+"\"/>"
	End if 
End if 

// MARK:- Spans Handling
///MAX SVG SIZE///

If ($range.isAll=True:C214) | ($range.isAllCol=True:C214)
	$maxSvgWidth:=$colPos{Int:C8($colCount+1)}
Else 
	$maxSvgWidth:=$colPos{Int:C8($range.x2-$range.x1+2)}
End if 

If ($range.isAll=True:C214) | ($range.isAllRow=True:C214)
	$maxSvgHeight:=$rowPos{Int:C8($rowCount+1)}
Else 
	$maxSvgHeight:=$rowPos{Int:C8($range.y2-$range.y1+2)}
End if 

///SPANS HANDLING///
var $mergeTab : Collection
var $span; $cellMergeStatus : Object
var $row; $col : Integer

$mergeTab:=Null:C1517
If ($sheets#Null:C1517)
	If (Value type:C1509($sheets.spans)=Is collection:K8:32)
		
		For each ($span; $sheets.spans)
			
			If ($mergeTab=Null:C1517)
				$mergeTab:=New collection:C1472
			End if 
			
			If (Not:C34(svg_checkColIndex($mergeTab; $span.row)))
				$mergeTab[$span.row]:=New collection:C1472
			End if 
			
			$mergeTab[$span.row][$span.col]:=New object:C1471("rowCount"; $span.rowCount; "colCount"; $span.colCount; "type"; EATER)
			
			For ($row; $span.row; $span.row+$span.rowCount-1)
				
				For ($col; $span.col; $span.col+$span.colCount-1)
					
					If ($row#$span.row) | ($col#$span.col)
						
						If (Not:C34(svg_checkColIndex($mergeTab; $row)))
							$mergeTab[$row]:=New collection:C1472
						End if 
						
						$mergeTab[$row][$col]:=New object:C1471("type"; EATED)
						
					End if 
					
					$mergeTab[$row][$col].topBorder:=False:C215
					$mergeTab[$row][$col].bottomBorder:=False:C215
					$mergeTab[$row][$col].leftBorder:=False:C215
					$mergeTab[$row][$col].rightBorder:=False:C215
					
					If ($row=$span.row)
						$mergeTab[$row][$col].topBorder:=True:C214
					End if 
					
					If ($row=($span.row+$span.rowCount-1))
						$mergeTab[$row][$col].bottomBorder:=True:C214
					End if 
					
					If ($col=$span.col)
						$mergeTab[$row][$col].leftBorder:=True:C214
					End if 
					
					If ($col=($span.col+$span.colCount-1))
						$mergeTab[$row][$col].rightBorder:=True:C214
					End if 
					
				End for 
				
			End for 
			
		End for each 
		
	End if 
End if 

// MARK:- Cell Parsing and Style Application
For ($iterY; $range.y1; $range.y2)
	
	$rowHeight:=$defaultRowHeight
	If ($sheets.rows#Null:C1517)
		If ($sheets.rows.length>$iterY)
			If ($sheets.rows[$iterY]#Null:C1517)
				If (Value type:C1509($sheets.rows[$iterY].size)=Is real:K8:4)
					$rowHeight:=$sheets.rows[$iterY].size
				End if 
				If (Value type:C1509($sheets.rows[$iterY].visible)=Is boolean:K8:9)
					If (Not:C34($sheets.rows[$iterY].visible))
						$rowHeight:=0
					End if 
				End if 
			End if 
		End if 
	End if 
	$initialRowHeight:=$rowHeight
	
	
	
	For ($iterX; $range.x1; $range.x2+1)
		
		$cellMergeStatus:=svg_getCellMergeStatus($iterY; $iterX; $mergeTab)
		
		
		If ($cellMergeStatus.type=EATER)
			
			If (($iterX+$cellMergeStatus.colCount-1)>$range.x2)
				
				Case of 
					: ($cells=Null:C1517)
						$range.x2:=($iterX+$cellMergeStatus.colCount-1)
						
					: (OB Is empty:C1297($cells.ranges[0]))
						$range.x2:=($iterX+$cellMergeStatus.colCount-1)
						
				End case 
				
				For ($index; $iterX; ($iterX+$cellMergeStatus.colCount))
					
					If (($index-$range.x1+1)>=(Size of array:C274($colPos)))
						
						$indexColWidth:=$defaultColWidth
						If ($sheets.columns#Null:C1517)
							If ($sheets.columns.length>$index)
								If ($sheets.columns[$index]#Null:C1517)
									If (Value type:C1509($sheets.columns[$index].size)=Is real:K8:4)
										$indexColWidth:=$sheets.columns[$index].size
									End if 
									If (Value type:C1509($sheets.columns[$index].visible)=Is boolean:K8:9)
										If (Not:C34($sheets.columns[$index].visible))
											$indexColWidth:=0
										End if 
									End if 
								End if 
							End if 
						End if 
						
						APPEND TO ARRAY:C911($colPos; $colPos{Int:C8($index-$range.x1+1)}+$indexColWidth)
						
					End if 
					
				End for 
				
				If ($svgWidth<($colPos{Int:C8($range.x2-$range.x1+2)}))
					$svgWidth:=$colPos{Int:C8($range.x2-$range.x1+2)}
				End if 
				
			End if 
			
			
			If (($iterY+$cellMergeStatus.rowCount-1)>$range.y2)
				
				If ($cells=Null:C1517)
					$range.y2:=($iterY+$cellMergeStatus.rowCount-1)
				End if 
				
				For ($index; $iterY; ($iterY+$cellMergeStatus.rowCount))
					
					If (($index-$range.y1+1)>=(Size of array:C274($rowPos)))
						
						$indexRowHeight:=$defaultRowHeight
						If ($sheets.rows#Null:C1517)
							If ($sheets.rows.length>$index)
								If ($sheets.rows[$index]#Null:C1517)
									If (Value type:C1509($sheets.rows[$index].size)=Is real:K8:4)
										$indexRowHeight:=$sheets.rows[$index].size
									End if 
									If (Value type:C1509($sheets.rows[$index].visible)=Is boolean:K8:9)
										If (Not:C34($sheets.rows[$index].visible))
											$indexRowHeight:=0
										End if 
									End if 
								End if 
							End if 
						End if 
						
						APPEND TO ARRAY:C911($rowPos; $rowPos{Int:C8($index-$range.y1+1)}+$indexRowHeight)
						
					End if 
					
				End for 
				
				If ($svgHeight<($rowPos{Int:C8($range.y2-$range.y1+2)}))
					$svgHeight:=$rowPos{Int:C8($range.y2-$range.y1+2)}
				End if 
				
			End if 
			
		End if 
		
		
		If ($rowHeight#0) | ($cellMergeStatus.type=EATER)
			
			$colWidth:=$defaultColWidth
			If ($sheets.columns#Null:C1517)
				If ($sheets.columns.length>$iterX)
					If ($sheets.columns[$iterX]#Null:C1517)
						If (Value type:C1509($sheets.columns[$iterX].size)=Is real:K8:4)
							$colWidth:=$sheets.columns[$iterX].size
						End if 
						If (Value type:C1509($sheets.columns[$iterX].visible)=Is boolean:K8:9)
							If (Not:C34($sheets.columns[$iterX].visible))
								$colWidth:=0
							End if 
						End if 
					End if 
				End if 
			End if 
			$initialColWidth:=$colWidth
			
			If ($colWidth#0) | ($cellMergeStatus.type=EATER)
				
				$parsedStyle:=New object:C1471
				
				$parsedStyle.topBorderStyle:=NONE_BORDER_STYLE
				$parsedStyle.leftBorderStyle:=NONE_BORDER_STYLE
				$parsedStyle.bottomBorderStyle:=NONE_BORDER_STYLE
				$parsedStyle.rightBorderStyle:=NONE_BORDER_STYLE
				$parsedStyle.diagonalUpStyle:=NONE_BORDER_STYLE
				$parsedStyle.diagonalDownStyle:=NONE_BORDER_STYLE
				$parsedStyle.hAlign:=NONE_HORIZONTAL_ALIGN
				$parsedStyle.vAlign:=NONE_VERTICAL_ALIGN
				$parsedStyle.fontObj:=Null:C1517
				$parsedStyle.font:=""
				$parsedStyle.fill:=""
				$parsedStyle.textDecoration:=""
				$parsedStyle.textIndent:=""
				$parsedStyle.backgroundImage:=""
				$parsedStyle.wordWrap:=2
				$displayValue:=True:C214
				$parsedStyle.isVerticalText:=2
				$parsedStyle.cellPadding:=Null:C1517
				$parsedStyle.shrinkToFit:=2
				$shrinkStr:=""
				$parsedStyle.cellTypeName:=""
				$style:=Null:C1517
				$parsedStyle.backColor:=""
				$parsedStyle.formatInfo:=Null:C1517
				$namedStyleCol:=Null:C1517
				$namedStyle:=Null:C1517
				$parsedStyle.backgroundImageLayout:=""
				$valueStr:=""
				$parsedStyle.textOrientation:=NONE_TEXT_ORIENTATION
				$parsedStyle.wordWrapInfo:=Null:C1517
				$borderOrientation:=False:C215
				$borderOffset:=0
				
				$cell:=Null:C1517
				
				
				If ($table#Null:C1517)
					If ($table[String:C10($iterY)]#Null:C1517)
						If ($table[String:C10($iterY)][String:C10($iterX)]#Null:C1517)
							If (Value type:C1509($table[String:C10($iterY)][String:C10($iterX)])=Is object:K8:27)
								$cell:=$table[String:C10($iterY)][String:C10($iterX)]
								
								Case of 
									: (Value type:C1509($cell.style)=Is object:K8:27)
										$style:=$cell.style
									: (Value type:C1509($cell.style)=Is text:K8:3)
										If (Value type:C1509($sheets.namedStyles)=Is collection:K8:32)
											$namedStyleQuery:=$sheets.namedStyles.query("name = :1"; $cell.style)
											If ($namedStyleQuery.length>0)
												$style:=$namedStyleQuery[0]
											End if 
										End if 
										If ($style=Null:C1517)
											If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
												$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $cell.style)
												If ($namedStyleQuery.length>0)
													$style:=$namedStyleQuery[0]
												End if 
											End if 
										End if 
								End case 
								
								If ($style#Null:C1517)
									svg_parseStyle($style; $parsedStyle)
									
									// Gestion du Named Style
									$namedStyle:=Null:C1517
									$namedStyleCol:=Null:C1517
									If (Value type:C1509($style.parentName)=Is text:K8:3)
										If (Value type:C1509($sheets.namedStyles)=Is collection:K8:32)
											$namedStyleQuery:=$sheets.namedStyles.query("name = :1"; $style.parentName)
											If ($namedStyleQuery.length>0)
												$namedStyle:=$namedStyleQuery[0]
												$namedStyleCol:=$sheets.namedStyles
												//$namedStyle:=$sheets.namedStyles.query("name = :1";$style.parentName)[0]
											End if 
										End if 
										If ($namedStyleCol=Null:C1517)
											If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
												$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $style.parentName)
												If ($namedStyleQuery.length>0)
													$namedStyle:=$namedStyleQuery[0]
													$namedStyleCol:=$workbook.namedStyles
													//$namedStyle:=$vpObject.spreadJS.namedStyles.query("name = :1";$style.parentName)[0]
												End if 
											End if 
										End if 
										
/*
If ($namedStyleCol#Null)
$namedStyle:=$namedStyleCol.query("name = :1";$style.parentName)[0]
End if
*/
										
									End if 
									
									$cascadingStyleSheet:=True:C214
									While ($cascadingStyleSheet)
										$cascadingStyleSheet:=False:C215
										
										If ($namedStyle#Null:C1517)
											svg_parseStyle($namedStyle; $parsedStyle)
											
											If (Value type:C1509($namedStyle.parentName)=Is text:K8:3)
												$index:=$namedStyleCol.indexOf($namedStyle)
												$namedStyleQuery:=$namedStyleCol.query("name = :1"; $namedStyle.parentName)
												If ($namedStyleQuery.length>0)
													$namedStyle:=$namedStyleQuery[0]
													If ($namedStyleCol.indexOf($namedStyle)<$index)
														$cascadingStyleSheet:=True:C214
													End if 
												End if 
											End if 
											
										End if 
									End while 
								End if 
								
							End if 
						End if 
						
					End if 
					
				End if 
				
				// MARK: Gestion du Row Style
				$style:=Null:C1517
				If (Value type:C1509($sheets.data.rowDataArray)=Is collection:K8:32)
					If ($sheets.data.rowDataArray.length>($iterY-$range.y1))
						If (Value type:C1509($sheets.data.rowDataArray[$iterY-$range.y1])=Is object:K8:27)
							Case of 
								: (Value type:C1509($sheets.data.rowDataArray[$iterY-$range.y1].style)=Is object:K8:27)
									$style:=$sheets.data.rowDataArray[$iterY-$range.y1].style
								: (Value type:C1509($sheets.data.rowDataArray[$iterY-$range.y1].style)=Is text:K8:3)
									If (Value type:C1509($sheets.namedStyles)=Is collection:K8:32)
										$namedStyleQuery:=$sheets.namedStyles.query("name = :1"; $sheets.data.rowDataArray[$iterY-$range.y1].style)
										If ($namedStyleQuery.length>0)
											$style:=$namedStyleQuery[0]
										End if 
									End if 
									If ($style=Null:C1517)
										If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
											$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $sheets.data.rowDataArray[$iterY-$range.y1].style)
											If ($namedStyleQuery.length>0)
												$style:=$namedStyleQuery[0]
											End if 
										End if 
									End if 
							End case 
						End if 
					End if 
				End if 
				
				If ($style#Null:C1517)
					svg_parseStyle($style; $parsedStyle)
					
					$namedStyle:=Null:C1517
					$namedStyleCol:=Null:C1517
					If (Value type:C1509($style.parentName)=Is text:K8:3)
						If (Value type:C1509($sheets.namedStyles)=Is collection:K8:32)
							$namedStyleQuery:=$sheets.namedStyles.query("name = :1"; $style.parentName)
							If ($namedStyleQuery.length>0)
								$namedStyle:=$namedStyleQuery[0]
								$namedStyleCol:=$sheets.namedStyles
								//$namedStyle:=$sheets.namedStyles.query("name = :1";$style.parentName)[0]
							End if 
						End if 
						If ($namedStyle=Null:C1517)
							If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
								$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $style.parentName)
								If ($namedStyleQuery.length>0)
									$namedStyle:=$namedStyleQuery[0]
									$namedStyleCol:=$workbook.namedStyles
									//$namedStyle:=$vpObject.spreadJS.namedStyles.query("name = :1";$style.parentName)[0]
								End if 
							End if 
						End if 
						
/*
If ($namedStyleCol#Null)
$namedStyle:=$namedStyleCol.query("name = :1";$style.parentName)[0]
End if
*/
						
					End if 
					
					$cascadingStyleSheet:=True:C214
					While ($cascadingStyleSheet)
						$cascadingStyleSheet:=False:C215
						
						If ($namedStyle#Null:C1517)
							svg_parseStyle($namedStyle; $parsedStyle)
							
							If (Value type:C1509($namedStyle.parentName)=Is text:K8:3)
								$index:=$namedStyleCol.indexOf($namedStyle)
								If ($namedStyleCol.query("name = :1"; $namedStyle.parentName).length=1)
									$namedStyle:=$namedStyleCol.query("name = :1"; $namedStyle.parentName)[0]
									If ($namedStyleCol.indexOf($namedStyle)<$index)
										$cascadingStyleSheet:=True:C214
									End if 
								End if 
							End if 
							
						End if 
					End while 
				End if 
				
				// MARK: Gestion du Column Style
				$style:=Null:C1517
				If (Value type:C1509($sheets.data.columnDataArray)=Is collection:K8:32)
					If ($sheets.data.columnDataArray.length>($iterX-$range.x1))
						If (Value type:C1509($sheets.data.columnDataArray[$iterX-$range.x1])=Is object:K8:27)
							Case of 
								: (Value type:C1509($sheets.data.columnDataArray[$iterX-$range.x1].style)=Is object:K8:27)
									$style:=$sheets.data.columnDataArray[$iterX-$range.x1].style
								: (Value type:C1509($sheets.data.columnDataArray[$iterX-$range.x1].style)=Is text:K8:3)
									If (Value type:C1509($sheets.namedStyles)=Is collection:K8:32)
										$namedStyleQuery:=$sheets.namedStyles.query("name = :1"; $sheets.data.columnDataArray[$iterX-$range.x1].style)
										If ($namedStyleQuery.length>0)
											$style:=$namedStyleQuery[0]
										End if 
									End if 
									If ($style=Null:C1517)
										If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
											$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $sheets.data.columnDataArray[$iterX-$range.x1].style)
											If ($namedStyleQuery.length>0)
												$style:=$namedStyleQuery[0]
											End if 
										End if 
									End if 
							End case 
						End if 
					End if 
				End if 
				
				If ($style#Null:C1517)
					svg_parseStyle($style; $parsedStyle)
					
					$namedStyle:=Null:C1517
					$namedStyleCol:=Null:C1517
					If (Value type:C1509($style.parentName)=Is text:K8:3)
						If (Value type:C1509($sheets.namedStyles)=Is collection:K8:32)
							$namedStyleQuery:=$sheets.namedStyles.query("name = :1"; $style.parentName)
							If ($namedStyleQuery.length>0)
								$namedStyle:=$namedStyleQuery[0]
								$namedStyleCol:=$sheets.namedStyles
								//$namedStyle:=$sheets.namedStyles.query("name = :1";$style.parentName)[0]
							End if 
						End if 
						If ($namedStyleCol=Null:C1517)
							If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
								$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $style.parentName)
								If ($namedStyleQuery.length>0)
									$namedStyle:=$namedStyleQuery[0]
									$namedStyleCol:=$workbook.namedStyles
									//$namedStyle:=$vpObject.spreadJS.namedStyles.query("name = :1";$style.parentName)[0]
								End if 
							End if 
						End if 
						
/*
If ($namedStyleCol#Null)
$namedStyle:=$namedStyleCol.query("name = :1";$style.parentName)[0]
End if
*/
						
					End if 
					
					$cascadingStyleSheet:=True:C214
					While ($cascadingStyleSheet)
						$cascadingStyleSheet:=False:C215
						
						If ($namedStyle#Null:C1517)
							svg_parseStyle($namedStyle; $parsedStyle)
							
							If (Value type:C1509($namedStyle.parentName)=Is text:K8:3)
								$index:=$namedStyleCol.indexOf($namedStyle)
								$namedStyleQuery:=$namedStyleCol.query("name = :1"; $namedStyle.parentName)
								If ($namedStyleQuery.length>0)
									$namedStyle:=$namedStyleQuery[0]
									If ($namedStyleCol.indexOf($namedStyle)<$index)
										$cascadingStyleSheet:=True:C214
									End if 
								End if 
							End if 
							
						End if 
					End while 
				End if 
				
				// MARK: Gestion du Default Style
				If ($defaultStyle#Null:C1517)
					svg_parseStyle($defaultStyle; $parsedStyle)
					
					$namedStyle:=Null:C1517
					$namedStyleQuery:=Null:C1517
					If (Value type:C1509($style.parentName)=Is text:K8:3)
						If (Value type:C1509($sheets.namedStyles)=Is collection:K8:32)
							$namedStyleQuery:=$sheets.namedStyles.query("name = :1"; $style.parentName)
							If ($namedStyleQuery.length>0)
								$namedStyleCol:=$sheets.namedStyles
								$namedStyle:=$namedStyleQuery[0]
								//$namedStyle:=$sheets.namedStyles.query("name = :1";$style.parentName)[0]
							End if 
						End if 
						If ($namedStyleCol=Null:C1517)
							If (Value type:C1509($workbook.namedStyles)=Is collection:K8:32)
								$namedStyleQuery:=$workbook.namedStyles.query("name = :1"; $style.parentName)
								If ($namedStyleQuery.length>0)
									$namedStyle:=$namedStyleQuery[0]
									$namedStyleCol:=$workbook.namedStyles
									//$namedStyle:=$vpObject.spreadJS.namedStyles.query("name = :1";$style.parentName)[0]
								End if 
							End if 
						End if 
						
/*
If ($namedStyleCol#Null)
$namedStyle:=$namedStyleCol.query("name = :1";$style.parentName)[0]
End if
*/
						
					End if 
					
					$cascadingStyleSheet:=True:C214
					While ($cascadingStyleSheet)
						$cascadingStyleSheet:=False:C215
						
						If ($namedStyle#Null:C1517)
							svg_parseStyle($namedStyle; $parsedStyle)
							
							If (Value type:C1509($namedStyle.parentName)=Is text:K8:3)
								$index:=$namedStyleCol.indexOf($namedStyle)
								$namedStyleQuery:=$namedStyleCol.query("name = :1"; $namedStyle.parentName)
								If ($namedStyleQuery.length>0)
									$namedStyle:=$namedStyleQuery[0]
									If ($namedStyleCol.indexOf($namedStyle)<$index)
										$cascadingStyleSheet:=True:C214
									End if 
								End if 
							End if 
							
						End if 
					End while 
				End if 
				
				// MARK: Ajout de la backgroundImage
				If ($parsedStyle.backgroundImage#"") | ($parsedStyle.cellTypeName="1")
					
					$x1:=$colPos{Int:C8($iterX-$range.x1+1)}
					$y1:=$rowPos{Int:C8($iterY-$range.y1+1)}
					
					Case of 
						: ($cellMergeStatus.type=FREE)
							$height:=$rowHeight
							$width:=$colWidth
							
						: ($cellMergeStatus.type=EATER)
							$height:=$rowPos{Int:C8($iterY+$cellMergeStatus.rowCount-$range.y1+1)}-$y1
							$width:=$colPos{Int:C8($iterX+$cellMergeStatus.colCount-$range.x1+1)}-$x1
							
					End case 
					
					$parsedStyle.backgroundImage:=svg_getBase64Image(Choose:C955(($parsedStyle.cellTypeName#"") & Not:C34(Value type:C1509($parsedStyle.pict)=Is undefined:K8:13); $parsedStyle.pict; $parsedStyle.backgroundImage))
					
					If ($bgImgCol=Null:C1517)
						$bgImgCol:=New collection:C1472
					End if 
					
					$bgImgCol.push(New object:C1471("x"; $x1; "y"; $y1; "w"; $width; "h"; $height; "bg"; $parsedStyle.backgroundImage; "lay"; $parsedStyle.backgroundImageLayout))
					
					If ($parsedStyle.cellTypeName="1")
						$displayValue:=False:C215
					End if 
					
				End if 
				
				// MARK: Ajout de la value avec toutes les options
				If (($cell#Null:C1517) & ($displayValue) & ($cellMergeStatus.type#EATED))
					$colWidth:=$initialColWidth
					$rowHeight:=$initialRowHeight
					If ($cellMergeStatus.type=FREE)
						$x1:=$colPos{Int:C8($iterX-$range.x1+1)}
						$y1:=$rowPos{Int:C8($iterY-$range.y1+1)}
						$x2:=$x1+$colWidth
						$y2:=$y1+$rowHeight
						$height:=$rowHeight
						$width:=$colWidth
					Else 
						$x1:=$colPos{Int:C8($iterX-$range.x1+1)}
						$y1:=$rowPos{Int:C8($iterY-$range.y1+1)}
						$x2:=$colPos{Int:C8($iterX-$range.x1+$cellMergeStatus.colCount+1)}
						$y2:=$rowPos{Int:C8($iterY-$range.y1+$cellMergeStatus.rowCount+1)}
						$rowHeight:=$rowPos{Int:C8($iterY-$range.y1+$cellMergeStatus.rowCount+1)}-$rowPos{Int:C8($iterY-$range.y1+1)}
						$colWidth:=$colPos{Int:C8($iterX-$range.x1+$cellMergeStatus.colCount+1)}-$colPos{Int:C8($iterX-$range.x1+1)}
						$height:=$rowHeight
						$width:=$colWidth
					End if 
					
					If (Value type:C1509($cell.value)#Is undefined:K8:13) & ($cellMergeStatus.type=FREE) & (($parsedStyle.topBorderStyle>0) | ($parsedStyle.bottomBorderStyle>0) | ($parsedStyle.rightBorderStyle>0) | ($parsedStyle.leftBorderStyle>0)) & ($parsedStyle.textOrientation#0) & ($parsedStyle.textOrientation#NONE_TEXT_ORIENTATION)
						$borderOrientation:=True:C214
					End if 
					
					If ($parsedStyle.textOrientation>0)
						
						$radOrientation:=(90-$parsedStyle.textOrientation)*Degree:K30:2
						
					Else 
						
						$radOrientation:=(-90-$parsedStyle.textOrientation)*Degree:K30:2
						
					End if 
					
					$borderOffset:=Tan:C19($radOrientation)*$rowHeight
					
					If ($borderOrientation) & (($colPos{Int:C8($IterX+2-$range.x1)}+$borderOffset)>$svgWidth)
						$svgWidth:=($colPos{Int:C8($IterX+2-$range.x1)}+$borderOffset)
					End if 
					
					If ($parsedStyle.hAlign=LEFT_HORIZONTAL_ALIGN) & ($parsedStyle.textOrientation>0) & (($colPos{Int:C8($IterX+2-$range.x1)}+$borderOffset)>$svgWidth)
						$svgWidth:=($colPos{Int:C8($IterX+2-$range.x1)}+$borderOffset)
					End if 
					
					If ($parsedStyle.hAlign=LEFT_HORIZONTAL_ALIGN) & ($parsedStyle.textOrientation<0) & (($colPos{Int:C8($IterX+2-$range.x1)}-$borderOffset)>$svgWidth)
						$svgWidth:=($colPos{Int:C8($IterX+2-$range.x1)}-$borderOffset)
					End if 
					
					If (Value type:C1509($cell.value)=Is text:K8:3) | (Value type:C1509($cell.value)=Is longint:K8:6) | (Value type:C1509($cell.value)=Is real:K8:4) | (Value type:C1509($cell.value)=Is boolean:K8:9)
						
						If ((($parsedStyle.textOrientation>0) & ($parsedStyle.textOrientation<90)) | ($parsedStyle.textOrientation=-90)) & ($parsedStyle.hAlign=NONE_HORIZONTAL_ALIGN)
							$parsedStyle.hAlign:=LEFT_HORIZONTAL_ALIGN
						End if 
						
						If ((($parsedStyle.textOrientation<0) & ($parsedStyle.textOrientation>-90)) | ($parsedStyle.textOrientation=90)) & ($parsedStyle.hAlign=NONE_HORIZONTAL_ALIGN)
							$parsedStyle.hAlign:=RIGHT_HORIZONTAL_ALIGN
						End if 
						
						$strPart:=Null:C1517
						If ((Value type:C1509($cell.value)=Is longint:K8:6) | (Value type:C1509($cell.value)=Is real:K8:4)) & ($parsedStyle.hAlign=NONE_HORIZONTAL_ALIGN)
							$parsedStyle.hAlign:=RIGHT_HORIZONTAL_ALIGN
						End if 
						
						If (Value type:C1509($cell.value)=Is text:K8:3)
							If ($cell.value="/OADate(@)/") & ($parsedStyle.hAlign=NONE_HORIZONTAL_ALIGN)
								$parsedStyle.hAlign:=RIGHT_HORIZONTAL_ALIGN
							End if 
						End if 
						
						If (Value type:C1509($cell.value)=Is boolean:K8:9) & ($parsedStyle.hAlign=NONE_HORIZONTAL_ALIGN)
							$parsedStyle.hAlign:=CENTER_HORIZONTAL_ALIGN
						End if 
						
						If ($parsedStyle.hAlign=NONE_HORIZONTAL_ALIGN)
							$parsedStyle.hAlign:=LEFT_HORIZONTAL_ALIGN
						End if 
						If ($parsedStyle.vAlign=NONE_VERTICAL_ALIGN)
							$parsedStyle.vAlign:=TOP_VERTICAL_ALIGN
						End if 
						
						var $spaceWidth : Real
						
						If ($parsedStyle.textOrientation#0) & ($parsedStyle.textOrientation#NONE_TEXT_ORIENTATION)
							var $lineHeight : Real
							
							$lineHeight:=DEFAULT_LINE_HEIGHT
							
							If (Value type:C1509($parsedStyle.fontObj)=Is object:K8:27)
								If (Value type:C1509($parsedStyle.fontObj.lineHeight)=Is real:K8:4)
									$lineHeight:=$parsedStyle.fontObj.lineHeight
								End if 
							End if 
							
							var $radOrientation : Real
							$radOrientation:=Abs:C99($parsedStyle.textOrientation*Degree:K30:2)
							
							var $initialBox; $rotatedBox; $translatedBox : Object
							
							$initialBox:=svg_getTextBox($x1; $y2; 10; $lineHeight)
							$rotatedBox:=svg_getRotatedBox($initialBox; $initialBox.topLeft.x; $initialBox.topLeft.y; $radOrientation)
							$translatedBox:=svg_getTranslatedBox($rotatedBox; 0; ($y2+0.3)-$rotatedBox.bottomLeft.y)
							
							$spaceWidth:=($translatedBox.topLeft.y-($y1-0.3))/Cos:C18((90-Abs:C99($parsedStyle.textOrientation))*Degree:K30:2)
						Else 
							$spaceWidth:=$colWidth
						End if 
						
						Case of 
							: ($parsedStyle.formatInfo=Null:C1517)
								Case of 
									: (Value type:C1509($cell.value)=Is real:K8:4) & ($parsedStyle.isVerticalText#1)
										var $e; $p : Real
										var $nbU; $epos : Integer
										var $cvCol : Collection
										var $intLen; $decLen : Integer
										var $x; $v : Real
										
										var $cvStr; $intPart; $decPart : Text
										$cvStr:=String:C10($cell.value)
										If ($cell.value>=10000000000000)
											$intPart:=$cvStr[[1]]
											$pos:=Position:C15(","; $cvStr)
											$epos:=Position:C15("e+"; $cvStr)
											
											If ($pos>0)
												$intPart:=$intPart+Substring:C12($cvStr; $pos+1; $epos-$pos-1)
												
											End if 
											$nbC:=Num:C11(Substring:C12($cvStr; $epos+2; Length:C16($cvStr)-$epos-1))+1
											$intPart:=$intPart+("0"*($nbC-Length:C16($intPart)))
											$decPart:=""
											
											$nbU:=Length:C16($intPart)
											
										Else 
											$nbU:=Position:C15(","; $cvStr)
											$cvCol:=Split string:C1554($cvStr; ",")
											$intPart:=$cvCol[0]
											$decPart:=""
											If ($cvCol.length>1)
												$decPart:=$cvCol[1]
											End if 
											
										End if 
										
										$w:=svg_getTextWidth($intPart; $parsedStyle.fontObj)
										$intLen:=Length:C16($intPart)
										$decLen:=Length:C16($decPart)
										
										If ($w>(Int:C8($spaceWidth)-3)) | ($cell.value>=1e+21)
											$c:=svg_getTextWidth("0"; $parsedStyle.fontObj)
											$e:=svg_getTextWidth("E+"; $parsedStyle.fontObj)
											$p:=svg_getTextWidth(","; $parsedStyle.fontObj)
											
											$nbC:=Int:C8((Int:C8($spaceWidth)-3-$p-$e-(2*$c))/$c)
											
											If ($nbC>6)
												$nbC:=6
											End if 
											
											Case of 
												: ($nbC<=1)
													$nbC:=Int:C8((Int:C8($spaceWidth)-3-$e-(2*$c))/$c)
													
													If ($nbC<=0)
														$valueStr:="#"*Int:C8(((Int:C8($spaceWidth)-3)/svg_getTextWidth("#"; $parsedStyle.fontObj)))
													Else 
														
														If (Num:C11($cvStr[[2]])>=5)
															
															If ($cvStr[[1]]="9")
																$valueStr:="1E+"+Choose:C955(($nbU+1)>=10; ""; "0")+String:C10($nbU+1)
															Else 
																$valueStr:=Char:C90(Character code:C91($cvStr[[1]])+1)+"E+"+Choose:C955(($intLen-1)>=10; String:C10($intLen-1); "0"+String:C10($intLen-1))
															End if 
															
														Else 
															$valueStr:=$cvStr[[1]]+"E+"+Choose:C955(($intLen-1)>=10; String:C10($intLen-1); "0"+String:C10($intLen-1))
														End if 
														
													End if 
													
												: ($nbC<=$intLen)
													
													For ($i; 1; $nbC)
														
														Case of 
															: ($i=$nbC)
																
																Case of 
																	: ($intPart[[$i+1]]="9")
																		$valueStr:="1"
																		
																	: ($intPart[[$i+1]]>="5")
																		$valueStr:=$valueStr+Char:C90(Character code:C91($intPart[[$i]])+1)
																		
																	Else 
																		$valueStr:=$valueStr+$intPart[[$i]]
																		
																End case 
																
															: ($i=1)
																$valueStr:=$valueStr+$intPart[[$i]]+","
																
															Else 
																$valueStr:=$valueStr+$intPart[[$i]]
																
														End case 
														
													End for 
													
													$valueStr:=$valueStr+"E+"+Choose:C955(($intLen-1)>=10; String:C10($intLen-1); "0"+String:C10($intLen-1))
													
												Else 
													ASSERT:C1129(Structure file:C489#Structure file:C489(*); "This number wont be displayed")
											End case 
										Else 
											If ($decLen#0)
												$x:=svg_getTextWidth($intPart+","+$decPart; $parsedStyle.fontObj)
												
												If ($x>(Int:C8($spaceWidth)-3))
													$valueStr:=$intPart+","
													
													$v:=svg_getTextWidth($intPart+","; $parsedStyle.fontObj)
													$c:=svg_getTextWidth("0"; $parsedStyle.fontObj)
													
													$nbC:=Int:C8((Int:C8($spaceWidth)-$v)/$c)
													
													For ($i; 1; $nbC)
														If ($i=$nbC) & ($i<$decLen)
															Case of 
																: ($decPart[[$i+1]]="9")
																	$valueStr:=$valueStr+"1"
																	
																: (Num:C11($decPart[[$i+1]])>=5)
																	$valueStr:=$valueStr+Char:C90(Character code:C91($decPart[[$i]])+1)
																	
																Else 
																	$valueStr:=$valueStr+$decPart[[$i]]
																	
															End case 
															
														Else 
															$valueStr:=$valueStr+$decPart[[$i]]
															
														End if 
													End for 
													
												Else 
													$valueStr:=String:C10($cell.value)
													
												End if 
											Else 
												$valueStr:=$intPart
												
											End if 
										End if 
										
									: (Value type:C1509($cell.value)=Is boolean:K8:9)
										$valueStr:=Choose:C955($cell.value; "TRUE"; "FALSE")
										
										$w:=svg_getTextWidth($valueStr; $parsedStyle.fontObj)
										
										If ($w>(Int:C8($spaceWidth)-3))
											$c:=svg_getTextWidth("#"; $parsedStyle.fontObj)
											
											$valueStr:="#"*Int:C8(((Int:C8($spaceWidth)-3)/$c))
										End if 
									Else 
										$valueStr:=String:C10($cell.value)
										
								End case 
							: (Value type:C1509($parsedStyle.formatInfo.text)=Is text:K8:3)
								$valueStr:=$parsedStyle.formatInfo.text
								
								If (Value type:C1509($cell.value)#Is text:K8:3)
									$w:=svg_getTextWidth($valueStr; $parsedStyle.fontObj)
									
									If ($w>(Int:C8($spaceWidth)-3)) & ($parsedStyle.isVerticalText#1)
										$valueStr:="#"*Int:C8(((Int:C8($spaceWidth)-3)/svg_getTextWidth("#"; $parsedStyle.fontObj)))
									End if 
								Else 
									If ($cell.value="/OADate(@)/")
										$w:=svg_getTextWidth($valueStr; $parsedStyle.fontObj)
										
										If ($w>(Int:C8($spaceWidth)-3)) & ($parsedStyle.isVerticalText#1)
											$valueStr:="#"*Int:C8(((Int:C8($spaceWidth)-3)/svg_getTextWidth("#"; $parsedStyle.fontObj)))
										End if 
									End if 
								End if 
								
							: (Value type:C1509($parsedStyle.formatInfo.content)=Is collection:K8:32)
								
								
								var $str : Text
								$str:=""
								var $valPart : Object
								For each ($valPart; $parsedStyle.formatInfo.content)
									If ($valPart.type#"fillingChar") && ($valPart.type#"placeHolder") && ($valPart.type#"numberPlaceholder")
										$str:=$str+$valPart.value
									End if 
								End for each 
								var $w : Real
								$w:=svg_getTextWidth($str; $parsedStyle.fontObj)
								
								Case of 
									: (($parsedStyle.shrinkToFit=1) & ($w>(Int:C8($spaceWidth)-3))) | ($parsedStyle.isVerticalText=1)
										For each ($valPart; $parsedStyle.formatInfo.content)
											If ($valPart.type#"fillingChar") && ($valPart.type#"placeHolder") && ($valPart.type#"numberPlaceholder")
												$valueStr:=$valueStr+$valPart.value
											End if 
										End for each 
										
									Else 
										
										If ($w>(Int:C8($spaceWidth)-3))
											var $c : Real
											$c:=svg_getTextWidth("#"; $parsedStyle.fontObj)
											
											$valueStr:="#"*Int:C8(((Int:C8($spaceWidth)-3)/$c))
										Else 
											var $fc : Text
											$fc:=$parsedStyle.formatInfo.content.query("type = fillingChar")[0].value
											
											If ($fc=" ")
												$fc:=" "  // <- espace insecable (alt+255)
											End if 
											
											$c:=svg_getTextWidth($fc; $parsedStyle.fontObj)
											
											var $nbC : Integer
											If (($parsedStyle.textOrientation#0) & ($parsedStyle.textOrientation#NONE_TEXT_ORIENTATION))
												$nbC:=Int:C8((Int:C8($rowHeight)-3-$w)/$c)
											Else 
												$nbC:=Int:C8((Int:C8($spaceWidth)-3-$w)/$c)
											End if 
											
											$valueStr:=""
											For each ($valPart; $parsedStyle.formatInfo.content)
												If ($valPart.type="fillingChar")
													$valueStr:=$valueStr+($fc*$nbC)
													$strPart:=New object:C1471("part1"; $valueStr; "part2"; "")
												Else 
													If (($valPart.type#"placeHolder") && ($valPart.type#"numberPlaceholder"))
														$valueStr:=$valueStr+$valPart.value
														If ($strPart#Null:C1517)
															$strPart.part2:=$strPart.part2+$valPart.value
														End if 
													Else 
														
														
													End if 
												End if 
											End for each 
											
										End if 
										
								End case 
								
							Else 
								ASSERT:C1129(Structure file:C489#Structure file:C489(*); "$parsedStyle.formatInfo not correct")
						End case 
						
						If ($strPart#Null:C1517)
							$textWidth:=svg_getTextWidth($strPart.part1+$strPart.part2; $parsedStyle.fontObj)
						Else 
							$textWidth:=svg_getTextWidth($valueStr; $parsedStyle.fontObj)
						End if 
						
						If ($parsedStyle.shrinkToFit=1) & ($parsedStyle.wordWrap#1) & (Not:C34(($parsedStyle.isVerticalText=1) & (($parsedStyle.vAlign#TOP_VERTICAL_ALIGN) & ($parsedStyle.vAlign#NONE_VERTICAL_ALIGN))))
							$width:=$colWidth
							$height:=$rowHeight
							If ($parsedStyle.cellPadding#Null:C1517)
								$width:=$width-Num:C11($parsedStyle.cellPadding.left)-Num:C11($parsedStyle.cellPadding.right)
								$height:=$height-Num:C11($parsedStyle.cellPadding.top)-Num:C11($parsedStyle.cellPadding.bottom)
							End if 
							
							If ($parsedStyle.textIndent#"")
								$width:=$width-(Num:C11($parsedStyle.textIndent)*8)
							End if 
							
							$fontSize:=$defaultFontSize
							Case of 
								: ($parsedStyle.fontObj=Null:C1517)
								: ($parsedStyle.fontObj.size#Null:C1517)
									$fontSize:=$parsedStyle.fontObj.size
							End case 
							
							Case of 
								: ($parsedStyle.isVerticalText=1)
									$shrinkStr:=String:C10(Num:C11($fontSize; ".")/svg_getVTextHeight($valueStr; $parsedStyle.fontObj)*($height-4); "&xml;")+"px"
								: ($parsedStyle.textOrientation#NONE_TEXT_ORIENTATION) & ($parsedStyle.textOrientation#0)
									$shrinkStr:=String:C10(Num:C11($fontSize; ".")/$textWidth*($height-4); "&xml;")+"px"
									$textWidth:=$height-4
								Else 
									$shrinkStr:=String:C10(Num:C11($fontSize; ".")/$textWidth*($width-4); "&xml;")+"px"
									$textWidth:=$width-4
							End case 
						End if 
						
						// MARK: //// OVERFLOW HANDLING ////
						Case of 
							: ($parsedStyle.textOrientation#0) & ($parsedStyle.textOrientation#NONE_TEXT_ORIENTATION)
								$leftOverflow:=0
								$rightOverflow:=$svgWidth
							: ($parsedStyle.wordWrap=1) | ($parsedStyle.isVerticalText=1) | ($shrinkStr#"") | ($strPart#Null:C1517)
								$leftOverflow:=$colPos{Int:C8($iterX-$range.x1+1)}
								$rightOverflow:=$colPos{Int:C8($iterX-$range.x1+2)}
							Else 
								
								// COMPUTE OVERFLOW
								$leftOverflow:=svg_cell_findOverflowL($table; $iterY; $iterX; $range.x1)
								If ($leftOverflow=-1)
									$leftOverflow:=0
								Else 
									$leftOverflow:=$colPos{Int:C8($leftOverflow-$range.x1+2)}
								End if 
								
								$rightOverflow:=svg_cell_findOverflowR($table; $iterY; $iterX; $range.x2+1)
								If ($rightOverflow=-1)
									$rightOverflow:=$svgWidth
									
									If ($parsedStyle.cellPadding#Null:C1517)
										$rightOverflow:=$rightOverflow+Num:C11($parsedStyle.cellPadding.left)
										$textWidth:=$textWidth+Num:C11($parsedStyle.cellPadding.left)
									End if 
									
									If ($parsedStyle.textIndent#"")
										$rightOverflow:=$rightOverflow+(Num:C11($parsedStyle.textIndent)*8)
										$textWidth:=$textWidth+(Num:C11($parsedStyle.textIndent)*8)
									End if 
									
									If (($colPos{Int:C8($IterX-$range.x1+1)}+$textWidth)>$svgWidth)
										$svgWidth:=($colPos{Int:C8($IterX-$range.x1+1)}+$textWidth+4)
										$rightOverflow:=$svgWidth
									End if 
									
									If ($parsedStyle.cellPadding#Null:C1517)
										$textWidth:=$textWidth-Num:C11($parsedStyle.cellPadding.left)
									End if 
									
									If ($parsedStyle.textIndent#"")
										$textWidth:=$textWidth-(Num:C11($parsedStyle.textIndent)*8)
									End if 
									
								Else 
									$rightOverflow:=$colPos{Int:C8($rightOverflow-$range.x1+1)}
									
								End if 
								
								// Remove vertical line when overflow (not if rotation)
								Case of 
									: ($parsedStyle.hAlign=LEFT_HORIZONTAL_ALIGN)
										If ($parsedStyle.cellPadding#Null:C1517)
											$textWidth:=$textWidth+Num:C11($parsedStyle.cellPadding.left)
										End if 
										
										If ($parsedStyle.textIndent#"")
											$textWidth:=$textWidth+(Num:C11($parsedStyle.textIndent)*8)
										End if 
										
										$i:=0
										While (($iterX-$range.x1+2+$i)<Size of array:C274($colPos)) & ($colPos{Int:C8($iterX-$range.x1+2+$i)}<($colPos{Int:C8($iterX-$range.x1+1)}+$textWidth))\
											 & ($colPos{Int:C8($iterX-$range.x1+2+$i)}<$rightOverflow)
											//  svg_addVLine ($lineObj;$iterX+1+$i;$iterY;0;"0")
											svg_addLine($lineObj; $iterX+$i; $iterY; 0; "0"; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_RIGHT)
											svg_addLine($lineObj; $iterX+$i+1; $iterY; 0; "0"; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_LEFT)
											
											
											$i:=$i+1
										End while 
										
										If ($parsedStyle.cellPadding#Null:C1517)
											$textWidth:=$textWidth-Num:C11($parsedStyle.cellPadding.left)
										End if 
										
										If ($parsedStyle.textIndent#"")
											$textWidth:=$textWidth-(Num:C11($parsedStyle.textIndent)*8)
										End if 
										
									: ($parsedStyle.hAlign=CENTER_HORIZONTAL_ALIGN)
										$i:=0
										While ($i<=($range.x2-$range.x1))
											
											If ($colPos{Int:C8($i+1)}>($colPos{Int:C8($iterX-$range.x1+1)}+($colWidth/2)-($textWidth/2))) & ($colPos{Int:C8($i+1)}>$leftOverflow) & \
												($colPos{Int:C8($i+1)}<($colPos{Int:C8($iterX-$range.x1+1)}+($colWidth/2)+($textWidth/2))) & ($colPos{Int:C8($i+1)}<$rightOverflow)
												//svg_addVLine ($lineObj;$i;$iterY;0;"0")
												svg_addLine($lineObj; $i; $iterY; 0; "0"; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_LEFT)
												svg_addLine($lineObj; $i-1; $iterY; 0; "0"; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_RIGHT)
												//svg_addLine ($lineObj;$iterX;$iterY;0;"0";$parsedStyle.textOrientation;$borderOrientation;$borderOffset;BORDER_RIGHT)
												
												//svg_addLine ($lineObj;$iterX+1;$iterY;0;"0";$parsedStyle.textOrientation;$borderOrientation;$borderOffset;BORDER_LEFT)
												
											End if 
											
											$i:=$i+1
										End while 
										
									: ($parsedStyle.hAlign=RIGHT_HORIZONTAL_ALIGN)
										If ($parsedStyle.cellPadding#Null:C1517)
											$textWidth:=$textWidth+Num:C11($parsedStyle.cellPadding.right)
										End if 
										
										If ($parsedStyle.textIndent#"")
											$textWidth:=$textWidth+(Num:C11($parsedStyle.textIndent)*8)
										End if 
										
										$i:=0
										While (($iterX-$range.x1+1-$i)>0) & ($colPos{Int:C8($iterX-$range.x1+1-$i)}>($colPos{Int:C8($iterX-$range.x1+2)}-$textWidth))\
											 & ($colPos{Int:C8($iterX-$range.x1+1-$i)}>$leftOverflow)
											//svg_addVLine ($lineObj;$iterX-$i;$iterY;0;"0")
											svg_addLine($lineObj; $iterX-$i; $iterY; 0; "0"; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_LEFT)
											svg_addLine($lineObj; $iterX-$i-1; $iterY; 0; "0"; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_RIGHT)
											$i:=$i+1
										End while 
										
										If ($parsedStyle.cellPadding#Null:C1517)
											$textWidth:=$textWidth-Num:C11($parsedStyle.cellPadding.right)
										End if 
										
										If ($parsedStyle.textIndent#"")
											$textWidth:=$textWidth-(Num:C11($parsedStyle.textIndent)*8)
										End if 
								End case 
								
						End case 
						
						$valCol.push(New object:C1471("x"; $x1; "y"; $y1; "width"; $colWidth; "height"; $rowHeight; \
							"hAlign"; $parsedStyle.hAlign; "vAlign"; $parsedStyle.vAlign; \
							"value"; $valueStr; \
							"foreColor"; $parsedStyle.fill; \
							"font"; $parsedStyle.font; \
							"fontObj"; $parsedStyle.fontObj; \
							"textDecoration"; $parsedStyle.textDecoration; \
							"textIndent"; $parsedStyle.textIndent; \
							"wordWrap"; Choose:C955($parsedStyle.wordWrap=1; True:C214; False:C215); \
							"rightOverflow"; $rightOverflow; "leftOverflow"; $leftOverflow; \
							"isVerticalText"; Choose:C955($parsedStyle.isVerticalText=1; True:C214; False:C215); \
							"cellPadding"; $parsedStyle.cellPadding; \
							"cellBorderLeft"; $colPos{Int:C8($iterX-$range.x1+1)}; "cellBorderRight"; $colPos{Int:C8($iterX-$range.x1+2)}; \
							"shrinkToFit"; $shrinkStr; \
							"textWidth"; $textWidth; \
							"strPart"; $strPart; \
							"textOrientation"; $parsedStyle.textOrientation; \
							"borderOrientation"; $borderOrientation; \
							"borderOffset"; $borderOffset; \
							"wordWrapInfo"; $parsedStyle.wordWrapInfo; \
							"isMerged"; $cellMergeStatus.type))
						
						
					End if 
					
				End if 
				
				// ajout des elements n'affectant pas la value
				If ($parsedStyle.diagonalUpStyle>0) & (Not:C34($borderOrientation)) & ($cellMergeStatus.type=FREE)
					svg_addDULine($lineObj; $iterX; $iterY; $parsedStyle.diagonalUpStyle; $parsedStyle.diagonalUpColor; ->$colPos; ->$rowPos; $range)
				End if 
				If ($parsedStyle.diagonalDownStyle>0) & (Not:C34($borderOrientation)) & ($cellMergeStatus.type=FREE)
					svg_addDDLine($lineObj; $iterX; $iterY; $parsedStyle.diagonalDownStyle; $parsedStyle.diagonalDownColor; ->$colPos; ->$rowPos; $range)
				End if 
				
				If ($parsedStyle.topBorderStyle>0)
					$drawLine:=True:C214
					If ($cellMergeStatus.type#FREE)
						$drawLine:=$cellMergeStatus.topBorder
					End if 
					
					If ($drawLine)
						svg_addLine($lineObj; $iterX; $iterY; $parsedStyle.topBorderStyle; $parsedStyle.topBorderColor; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_TOP)
					End if 
				End if 
				
				If ($parsedStyle.leftBorderStyle>0)
					$drawLine:=True:C214
					If ($cellMergeStatus.type#FREE)
						$drawLine:=$cellMergeStatus.leftBorder
					End if 
					
					If ($drawLine)
						svg_addLine($lineObj; $iterX; $iterY; $parsedStyle.leftBorderStyle; $parsedStyle.leftBorderColor; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_LEFT)
					End if 
				End if 
				
				If ($parsedStyle.bottomBorderStyle>0)
					$drawLine:=True:C214
					If ($cellMergeStatus.type#FREE)
						$drawLine:=$cellMergeStatus.bottomBorder
					End if 
					
					If ($drawLine)
						svg_addLine($lineObj; $iterX; $iterY; $parsedStyle.bottomBorderStyle; $parsedStyle.bottomBorderColor; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_BOTTOM)
					End if 
				End if 
				
				If ($parsedStyle.rightBorderStyle>0)
					$drawLine:=True:C214
					If ($cellMergeStatus.type#FREE)
						$drawLine:=$cellMergeStatus.rightBorder
					End if 
					
					If ($drawLine)
						svg_addLine($lineObj; $iterX; $iterY; $parsedStyle.rightBorderStyle; $parsedStyle.rightBorderColor; $parsedStyle.textOrientation; $borderOrientation; $borderOffset; BORDER_RIGHT)
					End if 
				End if 
				
				If ($parsedStyle.backColor#"") & ($iterX<=$range.x2) & ($iterY<=$range.y2)
					If ($cellMergeStatus.type=EATER)
						svg_addBackColor($bcObj; $iterX; $iterY; $colPos{Int:C8($IterX-$range.x1+1)}; $rowPos{Int:C8($IterY-$range.y1+1)}; $colPos{Int:C8($iterX-$range.x1+$cellMergeStatus.colCount+1)}-$colPos{Int:C8($iterX-$range.x1+1)}; $rowPos{Int:C8($iterY-$range.y1+$cellMergeStatus.rowCount+1)}-$rowPos{Int:C8($iterY-$range.y1+1)}; $parsedStyle.backColor; $borderOffset; $borderOrientation)
					End if 
					
					If ($cellMergeStatus.type=FREE)
						svg_addBackColor($bcObj; $iterX; $iterY; $colPos{Int:C8($IterX-$range.x1+1)}; $rowPos{Int:C8($IterY-$range.y1+1)}; $colWidth; $rowHeight; $parsedStyle.backColor; $borderOffset; $borderOrientation)
					End if 
				End if 
			End if 
			
		End if 
		
	End for 
	
End for 

// MARK:- Drawing SVG Elements
svg_drawBackColor($svgRef; $bcObj.bcCol)
svg_drawBgImg($svgRef; $bgImgCol)
svg_drawCellValue($svgRef; $valCol; Choose:C955(($svgHeight>$maxSvgHeight); $maxSvgHeight; $svgHeight); Choose:C955(($svgWidth>$maxSvgWidth); $maxSvgWidth; $svgWidth))

svg_sortLineMap($lineObj; $range)

// MARK:- Drawing Gridlines
If (Value type:C1509($sheets.printInfo)=Is object:K8:27)
	If (Value type:C1509($sheets.printInfo.showGridLine)=Is boolean:K8:9)
		If ($sheets.printInfo.showGridLine=True:C214)
			svg_drawGridline($svgRef; $lineObj; $bcObj; $range; ->$colPos; ->$rowPos; $sheets.gridline; $mergeTab)
		End if 
	End if 
End if 

svg_drawLine($svgRef; $lineObj; $range; ->$colPos; ->$rowPos)
svg_drawDoubleLine($svgRef; $lineObj; $range; ->$colPos; ->$rowPos)

// MARK:- Floating Objects Handling
If ($sheets.floatingObjects#Null:C1517)
	For each ($obj; $sheets.floatingObjects)
		
		Case of 
			: ($obj.typeName="1")
				
				If (($obj.startRow>=$range.y1) & ($obj.startRow<=$range.y2) & ($obj.startColumn>=$range.x1) & ($obj.startColumn<=$range.x2)) | \
					(($obj.endRow>=$range.y1) & ($obj.endRow<=$range.y2) & ($obj.endColumn>=$range.x1) & ($obj.endColumn<=$range.x2))
					
					If (Value type:C1509($obj.x)=Is longint:K8:6) | (Value type:C1509($obj.x)=Is real:K8:4)
						$x1:=$obj.x-$startX
					Else 
						$x1:=$startX
					End if 
					
					If (Value type:C1509($obj.y)=Is longint:K8:6) | (Value type:C1509($obj.y)=Is real:K8:4)
						$y1:=$obj.y-$startY
					Else 
						$y1:=$startY
					End if 
					
					$width:=$obj.width
					$height:=$obj.height
					
					var $name : Text
					$name:=Replace string:C233($obj.name; " "; "_")
					
					$elemRef:=DOM Create XML element:C865($svgRef; "/svg/clipPath"; "id"; $name)
					$elemRef:=DOM Create XML element:C865($elemRef; "rect"; "x"; $x1; "y"; $y1; "width"; $width; "height"; $height)
					$elemRef:=DOM Create XML element:C865($svgRef; "/svg/image"; "clip-path"; "url(#"+$name+")")
					
					If (($y1+$height)>$svgHeight) & (($range.isAll=True:C214) | ($range.isAllRow=True:C214))
						$svgHeight:=$y1+$height
					End if 
					
					If (($x1+$width)>$svgWidth) & (($range.isAll=True:C214) | ($range.isAllCol=True:C214))
						$svgWidth:=$x1+$Width
					End if 
					
					//var $pictWidth; $pictHeight; $pictX; $pictY: Integer
					
					var $src : Text
					$src:=$obj.src
					
					svg_getPictSize(->$src; ->$pictWidth; ->$pictHeight)
					
					Case of 
						: ($obj.pictureStretch=Null:C1517)
							DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $x1; "y"; $y1)
							
						: ($obj.pictureStretch=1)
							$pictX:=$x1+($width/2)-($pictWidth/2)
							$pictX:=Choose:C955($pictX<$x1; $x1; $pictX)
							$pictY:=$y1+($height/2)-($pictHeight/2)
							$pictY:=Choose:C955($pictY<$y1; $y1; $pictY)
							
							DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $pictX; "y"; $pictY)
							
						Else 
							DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $x1; "y"; $y1)
							
					End case 
					
					var $layout : Text
					Case of 
						: ($obj.pictureStretch=Null:C1517)
							$layout:="none"
						: ($obj.pictureStretch=0)
							$layout:="none"
						: ($obj.pictureStretch=1)
							$layout:="xMidyMid"
						: ($obj.pictureStretch=2)
							$layout:="xMidyMid"
						: ($obj.pictureStretch=3)
							$layout:="xMinyMin"
						Else 
							$layout:="none"
					End case 
					
					DOM SET XML ATTRIBUTE:C866($elemRef; "preserveAspectRatio"; $layout)
					
					Case of 
						: ($obj.pictureStretch=Null:C1517)
							DOM SET XML ATTRIBUTE:C866($elemRef; "width"; $width; "height"; $height)
							
						: ($obj.pictureStretch=1) | ($obj.pictureStretch=3)
							DOM SET XML ATTRIBUTE:C866($elemRef; "width"; $pictWidth; "height"; $pictHeight)
							
						Else 
							DOM SET XML ATTRIBUTE:C866($elemRef; "width"; $width; "height"; $height)
							
					End case 
					
					DOM SET XML ATTRIBUTE:C866($elemRef; "xlink:href"; $src)
					
				End if 
				
			Else 
				ASSERT:C1129(Structure file:C489#Structure file:C489(*); "Floating object type not supported")
				
		End case 
	End for each 
End if 

DOM SET XML ATTRIBUTE:C866($svgRef; "x"; "0"; "y"; "0"; "width"; String:C10(Choose:C955(($svgWidth>$maxSvgWidth); $maxSvgWidth; $svgWidth)); "height"; String:C10(Choose:C955(($svgheight>$maxSvgHeight); $maxSvgHeight; $svgheight)))

//If (doSavePicture=1)
//DOM EXPORT TO FILE($svgRef; saveImgFileName)
//End if

// MARK:- Export SVG to Picture
var $svgImg : Picture

SVG EXPORT TO PICTURE:C1017($svgRef; $svgImg; Own XML data source:K45:18)
$result:=$svgImg

//Else

//$svgSource:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>"
//$svgSource:=$svgSource+"<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.2\" height=\"500\" width=\"500\"/>"

//$svgRef:=DOM Parse XML variable($svgSource)

//  //Case of
//  //: ($vpObject=Null)
//  //ASSERT(False;"Missing parameter: vpObject")
//  //: ($workbook=Null)
//  //ASSERT(False;"No workbook found in vpObject")
//  //: ($sheets=Null)
//  //ASSERT(False;"Sheet not found in workbook")
//  //: ($table=Null)
//  //ASSERT(False;"There is no value in the dataTable")
//  //Else
//  //End case

//$0:=Null
//End if

err_FINALLY
