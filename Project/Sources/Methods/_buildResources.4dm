//%attributes = {}
#DECLARE($folder : 4D:C1709.Folder; $area : Text)

var $text; $spreadTextResources; $designerTextResources; $path : Text
var $spreadResources; $designerResources : Object

$text:=WA Evaluate JavaScript:C1029(*; $area; "JSON.stringify(GC.Spread.Common.CultureManager.getResources())"; Is text:K8:3)
$spreadResources:=JSON Parse:C1218($text)
$spreadResources:=sortObject($spreadResources)
$spreadTextResources:=JSON Stringify:C1217($spreadResources; *)
$spreadTextResources:="var vp_spreadJsResources = "+$spreadTextResources


$text:=WA Evaluate JavaScript:C1029(*; $area; "JSON.stringify(GC.Spread.Sheets.Designer.getResources())")
$designerResources:=JSON Parse:C1218($text)
$designerResources:=sortObject($designerResources)
$designerTextResources:=JSON Stringify:C1217($designerResources; *)
$designerTextResources:="var vp_designerResources = "+$designerTextResources


$folder.file("spreadJS_localization_resources.en.js").setText($spreadTextResources; "UTF-8-no-bom")
$folder.file("designer_localization_resources.en.js").setText($designerTextResources; "UTF-8-no-bom")
