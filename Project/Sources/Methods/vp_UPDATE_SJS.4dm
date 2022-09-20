//%attributes = {"invisible":true}
/*
***vp_UPDATE_SJS*** ( in )
 -> in (Object) -  SJS object
________________________________________________________
*/
// ----------------------------------------------------
// Project method : vp_UPDATE_SJS
// Database: 4D ViewPro
// ID[C73CAE813F5E4BAFB16796BAE22496C0]
// Created #19-3-2018 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Update according to SJS version
// ----------------------------------------------------
// Declarations
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_updated)
C_LONGINT:C283($Lon_docMajor; $nbParameters; $Lon_sjsMajor)
C_TEXT:C284($Txt_buffer; $Txt_property)
C_OBJECT:C1216($Obj_in)

If (False:C215)
	C_OBJECT:C1216(vp_UPDATE_SJS; $1)
End if 

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	// Required parameters
	$Obj_in:=$1  // SJS object
	
	// Optional parameters
	If ($nbParameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Obj_in.version=Null:C1517)
		
		THROW(New object:C1471(\
			"code"; 1))
		
		//______________________________________________________
	: ($Obj_in.version=Storage:C1525.ViewPro.spreadJSVersion)  // Current version
		
		// NOTHING MORE TO DO
		
		//______________________________________________________
	Else 
		
		//%W-533.1
		//$Lon_docMajor:=Num($Obj_in.spreadJS.version[[1]]+$Obj_in.spreadJS.version[[2]])
		$Lon_docMajor:=Num:C11(Substring:C12($Obj_in.version; 1; Position:C15("."; $Obj_in.version)-1))
		
		//$Lon_sjsMajor:=Num(common.spreadJSVersion[[1]]+common.spreadJSVersion[[2]])
		$Lon_sjsMajor:=Num:C11(Substring:C12(Storage:C1525.ViewPro.spreadJSVersion; 1; Position:C15("."; Storage:C1525.ViewPro.spreadJSVersion)-1))
		//%W+533.1
		
		Case of 
				
				//……………………………………………………………………………………………………………………………………………………………………
			: ($Lon_docMajor<9)
				
				THROW(New object:C1471(\
					"code"; 1))
				
				//……………………………………………………………………………………………………………………………………………………………………
			: ($Lon_docMajor<=10)
				
				Case of 
						
						//……………………………………………………………………………………………………………
					: ($Lon_sjsMajor=11)  //#97562
						
						// Rename sheets
						For each ($Txt_property; $Obj_in.sheets)
							
							If ($Obj_in.sheets[$Txt_property].name#$Txt_property)
								
								$Obj_in.sheets[$Txt_property].name:=$Txt_property
								
							End if 
						End for each 
						
						$Txt_buffer:=JSON Stringify:C1217($Obj_in.sheets)
						
						//#97698 - Checked with FM
						$Txt_buffer:=Replace string:C233($Txt_buffer; "'%"; "\"%\"")
						
						//#97723 - Checked with FM
						$Txt_buffer:=Replace string:C233($Txt_buffer; Char:C90(NBSP ASCII CODE:K15:43); "?")
						
						$Obj_in.sheets:=JSON Parse:C1218($Txt_buffer)
						
						$Boo_updated:=True:C214
						
						//……………………………………………………………………………………………………………
				End case 
				
				//……………………………………………………………………………………………………………………………………………………………………
			: ($Lon_docMajor=11)
				
				Case of 
						
						// ........................................
					: ($Lon_sjsMajor=11)
						
						// v11 open v11 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=12)
						
						// v12 open v11 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=13)
						
						// v13 open v11 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=14)
						
						// v14 open v11 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=15)
						
						// v15 open v11 doc, adjust minor version
						$Boo_updated:=True:C214
						// ........................................
				End case 
				
			: ($Lon_docMajor=12)
				
				Case of 
						
						// ........................................
					: ($Lon_sjsMajor=12)
						
						// v12 open v12 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=13)
						
						// v13 open v12 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=14)
						
						// v14 open v12 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=15)
						
						// v15 open v12 doc, adjust minor version
						$Boo_updated:=True:C214
						// ........................................
				End case 
				//……………………………………………………………………………………………………………………………………………………………………
			: ($Lon_docMajor=13)
				
				Case of 
						
						// ........................................
					: ($Lon_sjsMajor=13)
						
						// v13 open v13 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=14)
						
						// v13 open v14 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=15)
						
						// v13 open v15 doc, adjust minor version
						$Boo_updated:=True:C214
						// ........................................
				End case 
				//……………………………………………………………………………………………………………………………………………………………………
			: ($Lon_docMajor=14)
				
				Case of 
						
						// ........................................
					: ($Lon_sjsMajor=14)
						
						// v14 open v14 doc, adjust minor version
						$Boo_updated:=True:C214
						
					: ($Lon_sjsMajor=15)
						
						// v15 open v14 doc, adjust minor version
						$Boo_updated:=True:C214
						// ........................................
				End case 
				//……………………………………………………………………………………………………………………………………………………………………
			: ($Lon_docMajor=15)
				
				Case of 
						
					: ($Lon_sjsMajor=15)
						
						// v15 open v15 doc, adjust minor version
						$Boo_updated:=True:C214
						// ........................................
				End case 
				
			Else 
				
				// NOTHING MORE TO DO
				
				//……………………………………………………………………………………………………………………………………………………………………
		End case 
		
		//______________________________________________________
End case 

If ($Boo_updated)
	
	// Update version
	$Obj_in.version:=Storage:C1525.ViewPro.spreadJSVersion
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End