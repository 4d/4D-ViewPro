//%attributes = {"invisible":true,"shared":true}
// The VP NEW DOCUMENT command loads and display a new, default document in the 4D View Pro form area object vpAreaName. The new empty document replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
#DECLARE($area : Text)

If (Not:C34(vp_initStorage))
	return 
End if 

If (Not:C34(Check_parameters_count(1; Count parameters:C259)))
	return 
End if 

err_TRY

If (Not:C34(vp_isReady($area; Current method name:C684)))
	err_FINALLY
	return 
End if 

// Get host database default template path
var $defaultFile:=Folder:C1567(fk resources folder:K87:11; *).folder("viewPro").file("default.4vp")

If (Not:C34($defaultFile.exists))
	
	// Get internal default template path
	$defaultFile:=Folder:C1567(fk resources folder:K87:11).folder("viewPro").file("default.4vp")
	
End if 

If (Not:C34($defaultFile.exists))
	err_THROW({component: "xbox"; code: 600/*File not found*/; name: $defaultFile.fullName; path: $defaultFile.platformPath})
	err_FINALLY
	return 
End if 


var $textBuffer:=$defaultFile.getText()

If (err_continue)
	
	var $documentObject:=JSON Parse:C1218($textBuffer)
	
	If (err_continue)
		
		$documentObject.version:=Storage:C1525.ViewPro.version
		$documentObject.spreadJS.version:=Storage:C1525.ViewPro.spreadJSVersion
		
		If ($documentObject.spreadJS.sheets.Sheet1.columnCount=Null:C1517)
			
			$documentObject.spreadJS.sheets.Sheet1.columnCount:=100
			
		End if 
		
		If ($documentObject.spreadJS.sheets.Sheet1.rowCount=Null:C1517)
			
			$documentObject.spreadJS.sheets.Sheet1.rowCount:=1000
			
		End if 
		
		var $obj:=vp_getAreaVariable($area)
		If ($obj.interface#"none")
			
			$documentObject.spreadJS.tabStripVisible:=True:C214
			
		End if 
		
		vp_runFunction($area; "import-json"; {doc: $documentObject; new: True:C214; command: "import-4VP"})
		
	Else 
		
		err_THROW({code: 7/*Cannot import file*/; name: $defaultFile.fullName})
		
	End if 
	
Else 
	
	err_THROW({component: "xbox"; code: 602/*Cannot open file "{name}" ({path})*/; name: $defaultFile.fullName; path: $defaultFile.platformPath})
	
End if 
