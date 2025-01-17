//%attributes = {"invisible":true,"shared":true}
// The VP IMPORT DOCUMENT command imports and displays the 4D View Pro document designated by filePath in the 4D View Pro area vpAreaName. The imported document replaces any data already inserted in the area. 
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In filePath, pass the destination path and name of the document to be imported. Only 4D View Pro documents (extension ".4vp") are supported by the command. You must pass a full path, unless the document is located at the same level as the database structure file, in which case you can just pass its name.
// An error is returned if the filePath parameter is invalid, or if the file is missing or malformed.
#DECLARE($area : Text; $filePath : Text; $params : Object)

var $textBuffer : Text
var $documentObject; $callback : Object
var $blobBuffer : Blob

If (Not:C34(vp_initStorage))
	return 
End if 

If (Not:C34(Check_parameters_count(2; Count parameters:C259)))
	return 
End if 

err_TRY

If (Not:C34(vp_isReady($area; Current method name:C684)))
	err_FINALLY
	return 
End if 

If ($params=Null:C1517)
	$params:={}
End if 

// check file path and name
var $fileName : Text:=""
var $isOk:=False:C215
Case of 
	: (Length:C16($filePath)=0)
		
		err_THROW({component: "xbox"; code: 3107/*Output document path is empty.*/})
		
	: (Position:C15(Folder separator:K24:12; $filePath)=0)
		
		$fileName:=$filePath
		
		// Search for a document located near the 4D structure file
		$filePath:=Get 4D folder:C485(Database folder:K5:14; *)+$fileName
		$isOk:=True:C214
		
	Else 
		
		var $pathObject:=Path to object:C1547($filePath)
		$fileName:=$pathObject.name+$pathObject.extension
		$isOk:=True:C214
		
End case 

If ($isOK && (Test path name:C476($filePath)#Is a document:K24:1))
	
	$isOK:=False:C215
	err_THROW({component: "xbox"; code: 600/*File not found*/; name: $fileName; path: $filePath})
	
End if 

// go import if ok
Case of 
	: (Not:C34($isOk))
		
		err_THROW({code: 7/*Cannot import file*/; name: $fileName})
		
		// MARK:- 4VP
	: ($filePath="@.4VP")
		
		$textBuffer:=Document to text:C1236($filePath; "UTF-8")
		
		If (Not:C34(err_continue))
			err_THROW({component: "xbox"; code: 602/*Cannot open file "{name}" ({path})*/; name: $fileName; path: $filePath})
			err_FINALLY
			return 
		End if 
		
		$documentObject:=JSON Parse:C1218($textBuffer)
		
		If (Not:C34(err_continue))
			err_THROW({code: 7/*Cannot import file*/; name: $fileName})
			err_FINALLY
			return 
		End if 
		
		If ($documentObject.spreadJS#Null:C1517)
			
			vp_UPDATE($documentObject)
			
		Else 
			
			// Allow to open a spreadJS' native document by changing the ".json"
			// Extension to ".4VP"
			$documentObject:={version: Storage:C1525.ViewPro.version; spreadJS: $documentObject}
			
		End if 
		
		// Validate data with shema
		If (vp_isDocumentValid($documentObject))

			$callback:=vp_newCallback("import-4VP"; $area; $params)
			$callback.doc:=$documentObject
			$callback.new:=False:C215
			vp_runFunction($area; "import-json"; $callback)
			
		Else 
			
			err_THROW({code: 4/*The file "{name}" is not a valid 4D View Pro file.*/; name: $fileName})
			
		End if 
		
		// MARK:- xlsx
	: ($filePath="@.xlsx")
		
		DOCUMENT TO BLOB:C525($filePath; $blobBuffer)
		
		If (err_continue)
			
			BASE64 ENCODE:C895($blobBuffer; $textBuffer)
			
			If (Length:C16($textBuffer)>0)
				
				// Keep the export file destination pathname
				$callback:=vp_newCallback("import-excel"; $area; $params)
				$callback.path:=$filePath
				$callback.content:=$textBuffer
				$callback.password:=$params.password
				$callback.excelOptions:=$params.excelOptions
				$callback.excelIO:=$params.excelIO
				
				// Launch export
				$documentObject:=vp_runFunction($area; "import-excel"; $callback)
				
			End if 
			
		End if 
		
		// MARK:- sjs
	: ($filePath="@.sjs")
		
		DOCUMENT TO BLOB:C525($filePath; $blobBuffer)
		
		If (err_continue)
			
			BASE64 ENCODE:C895($blobBuffer; $textBuffer)
			
			If (Length:C16($textBuffer)>0)
				
				// Keep the export file destination pathname
				$callback:=vp_newCallback("import-sjs"; $area; $params)
				$callback.path:=$filePath
				$callback.content:=$textBuffer
				$callback.sjsOptions:=$params.sjsOptions
				
				// Launch export
				$documentObject:=vp_runFunction($area; "import-sjs"; $callback)
				
			End if 
			
		End if 
		
	Else   // if not xls or 4VP then csv
		// MARK:- csv
		
		$textBuffer:=Document to text:C1236($filePath; "UTF-8"; ($params.csvOptions.rowDelimiter#Null:C1517) ? Document unchanged:K24:18 : Document with LF:K24:22)
		
		If (err_continue)
			
			$callback:=vp_newCallback("import-csv"; $area; $params)
			$callback.csvOptions:=($params.csvOptions#Null:C1517) ? OB Copy:C1225($params.csvOptions) : {}
			If ($callback.csvOptions.rowDelimiter=Null:C1517)
				$callback.csvOptions.rowDelimiter:=Char:C90(Line feed:K15:40)  // we read file with LF
			End if 
			$callback.csvOptions.csv:=$textBuffer
			
			vp_runFunction($area; "import-csv"; $callback)
			
		End if 
		
End case 

err_FINALLY
