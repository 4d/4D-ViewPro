//%attributes = {"invisible":true,"shared":true}
// The VP EXPORT DOCUMENT command exports the 4D View Pro object attached to the 4D View Pro area vpAreaName
// to a document on disk according to the filePath parameter.
// Pass in vpAreaName the object name property of the area in the 4D form. If you pass an invalid name, an error is returned.  
// In filePath, pass the destination path and name of the document to be exported. If you pass only the document name, it will be saved at the same level as the 4D structure file. 
// 4D View Pro document extension is ".4vp". It is automatically added to the document name if not passed in filePath.
#DECLARE($area : Text; $filePath : Text; $params : Object)

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

var $pathObject:=vp_Path($filePath; String:C10($params.format))
$filePath:=Object to path:C1548($pathObject)

var $callback; $areaVariable : Object
Case of 
		
		//______________________________________________________
	: (Length:C16($filePath)=0)
		
		err_THROW({component: "xbox"; code: 3107/*Output document path is empty*/})
		
		//______________________________________________________
		// MARK:-4vp
	: ($pathObject.extension=".4vp")
		
		// Gets the json description of the area content
		var $documentObject:=vp_runFunction($area; "export-json"; $params)
		
		Case of 
				//………………………………………………………………………………………
			: (Not:C34(err_continue))
				
				//………………………………………………………………………………………
			: ($documentObject=Null:C1517)
				
				err_THROW({code: 2/*Internal error*/; message: "export-json"})
				
				//………………………………………………………………………………………
			Else 
				
				vp_METADATA($documentObject)
				
				If (Storage:C1525.ViewPro.options.prettyPrint)  // Pretty print
					
					TEXT TO DOCUMENT:C1237($filePath; JSON Stringify:C1217($documentObject; *))
					
				Else 
					
					TEXT TO DOCUMENT:C1237($filePath; JSON Stringify:C1217($documentObject))
					
				End if 
				
				If (err_continue)
					
					vp_syncCallback("export-4VP"; $area; $params; $filePath)
					
				End if 
				
				//………………………………………………………………………………………
		End case 
		
		// MARK:- xlsx/pdf/sjs
	: ($pathObject.extension=".xlsx")\
		 || ($pathObject.extension=".pdf")\
		 || ($pathObject.extension=".sjs")
		
		// We must keep parameters for later use
		// when the asynchronous export will be ending
		
		// Keep the export file destination pathname
		$callback:=vp_newCallback(""/*command*/; $area; $params)
		$callback.path:=$filePath
		$callback.sheetIndex:=-2
		
		// MARK: sjs
		If ($pathObject.extension=".sjs")
			
			$callback.command:="export-sjs"
			$callback.sjsOptions:=$params.sjsOptions
			
			$documentObject:=vp_runFunction($area; $callback.command; $callback)
			
		Else 
			Case of 
					
					// MARK: xlsx
				: ($pathObject.extension=".xlsx")
					
					$callback.command:="export-excel"
					$callback.password:=$params.password
					$callback.excelOptions:=$params.excelOptions
					$callback.excelIO:=$params.excelIO
					
					// serialization option for excelio
					$callback.valuesOnly:=$params.valuesOnly
					$callback.includeBindingSource:=$params.includeBindingSource
					
					// MARK: pdf
				: ($pathObject.extension=".pdf")
					
					$callback.command:="export-pdf"
					$callback.pdfOptions:=$params.pdfOptions
					$callback.fonts:=vp_computeFonts(vp_getFonts($area; $params.sheetIndex))
					If (OB Is defined:C1231($params; "sheetIndex"))
						$callback.sheetIndex:=$params.sheetIndex
					End if 
					
					//……………………………………………………………………………………
			End case 
			
			// check
			Case of 
				: (OB Get type:C1230($callback; "sheetIndex")#Is real:K8:4)
					err_THROW({code: 21/*Sheet index should be a numeric value*/})
				: ($callback.sheetIndex<-2)
					err_THROW({code: 17/*sheet index must be greather than -2*/})
				: ($callback.sheetIndex>=VP Get sheet count($area))
					err_THROW({code: 19/* Sheet index should not be greater than or equal to the number of sheets*/})
				Else 
					// Launch export
					$documentObject:=vp_runFunction($area; $callback.command; $callback)
			End case 
			
		End if 
		//______________________________________________________
	Else 
		
		// MARK:- csv
		// if not one of those extension, this is a csv export
		var $csvParams:=OB Copy:C1225($params)
		If ($csvParams.csvOptions=Null:C1517)
			$csvParams.csvOptions:={}
		End if 
		
		If ($csvParams.csvOptions.range=Null:C1517)
			$csvParams.csvOptions.range:=VP All($area)
		End if 
		
		If (Value type:C1509($csvParams.csvOptions.range)#Is object:K8:27)
			err_THROW({code: 22/*Range is mandatory to export a csv file.*/})
		Else 
			
			// Gets the json description of the area content
			$documentObject:=vp_runFunction($area; "export-csv"; $csvParams.csvOptions)
			
			Case of 
					//………………………………………………………………………………………
				: (Not:C34(err_continue))
					
					//………………………………………………………………………………………
				: ($documentObject=Null:C1517)
					
					err_THROW({code: 2/*Internal error*/; message: "export-csv"})
					
					//………………………………………………………………………………………
				Else 
					
					TEXT TO DOCUMENT:C1237($filePath; $documentObject.csv; "UTF-8"; ($params.csvOptions.rowDelimiter=Null:C1517) ? Document with CRLF:K24:20 : Document unchanged:K24:18)
					
					If (err_continue)
						
						vp_syncCallback("export-csv"; $area; $params; $filePath)
						
					End if 
					
					//………………………………………………………………………………………
			End case 
		End if 
End case 

If (Not:C34(err_continue))
	
	// Main error
	err_THROW({code: 8/* Cannot create file "{name}"*/; name: Path to object:C1547($filePath).name})
	
End if 


err_FINALLY
