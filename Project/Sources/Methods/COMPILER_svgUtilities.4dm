//%attributes = {"invisible":true}
//___________________________________
C_OBJECT:C1216(svg_addHLine; $1)
C_LONGINT:C283(svg_addHLine; $2; $3; $4)
C_TEXT:C284(svg_addHLine; $5)
C_POINTER:C301(svg_addHLine; $6; $7)
C_OBJECT:C1216(svg_addHLine; $8)

//___________________________________
C_OBJECT:C1216(svg_addVLine; $1)
C_LONGINT:C283(svg_addVLine; $2)
C_LONGINT:C283(svg_addVLine; $3)
C_LONGINT:C283(svg_addVLine; $4)
C_TEXT:C284(svg_addVLine; $5)
C_POINTER:C301(svg_addVLine; $6)
C_POINTER:C301(svg_addVLine; $7)
C_OBJECT:C1216(svg_addVLine; $8)

//___________________________________
C_OBJECT:C1216(svg_addDULine; $1)
C_LONGINT:C283(svg_addDULine; $2; $3; $4)
C_TEXT:C284(svg_addDULine; $5)
C_POINTER:C301(svg_addDULine; $6; $7)
C_OBJECT:C1216(svg_addDULine; $8)

//___________________________________
C_OBJECT:C1216(svg_addDDLine; $1)
C_LONGINT:C283(svg_addDDLine; $2; $3; $4)
C_TEXT:C284(svg_addDDLine; $5)
C_POINTER:C301(svg_addDDLine; $6; $7)
C_OBJECT:C1216(svg_addDDLine; $8)

//___________________________________
C_TEXT:C284(svg_drawLine; $1)
C_OBJECT:C1216(svg_drawLine; $2)
C_OBJECT:C1216(svg_drawLine; $3)
C_POINTER:C301(svg_drawLine; $4)
C_POINTER:C301(svg_drawLine; $5)

//___________________________________
C_LONGINT:C283(svg_hasBorderPriority; $1; $2)
C_BOOLEAN:C305(svg_hasBorderPriority; $0)

//___________________________________
C_LONGINT:C283(svg_cell_hasDefinedStyle; $1)
C_LONGINT:C283(svg_cell_hasDefinedStyle; $2)
C_TEXT:C284(svg_cell_hasDefinedStyle; $3)
C_OBJECT:C1216(svg_cell_hasDefinedStyle; $4)
C_BOOLEAN:C305(svg_cell_hasDefinedStyle; $0)

//___________________________________
C_TEXT:C284(svg_drawDoubleLine; $1)
C_OBJECT:C1216(svg_drawDoubleLine; $2)
C_OBJECT:C1216(svg_drawDoubleLine; $3)
C_POINTER:C301(svg_drawDoubleLine; $4)
C_POINTER:C301(svg_drawDoubleLine; $5)

//___________________________________
C_OBJECT:C1216(svg_hasDoubleLineIntersection; $1)
C_LONGINT:C283(svg_hasDoubleLineIntersection; $2)
C_LONGINT:C283(svg_hasDoubleLineIntersection; $3)
C_POINTER:C301(svg_hasDoubleLineIntersection; $4)
C_BOOLEAN:C305(svg_hasDoubleLineIntersection; $0)

//___________________________________
C_TEXT:C284(svg_drawCellValue; $1)
C_COLLECTION:C1488(svg_drawCellValue; $2)
C_LONGINT:C283(svg_drawCellValue; $3)
C_LONGINT:C283(svg_drawCellValue; $4)

//___________________________________
C_OBJECT:C1216(svg_displayBox; $1)
C_TEXT:C284(svg_displayBox; $2; $3)

//___________________________________
C_COLLECTION:C1488(svg_getFontFamily; $1)
C_TEXT:C284(svg_getFontFamily; $0)
C_LONGINT:C283(svg_getFontFamily; $2)

//___________________________________
C_OBJECT:C1216(svg_checkColor; $1)
C_TEXT:C284(svg_checkColor; $2)

//___________________________________
C_TEXT:C284(svg_retrieveColor; $1)
C_TEXT:C284(svg_retrieveColor; $0)

//___________________________________
C_LONGINT:C283(svg_cell_findOverflowL; $0)
C_OBJECT:C1216(svg_cell_findOverflowL; $1)
C_LONGINT:C283(svg_cell_findOverflowL; $2)
C_LONGINT:C283(svg_cell_findOverflowL; $3)
C_LONGINT:C283(svg_cell_findOverflowL; $4)

//___________________________________
C_LONGINT:C283(svg_cell_findOverflowR; $0)
C_OBJECT:C1216(svg_cell_findOverflowR; $1)
C_LONGINT:C283(svg_cell_findOverflowR; $2)
C_LONGINT:C283(svg_cell_findOverflowR; $3)
C_LONGINT:C283(svg_cell_findOverflowR; $4)

//___________________________________
C_TEXT:C284(svg_printVerticalChar; $1)
C_TEXT:C284(svg_printVerticalChar; $2)
C_REAL:C285(svg_printVerticalChar; $3)
C_REAL:C285(svg_printVerticalChar; $4)
C_BOOLEAN:C305(svg_printVerticalChar; $5)
C_OBJECT:C1216(svg_printVerticalChar; $6)
C_POINTER:C301(svg_printVerticalChar; $7)

//___________________________________
C_TEXT:C284(svg_printVerticalText; $1)
C_TEXT:C284(svg_printVerticalText; $2)
C_TEXT:C284(svg_printVerticalText; $3)
C_OBJECT:C1216(svg_printVerticalText; $4)
C_BOOLEAN:C305(svg_printVerticalText; $5)
C_POINTER:C301(svg_printVerticalText; $6)

//___________________________________
C_OBJECT:C1216(svg_getVerticalYPos; $1)
C_TEXT:C284(svg_getVerticalYPos; $2)
C_TEXT:C284(svg_getVerticalYPos; $3)
C_BOOLEAN:C305(svg_getVerticalYPos; $4)
C_REAL:C285(svg_getVerticalYPos; $0)

//___________________________________
C_POINTER:C301(svg_getPictSize; $1)
C_POINTER:C301(svg_getPictSize; $2)
C_POINTER:C301(svg_getPictSize; $3)

//__________________________________
C_POINTER:C301(svg_convertBase64ToPicture; $1)
C_PICTURE:C286(svg_convertBase64ToPicture; $0)

//__________________________________
C_TEXT:C284(svg_getBase64Image; $1)
C_TEXT:C284(svg_getBase64Image; $0)

//__________________________________
C_TEXT:C284(svg_convertUnitToPx; $1)
C_TEXT:C284(svg_convertUnitToPx; $0)

//__________________________________
C_TEXT:C284(svg_getTextWidth; $1)
C_OBJECT:C1216(svg_getTextWidth; $2)
C_REAL:C285(svg_getTextWidth; $0)

//__________________________________
C_TEXT:C284(svg_getVTextHeight; $1)
C_OBJECT:C1216(svg_getVTextHeight; $2)
C_LONGINT:C283(svg_getVTextHeight; $0)

//__________________________________
C_TEXT:C284(svg_getCellPadding; $1)
C_OBJECT:C1216(svg_getCellPadding; $2)

//__________________________________
C_OBJECT:C1216(svg_addBackColor; $1)
C_LONGINT:C283(svg_addBackColor; $2)
C_LONGINT:C283(svg_addBackColor; $3)
C_LONGINT:C283(svg_addBackColor; $4)
C_LONGINT:C283(svg_addBackColor; $5)
C_LONGINT:C283(svg_addBackColor; $6)
C_LONGINT:C283(svg_addBackColor; $7)
C_TEXT:C284(svg_addBackColor; $8)
C_LONGINT:C283(svg_addBackColor; $9)
C_BOOLEAN:C305(svg_addBackColor; $10)

//__________________________________
C_TEXT:C284(svg_drawBackColor; $1)
C_COLLECTION:C1488(svg_drawBackColor; $2)

//__________________________________
C_TEXT:C284(svg_initDefaultTheme; $1)

//__________________________________
C_OBJECT:C1216(svg_applyLum; $1)

//__________________________________
C_REAL:C285(svg_saturate; $1)
C_REAL:C285(svg_saturate; $2)
C_REAL:C285(svg_saturate; $3)
C_REAL:C285(svg_saturate; $0)

//__________________________________
C_TEXT:C284(svg_drawBgImg; $1)
C_COLLECTION:C1488(svg_drawBgImg; $2)

//__________________________________
C_TEXT:C284(svg_drawGridline; $1)
C_OBJECT:C1216(svg_drawGridline; $2)
C_OBJECT:C1216(svg_drawGridline; $3)
C_OBJECT:C1216(svg_drawGridline; $4)
C_POINTER:C301(svg_drawGridline; $5)
C_POINTER:C301(svg_drawGridline; $6)
C_OBJECT:C1216(svg_drawGridline; $7)
C_COLLECTION:C1488(svg_drawGridline; $8)

//__________________________________
C_TEXT:C284(dom_xml_copy_element; $1)
C_TEXT:C284(dom_xml_copy_element; $2)

//__________________________________
C_OBJECT:C1216(svg_parseStyle; $1; $2)

//__________________________________
C_OBJECT:C1216(svg_getRotatedBox; $0; $1)
C_REAL:C285(svg_getRotatedBox; $2; $3; $4)

//__________________________________
C_OBJECT:C1216(svg_getWrappedLineBoxFromBigBox; $0; $1; $2)

//__________________________________
C_OBJECT:C1216(svg_getTextBox; $0)
C_LONGINT:C283(svg_getTextBox; $1; $2; $3; $4)

//__________________________________
C_OBJECT:C1216(svg_getHTMLTextBox; $0)
C_LONGINT:C283(svg_getHTMLTextBox; $1; $2; $3; $4)

//__________________________________
C_OBJECT:C1216(svg_getTranslatedBox; $0; $1)
C_REAL:C285(svg_getTranslatedBox; $2; $3)

//__________________________________
C_OBJECT:C1216(svg_addLine; $1)
C_LONGINT:C283(svg_addLine; $2; $3; $4; $6; $8; $9)
C_BOOLEAN:C305(svg_addLine; $7)
C_TEXT:C284(svg_addLine; $5)

//__________________________________
C_COLLECTION:C1488(svg_checkColIndex; $1)
C_LONGINT:C283(svg_checkColIndex; $2)
C_BOOLEAN:C305(svg_checkColIndex; $0)

//__________________________________
C_REAL:C285(svg_findIntersection; $1; $2; $3; $4; $5; $6)
C_OBJECT:C1216(svg_findIntersection; $0)

//__________________________________
C_COLLECTION:C1488(svg_getSortedMapCell; $1)
C_LONGINT:C283(svg_getSortedMapCell; $2; $3)
C_OBJECT:C1216(svg_getSortedMapCell; $0)

//__________________________________
C_OBJECT:C1216(svg_sortLineMap; $1; $2)

//__________________________________
C_OBJECT:C1216(svg_getCellMergeStatus; $0)
C_LONGINT:C283(svg_getCellMergeStatus; $1; $2)
C_COLLECTION:C1488(svg_getCellMergeStatus; $3)

//___________________________________
C_OBJECT:C1216(colorConst)
C_REAL:C285(char_space)
C_OBJECT:C1216(theme)
C_TEXT:C284(themeFont)
C_PICTURE:C286(svgPicture)
