//%attributes = {"invisible":true}
/*
printInfo := ***convert_printSettings*** ( d4 )
 -> d4 (Object)
 <- printInfo (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_printSettings
// Database: Convert4DView
// ID[F0AD4A75013B4958ACDF32A92FAFC01B]
// Created #2-10-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 10:59:50
// ----------------------------------------------------
// Definition:
// "PrintInfo": {
//      "title": "PrintInfo",
//      "description": "Represents the information to use when printing a sheet.",
//      "type": "object",
//      "properties": {
//        "bestFitRows": {
//          "type": "boolean",
//          "default": false
//        },
//        "bestFitColumns": {
//          "type": "boolean",
//          "default": false
//        },
//        "columnStart": {
//          "type": "number",
//          "default": -1
//        },
//        "columnEnd": {
//          "type": "number",
//          "default": -1
//        },
//        "rowStart": {
//          "type": "number",
//          "default": -1
//        },
//        "rowEnd": {
//          "type": "number",
//          "default": -1
//        },
//        "repeatColumnStart": {
//          "type": "number",
//          "default": -1
//        },
//        "repeatColumnEnd": {
//          "type": "number",
//          "default": -1
//        },
//        "repeatRowStart": {
//          "type": "number",
//          "default": -1
//        },
//        "repeatRowEnd": {
//          "type": "number",
//          "default": -1
//        },
//        "showBorder": {
//          "type": "boolean",
//          "default": true
//        },
//        "showGridLine": {
//          "type": "boolean",
//          "default": false
//        },
//        "showColumnHeader": {
//          "$ref": "#/definitions/PrintVisibilityType",
//          "default": 0
//        },
//        "showRowHeader": {
//          "$ref": "#/definitions/PrintVisibilityType",
//          "default": 0
//        },
//        "useMax": {
//          "type": "boolean",
//          "default": true
//        },
//        "centering": {
//          "$ref": "#/definitions/PrintCentering",
//          "default": 0
//        },
//        "firstPageNumber": {
//          "type": "number",
//          "default": 1
//        },
//        "headerLeft": {
//          "type": "string"
//        },
//        "headerCenter": {
//          "type": "string"
//        },
//        "headerRight": {
//          "type": "string"
//        },
//        "footerLeft": {
//          "type": "string"
//        },
//        "footerCenter": {
//          "type": "string"
//        },
//        "footerRight": {
//          "type": "string"
//        },
//        "headerLeftImage": {
//          "type": "string"
//        },
//        "headerCenterImage": {
//          "type": "string"
//        },
//        "headerRightImage": {
//          "type": "string"
//        },
//        "footerLeftImage": {
//          "type": "string"
//        },
//        "footerCenterImage": {
//          "type": "string"
//        },
//        "footerRightImage": {
//          "type": "string"
//        },
//        "margin": {
//          "$ref": "#/definitions/PrintMargins"
//        },
//        "orientation": {
//          "$ref": "#/definitions/PrintPageOrientation",
//          "default": 1
//        },
//        "pageRange": {
//          "type": "string"
//        },
//        "pageOrder": {
//          "$ref": "#/definitions/PrintPageOrder",
//          "default": 0
//        },
//        "blackAndWhite": {
//          "type": "boolean",
//          "default": false
//        },
//        "zoomFactor": {
//          "type": "number",
//          "default": 1
//        },
//        "fitPagesTall": {
//          "type": "number",
//          "default": -1
//        },
//        "fitPagesWide": {
//          "type": "number",
//          "default": -1
//        },
//        "paperSize": {
//          "$ref": "#/definitions/PaperSize"
//        }
//      }
//    },
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($0)
C_OBJECT:C1216($1)

C_LONGINT:C283($Lon_i; $nbParameters)
C_TEXT:C284($Txt_style)
C_OBJECT:C1216($Obj_d4; $Obj_printInfo)

If (False:C215)
	C_OBJECT:C1216(convert_printSettings; $0)
	C_OBJECT:C1216(convert_printSettings; $1)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Obj_d4:=$1
	
	// Optional parameters
	If ($nbParameters>=2)
		
		// <NONE>
		
	End if 
	
	$Obj_printInfo:=New object:C1471
	
Else 
	
	ABORT:C156
	
End if 

If (False:C215)
	
	// "printSettings": {
	// "leftMargin": 16,
	// "topMargin": 16,
	// "rightMargin": 16,
	// "bottomMargin": 16,
	// "borders": true,
	// "headers": false,
	// "grid": true,
	// "centered": false,
	// "compact": false,
	// "firstRow": 0,
	// "lastRow": 0,
	// "firstColumn": 0,
	// "lastColumn": 0,
	// "ranges": [],
	// "style": {
	// "locked": false,
	// "visible": true,
	// "showGrid": true,
	// "spellCheck": false,
	// "pictHeights": false,
	// "inputFilter": 0,
	// "backColorEven": 16777215,
	// "backColorOdd": 16777215,
	// "fontID": 6,
	// "fontSize": 14,
	// "bold": false,
	// "italic": false,
	// "underline": false,
	// "outline": false,
	// "shadow": false,
	// "condensed": false,
	// "extended": false,
	// "normalColorEven": 16711680,
	// "normalColorOdd": 16711680,
	// "zeroColorEven": 255,
	// "zeroColorOdd": 255,
	// "minusColorEven": 16711680,
	// "minusColorOdd": 16711680,
	// "hAlign": 0,
	// "vAlign": 0,
	// "rotation": 0,
	// "wordWrap": false,
	// "forceTextFormat": false,
	// "numericFormat": 0,
	// "stringFormat": 0,
	// "boolFormat": 0,
	// "dateTimeFormat": 0,
	// "pictureFormat": 0
	//},
	// "topLeft": null,
	// "topCenter": null,
	// "topRight": null,
	// "bottomLeft": null,
	// "bottomCenter": null,
	// "bottomRight": null
	//},
	
End if 

// ----------------------------------------------------
If (False:C215)
	If ($Obj_d4.paperSettings#Null:C1517)
		
		If (False:C215)
			
			// "PaperSize": {
			//      "title": "PaperSize",
			//      "description": "Specifies the paper size.",
			//      "properties": {
			//        "height": {
			//          "type": "number"
			//        },
			//        "width": {
			//          "type": "number"
			//        },
			//        "kind": {
			//          "$ref": "#/definitions/PaperKind"
			//        }
			//      }
			//    },
			//
			//    "PaperKind": {
			//      "title": "PaperKind",
			//      "description": "Specifies the paper kind for the printed page.
			// 0 : custom,
			// 1 : letter,
			// 2 : letterSmall,
			// 3 : tabloid,
			// 4 : ledger,
			// 5 : legal,
			// 6 : statement,
			// 7 : executive,
			// 8 : a3,
			// 9 : a4,
			// 10 : a4Small,
			// 11 : a5,
			// 12 : b4,
			// 13 : b5,
			// 14 : folio,
			// 15 : quarto,
			// 16 : standard10x14,
			// 17 : standard11x17,
			// 18 : note,
			// 19 : number9Envelope,
			// 20 : number10Envelope,
			// 21 : number11Envelope,
			// 22 : number12Envelope,
			// 23 : number14Envelope,
			// 24 : cSheet,
			// 25 : dSheet,
			// 26 : eSheet,
			// 27 : dLEnvelope,
			// 28 : c5Envelope,
			// 29 : c3Envelope,
			// 30 : c4Envelope,
			// 31 : c6Envelope,
			// 32 : c65Envelope,
			// 33 : b4Envelope,
			// 34 : b5Envelope,
			// 35 : b6Envelope,
			// 36 : italyEnvelope,
			// 37 : monarchEnvelope,
			// 38 : personalEnvelope,
			// 39 : uSStandardFanfold,
			// 40 : germanStandardFanfold,
			// 41 : germanLegalFanfold,
			// 42 : isoB4,
			// 43 : japanesePostcard,
			// 44 : standard9x11,
			// 45 : standard10x11,
			// 46 : standard15x11,
			// 47 : inviteEnvelope,
			// 50 : letterExtra,
			// 51 : legalExtra,
			// 52 : tabloidExtra,
			// 53 : a4Extra,
			// 54 : letterTransverse,
			// 55 : a4Transverse,
			// 56 : letterExtraTransverse,
			// 57 : aPlus,
			// 58 : bPlus,
			// 59 : letterPlus,
			// 60 : a4Plus,
			// 61 : a5Transverse,
			// 62 : b5Transverse,
			// 63 : a3Extra,
			// 64 : a5Extra,
			// 65 : b5Extra,
			// 66 : a2,
			// 67 : a3Transverse,
			// 68 : a3ExtraTransverse,
			// 69 : japaneseDoublePostcard,
			// 70 : a6,
			// 71 : japaneseEnvelopeKakuNumber2,
			// 72 : japaneseEnvelopeKakuNumber3,
			// 73 : japaneseEnvelopeChouNumber3,
			// 74 : japaneseEnvelopeChouNumber4,
			// 75 : letterRotated,
			// 76 : a3Rotated,
			// 77 : a4Rotated,
			// 78 : a5Rotated,
			// 79 : b4JisRotated,
			// 80 : b5JisRotated,
			// 81 : japanesePostcardRotated,
			// 82 : japaneseDoublePostcardRotated,
			// 83 : a6Rotated,
			// 84 : japaneseEnvelopeKakuNumber2Rotated,
			// 85 : japaneseEnvelopeKakuNumber3Rotated,
			// 86 : japaneseEnvelopeChouNumber3Rotated,
			// 87 : japaneseEnvelopeChouNumber4Rotated,
			// 88 : b6Jis,
			// 89 : b6JisRotated,
			// 90 : standard12x11,
			// 91 : japaneseEnvelopeYouNumber4,
			// 92 : japaneseEnvelopeYouNumber4Rotated,
			// 93 : prc16K,
			// 94 : prc32K,
			// 95 : prc32KBig,
			// 96 : prcEnvelopeNumber1,
			// 97 : prcEnvelopeNumber2,
			// 98 : prcEnvelopeNumber3,
			// 99 : prcEnvelopeNumber4,
			// 100 : prcEnvelopeNumber5,
			// 101 : prcEnvelopeNumber6,
			// 102 : prcEnvelopeNumber7,
			// 103 : prcEnvelopeNumber8,
			// 104 : prcEnvelopeNumber9,
			// 105 : prcEnvelopeNumber10,
			// 106 : prc16KRotated,
			// 107 : prc32KRotated,
			// 108 : prc32KBigRotated,
			// 109 : prcEnvelopeNumber1Rotated,
			// 110 : prcEnvelopeNumber2Rotated,
			// 111 : prcEnvelopeNumber3Rotated,
			// 112 : prcEnvelopeNumber4Rotated,
			// 113 : prcEnvelopeNumber5Rotated,
			// 114 : prcEnvelopeNumber6Rotated,
			// 115 : prcEnvelopeNumber7Rotated,
			// 116 : prcEnvelopeNumber8Rotated,
			// 117 : prcEnvelopeNumber9Rotated,
			// 118 : prcEnvelopeNumber10Rotated"
			//    },
		End if 
		
		$Obj_printInfo.paperSize:=New object:C1471(\
			"kind"; $Obj_d4.paperSettings.kind; \
			"width"; $Obj_d4.paperSettings.width*$Obj_d4._default.sizeConversionFactor; \
			"height"; $Obj_d4.paperSettings.height*$Obj_d4._default.sizeConversionFactor)
		
		If (False:C215)
			
			//   "PrintPageOrientation": {
			//      "title": "PrintPageOrientation",
			//      "description": "Specifies the page orientation used for printing. portrait:1, landscape:2",
			//      "enum": [
			//        1,
			//        2
			//      ]
			//    },
		End if 
		
		//$Obj_printInfo.orientation:=$Obj_d4.paperSettings.landscape+1
		
		If (False:C215)
			
			// "PrintMargins": {
			//      "title": "PrintMargins",
			//      "description": "Specifies the dimensions of the printed page margins.",
			//      "type": "object",
			//      "properties": {
			//        "top": {
			//          "type": "number",
			//          "default": 75
			//        },
			//        "bottom": {
			//          "type": "number",
			//          "default": 75
			//        },
			//        "left": {
			//          "type": "number",
			//          "default": 70
			//        },
			//        "right": {
			//          "type": "number",
			//          "default": 70
			//        },
			//        "header": {
			//          "type": "number",
			//          "default": 30
			//        },
			//        "footer": {
			//          "type": "number",
			//          "default": 30
			//        }
			//      }
			//    },
		End if 
		
		$Obj_printInfo.margin:=New object:C1471(\
			"left"; $Obj_d4.paperSettings.userLeftMargin; \
			"right"; $Obj_d4.paperSettings.userRightMargin; \
			"top"; $Obj_d4.paperSettings.userTopMargin; \
			"bottom"; $Obj_d4.paperSettings.userBottomMargin)
		
	End if 
	
	//    "PrintCentering": {
	//      "title": "PrintCentering",
	//      "description": "Specifies the type of centering for the printed page. none:0, horizontal:1, vertical:2, both:3",
	//      "enum": [
	//        0,
	//        1,
	//        2,
	//        3
	//      ]
	//    },
	
	$Obj_printInfo.centering:=Choose:C955(Bool:C1537($Obj_d4.printSettings.centered); 3; 0)
	
	$Obj_printInfo.showBorder:=$Obj_d4.printSettings.borders
End if 

If ($Obj_d4.printSettings.headers)
	
	$Obj_printInfo.showColumnHeader:=2
	$Obj_printInfo.showRowHeader:=2
	
Else 
	
	$Obj_printInfo.showColumnHeader:=1
	$Obj_printInfo.showRowHeader:=1
	
End if 

$Obj_printInfo.showGridLine:=$Obj_d4.printSettings.grid

If (False:C215)
	
	If ($Obj_d4.printSettings.firstRow>0)
		
		$Obj_printInfo.repeatRowStart:=$Obj_d4.printSettings.firstRow-1
		
	End if 
	
	If ($Obj_d4.printSettings.lastRow>0)
		
		$Obj_printInfo.repeatRowEnd:=$Obj_d4.printSettings.lastRow-1
		
	End if 
	
	If ($Obj_d4.printSettings.firstColumn>0)
		
		$Obj_printInfo.repeatColumnStart:=$Obj_d4.printSettings.firstColumn-1
		
	End if 
	
	If ($Obj_d4.printSettings.lastColumn>0)
		
		$Obj_printInfo.repeatColumnEnd:=$Obj_d4.printSettings.lastColumn-1
		
	End if 
	
	// Headers & footers [
	If ($Obj_d4.printSettings.topLeft#Null:C1517)\
		 | ($Obj_d4.printSettings.topCenter#Null:C1517)\
		 | ($Obj_d4.printSettings.topRight#Null:C1517)\
		 | ($Obj_d4.printSettings.bottomLeft#Null:C1517)\
		 | ($Obj_d4.printSettings.bottomCenter#Null:C1517)\
		 | ($Obj_d4.printSettings.bottomRight#Null:C1517)
		
		If ($Obj_d4.printSettings.style#Null:C1517)
			
			// http://help.grapecity.com/spread/SpreadSheets10/webframe.html#printsheet.html
			// U Underlinesheet.printInfo().headerLeft("&UThis is text.");This is text.
			// B Boldsheet.printInfo().headerLeft("&BThis is text.");This is text.
			// I Italicsheet.printInfo().headerLeft("&IThis is text.");This is text.
			// "Font prefixsheet.printInfo().headerLeft("&\"Lucida Console\"This is text.");This is text.
			// K Color prefixsheet.printInfo().headerLeft("&KFF0000This is text.");This is text.
			
			If ($Obj_d4.printSettings.style.underline)
				
				$Txt_style:=$Txt_style+"&U"
				
			End if 
			
			If ($Obj_d4.printSettings.style.italic)
				
				$Txt_style:=$Txt_style+"&I"
				
			End if 
			
			If ($Obj_d4.printSettings.style.bold)
				
				$Txt_style:=$Txt_style+"&B"
				
			End if 
			
			If ($Obj_d4.printSettings.style.normalColorEven#0x0000)
				
				$Txt_style:=$Txt_style+"&K"+"#"+Substring:C12(String:C10($Obj_d4.printSettings.style.normalColorEven+0x01000000; "&x"); 5)
				
			End if 
			
			If ($Obj_d4.printSettings.style.fontID#Null:C1517)
				
				// Find the correspondent font name
				For ($Lon_i; 0; $Obj_d4.fontNames.length-1; 1)
					
					If ($Obj_d4.fontNames[$Lon_i].id=$Obj_d4.printSettings.style.fontID)
						
						$Txt_style:=$Txt_style+"&\""+$Obj_d4.fontNames[$Lon_i].name+"\""
						$Lon_i:=$Obj_d4.fontNames.length
						
					End if 
				End for 
			End if 
		End if 
		
		If ($Obj_d4.printSettings.topLeft#Null:C1517)
			
			$Obj_printInfo.headerLeft:=$Txt_style+convert_headerAndFooterTags(String:C10($Obj_d4.printSettings.topLeft))
			
		End if 
		
		If ($Obj_d4.printSettings.topCenter#Null:C1517)
			
			$Obj_printInfo.headerCenter:=$Txt_style+convert_headerAndFooterTags(String:C10($Obj_d4.printSettings.topCenter))
			
		End if 
		
		If ($Obj_d4.printSettings.topRight#Null:C1517)
			
			$Obj_printInfo.headerRight:=$Txt_style+convert_headerAndFooterTags(String:C10($Obj_d4.printSettings.topRight))
			
		End if 
		
		If ($Obj_d4.printSettings.bottomLeft#Null:C1517)
			
			$Obj_printInfo.footerLeft:=$Txt_style+convert_headerAndFooterTags(String:C10($Obj_d4.printSettings.bottomLeft))
			
		End if 
		
		If ($Obj_d4.printSettings.bottomCenter#Null:C1517)
			
			$Obj_printInfo.footerCenter:=$Txt_style+convert_headerAndFooterTags(String:C10($Obj_d4.printSettings.bottomCenter))
			
		End if 
		
		If ($Obj_d4.printSettings.bottomRight#Null:C1517)
			
			$Obj_printInfo.footerRight:=$Txt_style+convert_headerAndFooterTags(String:C10($Obj_d4.printSettings.bottomRight))
			
		End if 
	End if 
	//]
	
	If ($Obj_d4.printSettings.ranges.length>0)
		
		$Obj_printInfo.rowStart:=$Obj_d4.printSettings.ranges[0].top-1
		$Obj_printInfo.rowEnd:=$Obj_d4.printSettings.ranges[0].bottom-1
		$Obj_printInfo.columnStart:=$Obj_d4.printSettings.ranges[0].left-1
		$Obj_printInfo.columnEnd:=$Obj_d4.printSettings.ranges[0].right-1
		
	End if 
End if 
// ----------------------------------------------------
// Return
$0:=$Obj_printInfo

// ----------------------------------------------------
// End