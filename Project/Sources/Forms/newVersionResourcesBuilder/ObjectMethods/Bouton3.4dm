var $path; $locPath; $spreadLocPath; $designerLocPath; $content : Text
var $i : Integer
var $localized; $newVersion; $updated : Object

$path:=Select folder:C670("select designer.custom folder")

If (ok=1)
	ARRAY TEXT:C222($arLocalizations; 4)
	$arLocalizations{1}:="fr"
	$arLocalizations{2}:="de"
	$arLocalizations{3}:="pt"
	$arLocalizations{4}:="es"
	
	For ($i; 1; Size of array:C274($arLocalizations))
		
		$locPath:=$path+$arLocalizations{$i}+".lproj"+Folder separator:K24:12
		
		// report des modifications dans les fichiers de localization de spreadJS
		$spreadLocPath:=$locPath+"gc.spread.sheets.resources."+$arLocalizations{$i}+".min.js"
		$content:=Document to text:C1236($spreadLocPath; "UTF-8-no-bom")
		$content:=Replace string:C233($content; "var vp_spreadJsResources = "; "")
		$localized:=JSON Parse:C1218($content)
		
		$content:=WA Evaluate JavaScript:C1029(*; "Zone Web"; "JSON.stringify(GC.Spread.Common.CultureManager.getResources())"; Is text:K8:3)
		$newVersion:=JSON Parse:C1218($content)
		
		$updated:=mergeResources($newVersion; $localized)
		$updated:=sortObject($updated)
		$content:=JSON Stringify:C1217($updated; *)
		$content:="var vp_spreadJsResources = "+$content
		
		TEXT TO DOCUMENT:C1237($spreadLocPath+".new"; $content; "UTF-8-no-bom")
		
		// report des modifications dans les fichiers de localization du designer
		$designerLocPath:=$locPath+"designer_localization_resources."+$arLocalizations{$i}+".js"
		$content:=Document to text:C1236($designerLocPath; "UTF-8-no-bom")
		$content:=Replace string:C233($content; "var vp_designerResources = "; "")
		$localized:=JSON Parse:C1218($content)
		
		$content:=WA Evaluate JavaScript:C1029(*; "Zone Web"; "JSON.stringify(GC.Spread.Sheets.Designer.getResources())")
		$newVersion:=JSON Parse:C1218($content)
		
		$updated:=mergeResources($newVersion; $localized)
		$updated:=sortObject($updated)
		$content:=JSON Stringify:C1217($updated; *)
		$content:="var vp_designerResources = "+$content
		
		TEXT TO DOCUMENT:C1237($designerLocPath+".new"; $content; "UTF-8-no-bom")
		
	End for 
End if 

ALERT:C41("done")
