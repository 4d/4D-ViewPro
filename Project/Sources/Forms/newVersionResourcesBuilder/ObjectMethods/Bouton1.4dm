// buid SpreadJS resources
C_TEXT:C284($text; $spreadTextResources; $designerTextResources; $path)
C_OBJECT:C1216($spreadResources; $designerResources)

$text:=WA Evaluate JavaScript:C1029(*; "Zone Web"; "JSON.stringify(GC.Spread.Common.CultureManager.getResources())"; Is text:K8:3)
$spreadResources:=JSON Parse:C1218($text)
$spreadResources:=sortObject($spreadResources)
$spreadTextResources:=JSON Stringify:C1217($spreadResources; *)
$spreadTextResources:="var vp_spreadJsResources = "+$spreadTextResources


$text:=WA Evaluate JavaScript:C1029(*; "Zone Web"; "JSON.stringify(GC.Spread.Sheets.Designer.getResources())")
$designerResources:=JSON Parse:C1218($text)
$designerResources:=sortObject($designerResources)
$designerTextResources:=JSON Stringify:C1217($designerResources; *)
$designerTextResources:="var vp_designerResources = "+$designerTextResources

$path:=Select folder:C670("select destination folder")
If (ok=1)
	TEXT TO DOCUMENT:C1237($path+"spreadJS_localization_resources.en.js"; $spreadTextResources; "UTF-8-no-bom")
	TEXT TO DOCUMENT:C1237($path+"designer_localization_resources.en.js"; $designerTextResources; "UTF-8-no-bom")
End if 