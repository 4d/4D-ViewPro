//%attributes = {"invisible":true}
/*
floatingObjects := ***convert_pictures*** ( pictures ; viewPro )
 -> pictures (Collection)
 -> viewPro (Object)
 <- floatingObjects (Collection)
________________________________________________________
*/

// ----------------------------------------------------
// Project method : convert_resources
// Database: Convert4DView
// ID[843E56CD046C4F658499EA9EF0780F27]
// Created #29-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// User name (OS): wilofice
// Date and time: 16-08-17, 10:59:32
// ----------------------------------------------------
// Description:
// "Picture": {
//      "title": "Picture",
//      "description": "Represents a picture.",
//      "type": "object",
//      "properties": {
//        "name": {
//          "type": "string"
//        },
//        "x": {
//          "type": "number",
//          "default": 0
//        },
//        "y": {
//          "type": "number",
//          "default": 0
//        },
//        "width": {
//          "type": "number",
//          "default": 0
//        },
//        "height": {
//          "type": "number",
//          "default": 0
//        },
//        "canPrint": {
//          "type": "boolean",
//          "default": true
//        },
//        "isSelected": {
//          "type": "boolean",
//          "default": false
//        },
//        "isLocked": {
//          "type": "boolean",
//          "default": true
//        },
//        "isVisible": {
//          "type": "boolean",
//          "default": true
//        },
//        "dynamicMove": {
//          "type": "boolean",
//          "default": true
//        },
//        "dynamicSize": {
//          "type": "boolean",
//          "default": true
//        },
//        "fixedPosition": {
//          "type": "boolean"
//        },
//        "allowResize": {
//          "type": "boolean",
//          "default": true
//        },
//        "allowMove": {
//          "type": "boolean",
//          "default": true
//        },
//        "typeName": {
//          "type": "string"
//        },
//        "src": {
//          "type": "string"
//        },
//        "backColor": {
//          "type": "string"
//        },
//        "borderRadius": {
//          "type": "number",
//          "default": -1
//        },
//        "borderWidth": {
//          "type": "number",
//          "default": 1
//        },
//        "borderStyle": {
//          "type": "string",
//          "default": "none"
//        },
//        "borderColor": {
//          "type": "string"
//        },
//        "pictureStretch": {
//          "$ref": "#/definitions/ImageLayout",
//          "default": 0
//        }
//      }
//    },
// "ImageLayout": {
//      "title": "ImageLayout",
//      "description": "Defines the image layout. stretch:0, center:1, zoom:2, none:3.",
//      "enum": [
//        0,
//        1,
//        2,
//        3
//      ]
//    }
// ----------------------------------------------------
// Declarations
C_COLLECTION:C1488($0)
C_COLLECTION:C1488($1)
C_OBJECT:C1216($2)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($kLon_centered; $kLon_none; $kLon_stretch; $kLon_zoom; $Lon_height)
C_LONGINT:C283($Lon_i; $nbParameters; $Lon_picture; $Lon_width; $Lon_x; $Lon_y)
C_LONGINT:C283($wanted_codec)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Dom_pattern; $Dom_rect; $Dom_svg; $Txt_image; $Txt_pictureName; $codec)
C_OBJECT:C1216($Obj_default; $Obj_picture; $Obj_viewPro)
C_COLLECTION:C1488($Col_floatingObjects; $Col_pictures)
C_REAL:C285($kNum_sizeConversionFactor)
C_LONGINT:C283($convert_unique_id)

ARRAY LONGINT:C221($tLon_columnWidth; 0)
ARRAY LONGINT:C221($tLon_rowHeight; 0)
ARRAY TEXT:C222($ktTxt_codecs; 0)
ARRAY TEXT:C222($tTxt_codecs; 0)

If (False:C215)
	C_COLLECTION:C1488(convert_pictures; $0)
	C_COLLECTION:C1488(convert_pictures; $1)
	C_OBJECT:C1216(convert_pictures; $2)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Col_pictures:=$1
	
	// Optional parameters
	If ($nbParameters>=2)
		
		$Obj_viewPro:=$2
		
		$Obj_default:=$Obj_viewPro.spreadJS.sheets.Sheet1.defaults
		
	End if 
	
	$kLon_stretch:=0
	$kLon_centered:=1
	$kLon_zoom:=2
	$kLon_none:=3
	$kNum_sizeConversionFactor:=0.06666666666667
	
	APPEND TO ARRAY:C911($ktTxt_codecs; ".png")
	APPEND TO ARRAY:C911($ktTxt_codecs; ".jpg")
	APPEND TO ARRAY:C911($ktTxt_codecs; ".gif")
	
	$Col_floatingObjects:=New collection:C1472
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If ($Obj_viewPro.spreadJS.sheets.Sheet1.columns#Null:C1517)
	
	COLLECTION TO ARRAY:C1562($Obj_viewPro.spreadJS.sheets.Sheet1.columns.extract("size"); $tLon_columnWidth)
	$tLon_columnWidth{0}:=Size of array:C274($tLon_columnWidth)
	
End if 

If ($Obj_viewPro.spreadJS.sheets.Sheet1.rows#Null:C1517)
	
	COLLECTION TO ARRAY:C1562($Obj_viewPro.spreadJS.sheets.Sheet1.rows.extract("size"); $tLon_rowHeight)
	$tLon_rowHeight{0}:=Size of array:C274($tLon_rowHeight)
	
End if 

For ($Lon_picture; 0; $Col_pictures.length-1; 1)
	
	If ($Col_pictures[$Lon_picture].picture#Null:C1517)
		
		$Pic_buffer:=$Col_pictures[$Lon_picture].picture
		PICTURE PROPERTIES:C457($Pic_buffer; $Lon_width; $Lon_height)
		GET PICTURE FORMATS:C1406($Pic_buffer; $tTxt_codecs)
		
		$Lon_i:=1
		
		While (($Lon_i<=Size of array:C274($ktTxt_codecs)) & ($codec=""))
			$wanted_codec:=Find in array:C230($tTxt_codecs; $ktTxt_codecs{$Lon_i})
			If ($wanted_codec#-1)
				$codec:=$ktTxt_codecs{$Lon_i}
			End if 
			$Lon_i:=$Lon_i+1
		End while 
		
		If ($codec="")
			$codec:=".png"
		End if 
	Else 
		READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"UnsupportedPict_64.png"; $Pic_buffer)
		$codec:=".png"
	End if 
	
	If ($Col_pictures[$Lon_picture].behind)  // Background image
		
		PICTURE TO BLOB:C692($Pic_buffer; $Blb_buffer; $codec)
		BASE64 ENCODE:C895($Blb_buffer; $Txt_image)
		CLEAR VARIABLE:C89($Blb_buffer)
		
		$Obj_viewPro.spreadJS.backgroundImage:="data:"+"image/"+Delete string:C232($codec; 1; 1)+";base64,"+$Txt_image
		
		$Obj_viewPro.spreadJS.backgroundImageLayout:=Choose:C955(Num:C11($Col_pictures[$Lon_picture].drawingMode); \
			$kLon_stretch; \
			$kLon_none; \
			$kLon_centered; \
			$kLon_zoom; \
			$kLon_zoom; \
			$kLon_stretch; \
			$kLon_zoom)
		
	Else 
		
		If ($Col_pictures[$Lon_picture].formula#Null:C1517)
			$Txt_pictureName:="UNSUPPORTED_FORMULA_REF_"+String:C10($Col_pictures[$Lon_picture].formula)+"_"+String:C10($convert_unique_id)
			$convert_unique_id:=$convert_unique_id+1
		Else 
			If ($Col_pictures[$Lon_picture].table#Null:C1517)
				$Txt_pictureName:="UNSUPPORTED_FIELD_REF_"+String:C10($Col_pictures[$Lon_picture].table)+"_"+String:C10($Col_pictures[$Lon_picture].field)+"_"+String:C10($convert_unique_id)
				$convert_unique_id:=$convert_unique_id+1
			Else 
				$Txt_pictureName:="image_"+String:C10($Lon_picture+1)
			End if 
		End if 
		
		// Calculate x position [
		$Lon_x:=0
		
		For ($Lon_i; 1; $Col_pictures[$Lon_picture].column-1; 1)
			
			If ($Lon_i<=$tLon_columnWidth{0})
				
				If ($tLon_columnWidth{$Lon_i}=0)
					
					// Append default width
					$Lon_x:=$Lon_x+$Obj_default.colWidth
					
				Else 
					
					$Lon_x:=$Lon_x+$tLon_columnWidth{$Lon_i}
					
				End if 
				
			Else 
				
				// Append default width
				$Lon_x:=$Lon_x+$Obj_default.colWidth
				
			End if 
		End for 
		//]
		
		// Calculate y position [
		$Lon_y:=0
		
		For ($Lon_i; 1; $Col_pictures[$Lon_picture].row-1; 1)
			
			If ($Lon_i<=$tLon_rowHeight{0})
				
				If ($tLon_rowHeight{$Lon_i}=0)
					
					// Append default height
					$Lon_y:=$Lon_y+$Obj_default.rowHeight
					
				Else 
					
					$Lon_y:=$Lon_y+$tLon_rowHeight{$Lon_i}
					
				End if 
				
			Else 
				
				// Append default height
				$Lon_y:=$Lon_y+$Obj_default.rowHeight
				
			End if 
		End for 
		//]
		
		$Obj_picture:=New object:C1471(\
			"typeName"; "1"; \
			"name"; $Txt_pictureName; \
			"x"; $Lon_x+($Col_pictures[$Lon_picture].hOffset*$kNum_sizeConversionFactor); \
			"y"; $Lon_y+($Col_pictures[$Lon_picture].vOffset*$kNum_sizeConversionFactor); \
			"width"; $Col_pictures[$Lon_picture].width*$kNum_sizeConversionFactor; \
			"height"; $Col_pictures[$Lon_picture].height*$kNum_sizeConversionFactor)
		
		If ($Obj_picture.x=0)
			
			OB REMOVE:C1226($Obj_picture; "x")
			
		End if 
		
		If ($Obj_picture.y=0)
			
			OB REMOVE:C1226($Obj_picture; "y")
			
		End if 
		
		Case of 
				
				//______________________________________________________
			: ($Col_pictures[$Lon_picture].locked)
				
				$Obj_picture.isLocked:=True:C214
				$Obj_picture.allowMove:=False:C215
				$Obj_picture.allowResize:=False:C215
				
				//______________________________________________________
			: ($Col_pictures[$Lon_picture].fixedSize)
				
				$Obj_picture.allowResize:=False:C215
				
				//______________________________________________________
		End case 
		
		//#####################################################################
		//# drawingMode values are not the same as 4D Picture Display formats #
		//# DON'T USE THE 4D CONSTANTS                                        #
		//#####################################################################
		
		Case of 
				
				//______________________________________________________
			: (Num:C11($Col_pictures[$Lon_picture].drawingMode)=2)  // pv mapping truncated centered
				
				var $svg : Text
				$svg:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; \
					"xmlns:xlink"; "http://www.w3.org/1999/xlink")
				
				DOM SET XML ATTRIBUTE:C866($svg; \
					"width"; String:C10($Col_pictures[$Lon_picture].width*$kNum_sizeConversionFactor; "&xml"); \
					"height"; String:C10($Col_pictures[$Lon_picture].height*$kNum_sizeConversionFactor))
				
				// TODO: use a translate in percent to allow resize
				
				$Lon_x:=(($Col_pictures[$Lon_picture].width*$kNum_sizeConversionFactor)-$Lon_width)\2
				$Lon_y:=(($Col_pictures[$Lon_picture].height*$kNum_sizeConversionFactor)-$Lon_height)\2
				
				var $encoded; $image : Text
				PICTURE TO BLOB:C692($Pic_buffer; $Blb_buffer; $codec)
				BASE64 ENCODE:C895($Blb_buffer; $encoded)
				SET BLOB SIZE:C606($Blb_buffer; 0)
				
				$image:=DOM Create XML element:C865($svg; "image"; \
					"xlink:href"; "data:image/"+Delete string:C232($codec; 1; 1)+";"+\
					"base64,"+$encoded; "x"; \
					$Lon_x; "y"; \
					$Lon_y; "width"; \
					$Lon_width; "height"; \
					$Lon_height)
				
				SVG EXPORT TO PICTURE:C1017($svg; $Pic_Buffer; Copy XML data source:K45:17)
				DOM CLOSE XML:C722($svg)
				
				$Obj_picture.pictureStretch:=$kLon_none  // 1
				
				//______________________________________________________
			: (Num:C11($Col_pictures[$Lon_picture].drawingMode)=3)  // pv mapping replicated
				
				// Define the picture as pattern
				$svg:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg"; \
					"xmlns:xlink"; "http://www.w3.org/1999/xlink")
				
				$Dom_pattern:=DOM Create XML element:C865(DOM Create XML element:C865($svg; "defs"); "pattern"; \
					"id"; "MyPattern"; \
					"patternUnits"; "userSpaceOnUse"; \
					"width"; $Lon_width; \
					"height"; $Lon_height)
				
				PICTURE TO BLOB:C692($Pic_buffer; $Blb_buffer; $codec)
				BASE64 ENCODE:C895($Blb_buffer; $encoded)
				SET BLOB SIZE:C606($Blb_buffer; 0)
				
				$image:=DOM Create XML element:C865($Dom_pattern; "image"; \
					"xlink:href"; "data:image/"+Delete string:C232($codec; 1; 1)+";"+\
					"base64,"+$encoded; "x"; \
					0; "y"; \
					0; "width"; \
					$Lon_width; "height"; \
					$Lon_height)
				
				var $rect : Text
				$rect:=DOM Create XML element:C865($svg; "rect"; \
					"x"; 0; \
					"y"; 0; \
					"width"; "100%"; \
					"height"; "100%"; \
					"stroke"; "black"; \
					"fill"; "url(#MyPattern)")
				
				SVG EXPORT TO PICTURE:C1017($svg; $Pic_Buffer; Copy XML data source:K45:17)
				DOM CLOSE XML:C722($svg)
				
				$Obj_picture.pictureStretch:=$kLon_none  // 1
				
				//______________________________________________________
			Else 
				
				$Obj_picture.pictureStretch:=Choose:C955(Num:C11($Col_pictures[$Lon_picture].drawingMode); \
					$kLon_stretch; \
					$kLon_none; \
					$kLon_centered; \
					$kLon_zoom; \
					$kLon_zoom; \
					$kLon_stretch; \
					$kLon_zoom)
				
				//______________________________________________________
		End case 
		
		PICTURE TO BLOB:C692($Pic_buffer; $Blb_buffer; ".png")
		CLEAR VARIABLE:C89($Pic_buffer)
		BASE64 ENCODE:C895($Blb_buffer; $Txt_image)
		CLEAR VARIABLE:C89($Blb_buffer)
		
		$Obj_picture.src:="data:"+"image/png;base64,"+$Txt_image
		
		// Append the picture to the floating objects
		$Col_floatingObjects[$Col_floatingObjects.length]:=$Obj_picture
		
	End if 
End for 

// ----------------------------------------------------
// Return
$0:=$Col_floatingObjects

// ----------------------------------------------------
// End