//%attributes = {"invisible":true}
#DECLARE($area : Text; $sheetIndex : Variant) : Object

return WA Evaluate JavaScript:C1029(*; $area; (($sheetIndex=Null:C1517) || (0>$sheetIndex)) ? "_vp_getFonts()" : "_vp_getFonts("+String:C10($sheetIndex)+")"; Is object:K8:27)
