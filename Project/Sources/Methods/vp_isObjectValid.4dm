//%attributes = {"invisible":true}
/*
valid := ***vp_isObjectValid*** ( viewObject )
 -> viewObject (Object)
 <- valid (Boolean)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : vp_isObjectValid
// Database: 4D ViewPro
// ID[F2524545F65F4B698DAEE57873BB913F]
// Created #30-5-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($Obj_viewObject : Object) : Boolean

var $Dir_root:=Get 4D folder:C485(Current resources folder:K5:16)+"schemas"+Folder separator:K24:12
var $Obj_schema:=JSON Parse:C1218(Document to text:C1236($Dir_root+"SJS.json"))

// ----------------------------------------------------
return Bool:C1537(JSON Validate:C1456($Obj_viewObject; $Obj_schema).success)

