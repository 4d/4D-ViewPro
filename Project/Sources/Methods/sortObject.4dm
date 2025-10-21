//%attributes = {}
#DECLARE($in : Object) : Object

ARRAY TEXT:C222($arNames; 0)
ARRAY LONGINT:C221($arTypes; 0)
OB GET PROPERTY NAMES:C1232($in; $arNames; $arTypes)

var $out:={}
SORT ARRAY:C229($arNames; $arTypes)

var $i : Integer
For ($i; 1; Size of array:C274($arNames))
	If ($arTypes{$i}=Is object:K8:27)
		$out[$arNames{$i}]:=sortObject($in[$arNames{$i}])
	Else 
		$out[$arNames{$i}]:=$in[$arNames{$i}]
	End if 
End for 

return $out