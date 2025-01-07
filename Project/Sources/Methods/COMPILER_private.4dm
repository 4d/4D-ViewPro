//%attributes = {"invisible":true}
var Feature : cs:C1710._feature

// ----------------
C_BLOB:C604(_ttc_; _ttf_)  // the TTC exporter class cannot have Blob members yet

//___________________________________
C_BOOLEAN:C305(vp_isDocumentValid; $0)
C_OBJECT:C1216(vp_isDocumentValid; $1)

//___________________________________
C_BOOLEAN:C305(vp_isObjectValid; $0)
C_OBJECT:C1216(vp_isObjectValid; $1)

//___________________________________
C_OBJECT:C1216(vp_METADATA; $1)
C_TEXT:C284(vp_METADATA; $2)

//___________________________________
C_OBJECT:C1216(vp_UPDATE; $1)

//___________________________________
C_OBJECT:C1216(vp_UPDATE_SJS; $1)

//___________________________________
C_TEXT:C284(vp_endInit; $1)
C_TEXT:C284(vp_endInit; $2)
C_BOOLEAN:C305(vp_endInit; $3)

//___________________________________
C_OBJECT:C1216(vp_fillStorage; $1)

//___________________________________
C_TEXT:C284(vp_saveFile; $1)
C_TEXT:C284(vp_saveFile; $2)
C_BOOLEAN:C305(vp_saveFile; $3)
C_OBJECT:C1216(vp_saveFile; $0)

//___________________________________
C_OBJECT:C1216(vp_eventsCallback; $1)
C_OBJECT:C1216(vp_eventsCallback; $2)

//___________________________________
C_OBJECT:C1216(vp_convert_from_stylesheet; $0)
C_OBJECT:C1216(vp_convert_from_stylesheet; $1)

//___________________________________
C_OBJECT:C1216(vp_convert_to_stylesheet; $0)
C_OBJECT:C1216(vp_convert_to_stylesheet; $1)

//___________________________________
C_OBJECT:C1216(vp_make_picture; $1)
C_TEXT:C284(vp_make_picture; $2)

//___________________________________
C_OBJECT:C1216(vp_get_picture; $1)
C_TEXT:C284(vp_get_picture; $2)

//___________________________________
C_OBJECT:C1216(vp_computeFonts; $1)
C_OBJECT:C1216(vp_computeFonts; $0)

//___________________________________
C_OBJECT:C1216(vp_makeFont; $1)
C_TEXT:C284(vp_makeFont; $2)

//___________________________________
C_OBJECT:C1216(vp_makeSheet; $0)
C_TEXT:C284(vp_makeSheet; $1)
C_LONGINT:C283(vp_makeSheet; $2)

//___________________________________
C_OBJECT:C1216(vp_getSheetByName; $0)
C_TEXT:C284(vp_getSheetByName; $1)

//___________________________________
C_OBJECT:C1216(vp_addRangeFormulas; $1)

//___________________________________
C_OBJECT:C1216(vp_setValue; $1)
C_VARIANT:C1683(vp_setValue; $2)
C_TEXT:C284(vp_setValue; $3)

//___________________________________
C_OBJECT:C1216(vp_getCellRange; $1)
C_OBJECT:C1216(vp_getCellRange; $2)
C_OBJECT:C1216(vp_getCellRange; $0)

//___________________________________
C_OBJECT:C1216(vp_parse_object_set; $1)
C_OBJECT:C1216(vp_parse_object_set; $0)

//___________________________________
C_VARIANT:C1683(vp_parse_element_set; $0)
C_VARIANT:C1683(vp_parse_element_set; $1)

//___________________________________
C_COLLECTION:C1488(vp_parse_collection_set; $0)
C_COLLECTION:C1488(vp_parse_collection_set; $1)

//___________________________________
C_OBJECT:C1216(vp_parse_object_get; $1)
C_OBJECT:C1216(vp_parse_object_get; $0)

//___________________________________
C_VARIANT:C1683(vp_parse_element_get; $0)
C_VARIANT:C1683(vp_parse_element_get; $1)

//___________________________________
C_COLLECTION:C1488(vp_parse_collection_get; $0)
C_COLLECTION:C1488(vp_parse_collection_get; $1)

//___________________________________
C_LONGINT:C283(convert_indexToLetters; $1)
C_TEXT:C284(convert_indexToLetters; $0)

//___________________________________
C_OBJECT:C1216(vp_objectToFormula; $1)
C_TEXT:C284(vp_objectToFormula; $0)
