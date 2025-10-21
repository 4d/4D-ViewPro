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
#DECLARE($Obj_in : Object)

var $Boo_updated : Boolean
var $Lon_docMajor; $Lon_sjsMajor : Integer
var $Txt_buffer; $Txt_property : Text

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Obj_in=Null:C1517)
		
		err_THROW({code: 1/*Invalid 4D View Pro object*/})
		
		//______________________________________________________
	: ($Obj_in.version=Null:C1517)
		
		err_THROW({code: 1/*Invalid 4D View Pro object*/})
		
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
				
				err_THROW({code: 1/*Invalid 4D View Pro object*/})
				
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
			: ($Lon_docMajor>=11)
				
				// v<$Lon_docMajor> to v17 open v<$Lon_docMajor> doc, adjust minor version
				$Boo_updated:=($Lon_sjsMajor>=$Lon_docMajor) && ($Lon_sjsMajor<=17)
				
				//……………………………………………………………………………………………………………………………………………………………………
		End case 
		
		//______________________________________________________
End case 

If ($Boo_updated)
	
	// Update version
	$Obj_in.version:=Storage:C1525.ViewPro.spreadJSVersion
	
End if 
