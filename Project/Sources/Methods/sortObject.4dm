//%attributes = {}
C_OBJECT:C1216($0; $1)
ARRAY TEXT:C222($arNames; 0)
ARRAY LONGINT:C221($arTypes; 0)
OB GET PROPERTY NAMES:C1232($1; $arNames; $arTypes)

$0:=New object:C1471
SORT ARRAY:C229($arNames; $arTypes)

For ($i; 1; Size of array:C274($arNames))
	If ($arTypes{$i}=Is object:K8:27)
		$0[$arNames{$i}]:=sortObject($1[$arNames{$i}])
	Else 
		$0[$arNames{$i}]:=$1[$arNames{$i}]
	End if 
End for 
