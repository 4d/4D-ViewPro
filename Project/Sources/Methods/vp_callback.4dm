//%attributes = {"invisible":true}
/*
***_vp_exportcallback*** ( params )
 -> params (Object)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : _vp_callback
// Database: 4D ViewPro
// ID[860DAAF2A36D4E649C15DC4A4A18D5A2]
// Created #12-6-2018 by François Marchal
// ----------------------------------------------------
// Description:
// When a VP command calls a js command that runs asynchronously
// when js command is done, js calls $4d.__vp_callback
// which is trapped by C++, which will call _vp_callback
// in 4D ViewPro component. We need to use C++ to
// call _vp_excelcallback from JS because this method is not shared
// outside the component, so it is not directly available by $4d.xxx
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($1)
C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($Obj_callback; $Obj_userObject; $Obj_formula; $Obj_status; $Obj_areaVariable; $Obj_blob)
C_TEXT:C284($Txt_content; $Txt_uuid; $File_pathname)
C_BOOLEAN:C305($Bool_result; $Bool_runCmd)
If (False:C215)
	C_OBJECT:C1216(vp_callback; $1)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259
If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	// Required parameters
	$Obj_callback:=$1
	// Optional parameters
	If ($nbParameters>=2)
		// <NONE>
	End if 
Else 
	ABORT:C156
End if 
// ----------------------------------------------------

TRY_CALLBACK

If (OB Is defined:C1231($Obj_callback; "command"))
	$Bool_runCmd:=False:C215
	$Bool_result:=False:C215
	Case of 
		: (($Obj_callback.command="export-excel")\
			 | ($Obj_callback.command="export-pdf")\
			 | ($Obj_callback.command="export-sjs")\
			 | ($Obj_callback.command="export-blob"))
			// ----- excel/pdf/sjs export
			$Bool_runCmd:=True:C214
			If (OB Is defined:C1231($Obj_callback; "content"))
				// Content is encoded
				$Txt_content:=$Obj_callback.content
				OB REMOVE:C1226($Obj_callback; "content")  // Free memory as soon as possible
				$obj_Blob:=4D:C1709.Blob.new()
				BASE64 DECODE:C896($Txt_content; $obj_Blob)
				$Txt_content:=""  // Free memory as soon as possible
				If ($Obj_callback.command="export-blob")
					$Bool_result:=True:C214
				Else 
					If ($obj_Blob.size>0)
						$File_pathname:=String:C10($Obj_callback.path)
						// Create-update the document
						BLOB TO DOCUMENT:C526($File_pathname; $obj_Blob)
						SET BLOB SIZE:C606($obj_Blob; 0)  // Free memory as soon as possible
						If (Continue_callback)
							$Bool_result:=True:C214
						Else 
							THROW_CALLBACK(1; "Error, impossible to write file "+Path to object:C1547($File_pathname).name+", check if file is not locked or in use.")
						End if 
					Else 
						THROW_CALLBACK(2; "Internal error, empty document returned")
					End if 
				End if 
			End if 
		: (($Obj_callback.command="import-excel")\
			 | ($Obj_callback.command="import-sjs")\
			 | ($Obj_callback.command="export-4VP")\
			 | ($Obj_callback.command="import-4VP")\
			 | ($Obj_callback.command="export-csv")\
			 | ($Obj_callback.command="import-csv"))
			$File_pathname:=String:C10($Obj_callback.path)
			$Bool_result:=True:C214
			$Bool_runCmd:=True:C214
		: ($Obj_callback.command="import-blob")
			$Bool_result:=True:C214
			$Bool_runCmd:=True:C214
			$File_pathname:=""
	End case 
	
	If ($Bool_runCmd)
		//
		If (OB Is defined:C1231($Obj_callback; "uuid"))
			$Txt_uuid:=$Obj_callback.uuid
			
			$Obj_areaVariable:=vp_getAreaVariable($Obj_callback.areaName)
			If ($Obj_areaVariable#Null:C1517)
				If (Value type:C1509($Obj_areaVariable.callbacks)=Is object:K8:27)
					
					If ($Obj_areaVariable.callbacks[$Txt_uuid]#Null:C1517)
						// Get the object given by user
						$Obj_userObject:=$Obj_areaVariable.callbacks[$Txt_uuid]
						// Clean-up
						OB REMOVE:C1226($Obj_areaVariable.callbacks; $Txt_uuid)
						If (OB Is defined:C1231($Obj_userObject; "formula"))
							$Obj_formula:=$Obj_userObject.formula
							$Obj_status:=New object:C1471("success"; $Bool_result)
							If (OB Is defined:C1231($Obj_callback; "error"))
								$Obj_status:=$Obj_callback.error
								$Obj_status.success:=False:C215
							Else 
								If (OB Is defined:C1231(errCB_err; "errors"))
									$Obj_status:=errCB_err
									$Obj_status.success:=False:C215
								End if 
							End if 
							If (($Obj_callback.command="import-blob")\
								 | ($Obj_callback.command="export-blob"))
								If ($Obj_callback.command="import-blob")
									$obj_Blob:=$Obj_userObject.blob
									OB REMOVE:C1226($Obj_userObject; "blob")
								End if 
								$Obj_formula.call(Null:C1517; $Obj_callback.areaName; $obj_Blob; $Obj_userObject; $Obj_status)
							Else 
								$Obj_formula.call(Null:C1517; $Obj_callback.areaName; $File_pathname; $Obj_userObject; $Obj_status)
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

FINALLY_CALLBACK
// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End
