//%attributes = {"invisible":true}
/*
valid := ***vp_isDocumentValid*** ( document )
 -> document (Object)
 <- valid (Boolean)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : vp_isDocumentValid
// Database: 4D ViewPro
// ID[87233BE3AA8F4D158570DEAFAA8BC329]
// Created #19-5-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($Obj_document : Object) : Boolean

var $Dir_root:=Get 4D folder:C485(Current resources folder:K5:16)+"schemas"+Folder separator:K24:12
var $Obj_shema:=JSON Parse:C1218(Document to text:C1236($Dir_root+"4DVP.json"))

var $Boo_valid:=Bool:C1537(JSON Validate:C1456($Obj_document; $Obj_shema).success)

// #9-8-2017 - remove spredJS validation - Checked with LE
//If ($Boo_valid)
//$Boo_valid:=vp_isObjectValid ($Obj_document.spreadJS)
// End if

return $Boo_valid
