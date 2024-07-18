//%attributes = {}
#DECLARE($folder : 4D:C1709.Folder; $area : Text; $prefix : Text)

var $locPath : 4D:C1709.Folder
var $spreadLocPath; $designerLocPath : 4D:C1709.File
var $localizations:=["fr"; "de"; "pt"; "es"]
var $localization; $content : Text
var $localized; $newVersion; $updated : Object

For each ($localization; $localizations)
	
	$locPath:=$folder.folder($localization+".lproj")
	
	// report des modifications dans les fichiers de localization de spreadJS
	$spreadLocPath:=$locPath.file("gc.spread.sheets.resources."+$localization+".min.js")
	$content:=$spreadLocPath.getText("UTF-8-no-bom")
	$content:=Replace string:C233($content; "var vp_spreadJsResources = "; "")
	$localized:=JSON Parse:C1218($content)
	
	$content:=WA Evaluate JavaScript:C1029(*; $area; "JSON.stringify(GC.Spread.Common.CultureManager.getResources())"; Is text:K8:3)
	$newVersion:=JSON Parse:C1218($content)
	
	$updated:=mergeResources($newVersion; $localized)
	$updated:=sortObject($updated)
	$content:=JSON Stringify:C1217($updated; *)
	$content:="var vp_spreadJsResources = "+$content
	
	$spreadLocPath.parent.file($spreadLocPath.fullName+".new").setText($content; "UTF-8-no-bom")
	
	// report des modifications dans les fichiers de localization du designer
	$designerLocPath:=$locPath.file("designer_localization_resources."+$localization+".js")
	$content:=$designerLocPath.getText("UTF-8-no-bom")
	$content:=Replace string:C233($content; "var vp_designerResources = "; "")
	$localized:=JSON Parse:C1218($content)
	
	$content:=WA Evaluate JavaScript:C1029(*; $area; "JSON.stringify(GC.Spread.Sheets.Designer.getResources())")
	$newVersion:=JSON Parse:C1218($content)
	
	$updated:=mergeResources($newVersion; $localized)
	$updated:=sortObject($updated)
	$content:=JSON Stringify:C1217($updated; *)
	$content:="var vp_designerResources = "+$content
	
	$designerLocPath.parent.file($designerLocPath.fullName+$prefix).setText($content; "UTF-8-no-bom")
	
End for each 