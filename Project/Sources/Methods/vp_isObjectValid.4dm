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
var $0 : Boolean
var $1 : Object
var $Boo_valid : Boolean
var $nbParameters : Integer
var $Dir_root : Text
var $Obj_schema : Object
var $Obj_viewObject : Object
If (False:C215)
	C_BOOLEAN:C305(vp_isObjectValid ;$0)
	C_OBJECT:C1216(vp_isObjectValid ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Obj_viewObject:=$1
	
	  //Optional parameters
	If ($nbParameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Dir_root:=Get 4D folder:C485(Current resources folder:K5:16)+"schemas"+Folder separator:K24:12
	$Obj_schema:=JSON Parse:C1218(Document to text:C1236($Dir_root+"SJS.json"))
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Boo_valid:=JSON Validate:C1456($Obj_viewObject;$Obj_schema).success

  // ----------------------------------------------------
  // Return
$0:=$Boo_valid

  // ----------------------------------------------------
  // End