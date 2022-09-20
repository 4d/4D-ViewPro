Class constructor()
	This:C1470._bestFitColumns:=False:C215
	This:C1470._bestFitRows:=False:C215
	This:C1470._blackAndWhite:=False:C215
	This:C1470._centering:=0
	This:C1470._columnEnd:=-1
	This:C1470._columnStart:=-1
	This:C1470._firstPageNumber:=1
	This:C1470._fitPagesTall:=-1
	This:C1470._fitPagesWide:=-1
	This:C1470._footerCenter:=""
	This:C1470._footerCenterImage:=""
	This:C1470._footerLeft:=""
	This:C1470._footerLeftImage:=""
	This:C1470._footerRight:=""
	This:C1470._footerRightImage:=""
	This:C1470._headerCenter:=""
	This:C1470._headerCenterImage:=""
	This:C1470._headerLeft:=""
	This:C1470._headerLeftImage:=""
	This:C1470._headerRight:=""
	This:C1470._headerRightImage:=""
	This:C1470._margin:=cs:C1710.Margins.new()
	This:C1470._orientation:=1
	This:C1470._pageOrder:=0
	This:C1470._pageRange:=""
	This:C1470._paperSize:=cs:C1710.PaperSize.new()
	This:C1470._qualityFactor:=2
	This:C1470._repeatColumnEnd:=-1
	This:C1470._repeatColumnStart:=-1
	This:C1470._repeatRowEnd:=-1
	This:C1470._repeatRowStart:=-1
	This:C1470._rowEnd:=-1
	This:C1470._rowStart:=-1
	This:C1470._showBorder:=True:C214
	This:C1470._showColumnHeader:=0
	This:C1470._showGridLine:=False:C215
	This:C1470._showRowHeader:=0
	This:C1470._useMax:=True:C214
	This:C1470._watermark:=New collection:C1472
	This:C1470._zoomFactor:=1

	// getter
Function get bestFitColumns : Boolean
	return This:C1470._bestFitColumns
	
Function get bestFitRows : Boolean
	return This:C1470._bestFitRows
	
Function get blackAndWhite : Boolean
	return This:C1470._blackAndWhite
	
Function get centering : Integer
	return This:C1470._centering
	
Function get columnEnd : Integer
	return This:C1470._columnEnd
	
Function get columnStart : Integer
	return This:C1470._columnStart
	
Function get firstPageNumber : Integer
	return This:C1470._firstPageNumber
	
Function get fitPagesTall : Integer
	return This:C1470._fitPagesTall
	
Function get fitPagesWide : Integer
	return This:C1470._fitPagesWide
	
Function get footerCenter : Text
	return This:C1470._footerCenter
	
Function get footerCenterImage : Text
	return This:C1470._footerCenterImage
	
Function get footerLeft : Text
	return This:C1470._footerLeft
	
Function get footerLeftImage : Text
	return This:C1470._footerLeftImage
	
Function get footerRight : Text
	return This:C1470._footerRight
	
Function get footerRightImage : Text
	return This:C1470._footerRightImage
	
Function get headerCenter : Text
	return This:C1470._headerCenter
	
Function get headerCenterImage : Text
	return This:C1470._headerCenterImage
	
Function get headerLeft : Text
	return This:C1470._headerLeft
	
Function get headerLeftImage : Text
	return This:C1470._headerLeftImage
	
Function get headerRight : Text
	return This:C1470._headerRight
	
Function get headerRightImage : Text
	return This:C1470._headerRightImage
	
Function get margin : cs:C1710.Margins
	return This:C1470._margin
	
Function get orientation : Integer
	return This:C1470._orientation
	
Function get pageOrder : Integer
	return This:C1470._pageOrder
	
Function get pageRange : Text
	return This:C1470._pageRange
	
Function get paperSize : cs:C1710.PaperSize
	return This:C1470._paperSize
	
Function get qualityFactor : Integer
	return This:C1470._qualityFactor
	
Function get repeatColumnEnd : Integer
	return This:C1470._repeatColumnEnd
	
Function get repeatColumnStart : Integer
	return This:C1470._repeatColumnStart
	
Function get repeatRowEnd : Integer
	return This:C1470._repeatRowEnd
	
Function get repeatRowStart : Integer
	return This:C1470._repeatRowStart
	
Function get rowEnd : Integer
	return This:C1470._rowEnd
	
Function get rowStart : Integer
	return This:C1470._rowStart
	
Function get showBorder : Boolean
	return This:C1470._showBorder
	
Function get showColumnHeader : Integer
	return This:C1470._showColumnHeader
	
Function get showGridLine : Boolean
	return This:C1470._showGridLine
	
Function get showRowHeader : Integer
	return This:C1470._showRowHeader
	
Function get useMax : Boolean
	return This:C1470._useMax
	
Function get watermark : Collection
	return This:C1470._watermark
	
Function get zoomFactor : Integer
	return This:C1470._zoomFactor

	// setter
Function set bestFitColumns($param1 : Boolean)
	This:C1470._bestFitColumns:=$param1
	
Function set bestFitRows($param1 : Boolean)
	This:C1470._bestFitRows:=$param1
	
Function set blackAndWhite($param1 : Boolean)
	This:C1470._blackAndWhite:=$param1
	
Function set centering($param1 : Integer)
	This:C1470._centering:=$param1
	
Function set columnEnd($param1 : Integer)
	This:C1470._columnEnd:=$param1
	
Function set columnStart($param1 : Integer)
	This:C1470._columnStart:=$param1
	
Function set firstPageNumber($param1 : Integer)
	This:C1470._firstPageNumber:=$param1
	
Function set fitPagesTall($param1 : Integer)
	This:C1470._fitPagesTall:=$param1
	
Function set fitPagesWide($param1 : Integer)
	This:C1470._fitPagesWide:=$param1
	
Function set footerCenter($param1 : Text)
	This:C1470._footerCenter:=$param1
	
Function set footerCenterImage($param1 : Text)
	This:C1470._footerCenterImage:=$param1
	
Function set footerLeft($param1 : Text)
	This:C1470._footerLeft:=$param1
	
Function set footerLeftImage($param1 : Text)
	This:C1470._footerLeftImage:=$param1
	
Function set footerRight($param1 : Text)
	This:C1470._footerRight:=$param1
	
Function set footerRightImage($param1 : Text)
	This:C1470._footerRightImage:=$param1
	
Function set headerCenter($param1 : Text)
	This:C1470._headerCenter:=$param1
	
Function set headerCenterImage($param1 : Text)
	This:C1470._headerCenterImage:=$param1
	
Function set headerLeft($param1 : Text)
	This:C1470._headerLeft:=$param1
	
Function set headerLeftImage($param1 : Text)
	This:C1470._headerLeftImage:=$param1
	
Function set headerRight($param1 : Text)
	This:C1470._headerRight:=$param1
	
Function set headerRightImage($param1 : Text)
	This:C1470._headerRightImage:=$param1
	
Function set margin($param1 : cs:C1710.Margins)
	This:C1470._margin:=$param1
	
Function set orientation($param1 : Integer)
	This:C1470._orientation:=$param1
	
Function set pageOrder($param1 : Integer)
	This:C1470._pageOrder:=$param1
	
Function set pageRange($param1 : Text)
	This:C1470._pageRange:=$param1
	
Function set paperSize($param1 : cs:C1710.PaperSize)
	This:C1470._paperSize:=$param1
	
Function set qualityFactor($param1 : Integer)
	This:C1470._qualityFactor:=$param1
	
Function set repeatColumnEnd($param1 : Integer)
	This:C1470._repeatColumnEnd:=$param1
	
Function set repeatColumnStart($param1 : Integer)
	This:C1470._repeatColumnStart:=$param1
	
Function set repeatRowEnd($param1 : Integer)
	This:C1470._repeatRowEnd:=$param1
	
Function set repeatRowStart($param1 : Integer)
	This:C1470._repeatRowStart:=$param1
	
Function set rowEnd($param1 : Integer)
	This:C1470._rowEnd:=$param1
	
Function set rowStart($param1 : Integer)
	This:C1470._rowStart:=$param1
	
Function set showBorder($param1 : Boolean)
	This:C1470._showBorder:=$param1
	
Function set showColumnHeader($param1 : Integer)
	This:C1470._showColumnHeader:=$param1
	
Function set showGridLine($param1 : Boolean)
	This:C1470._showGridLine:=$param1
	
Function set showRowHeader($param1 : Integer)
	This:C1470._showRowHeader:=$param1
	
Function set useMax($param1 : Boolean)
	This:C1470._useMax:=$param1
	
Function set watermark($param1 : Collection)
	This:C1470._watermark:=$param1
	
Function set zoomFactor($param1 : Integer)
	This:C1470._zoomFactor:=$param1
	