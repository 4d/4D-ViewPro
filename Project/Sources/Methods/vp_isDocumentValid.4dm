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
C_BOOLEAN:C305($0)
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_valid)
C_LONGINT:C283($nbParameters)
C_TEXT:C284($Dir_root)
C_OBJECT:C1216($Obj_document;$Obj_shema)

If (False:C215)
	C_BOOLEAN:C305(vp_isDocumentValid ;$0)
	C_OBJECT:C1216(vp_isDocumentValid ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1;"Missing parameter"))
	
	  // Required parameters
	$Obj_document:=$1
	
	  // Optional parameters
	If ($nbParameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Dir_root:=Get 4D folder:C485(Current resources folder:K5:16)+"schemas"+Folder separator:K24:12
	$Obj_shema:=JSON Parse:C1218(Document to text:C1236($Dir_root+"4DVP.json"))
	
Else 
	
	ABORT:C156
	
End if 

$Boo_valid:=JSON Validate:C1456($Obj_document;$Obj_shema).success

  // #9-8-2017 - remove spredJS validation - Checked with LE
  //If ($Boo_valid)
  //$Boo_valid:=vp_isObjectValid ($Obj_document.spreadJS)
  // End if

  // ----------------------------------------------------
  // Return
$0:=$Boo_valid

  // ----------------------------------------------------
  // End