//%attributes = {}
C_OBJECT:C1216($0; $1; $2)

// $1 -> objet de la nouvelle version avec des attributs en plus ou en moins
// $2 -> objet contenant les attributs localisés de la version précédente
// $0 -> objet contenant les attributs localisés de la nouvelle version, 
//       les nouveaux attribués proviennent de la nouvelle version et ne sont pas traduits

ARRAY TEXT:C222($arNames; 0)
ARRAY LONGINT:C221($arTypes; 0)
OB GET PROPERTY NAMES:C1232($2; $arNames)

// première phase, on copie la source et on retire tous les objets
// qui ont été supprimés dans la nouvelle version

$0:=OB Copy:C1225($2)

C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($arNames))
	If ($1[$arNames{$i}]=Null:C1517)
		OB REMOVE:C1226($0; $arNames{$i})
	End if 
End for 

// deuxième phase, on passe en revue toutes les propriétés de la nouvelle version
// et on ajoute celles qui ne sont pas dans la source

OB GET PROPERTY NAMES:C1232($1; $arNames; $arTypes)

For ($i; 1; Size of array:C274($arNames))
	If ($0[$arNames{$i}]=Null:C1517)
		// si la propriété n'existe pas on l'ajoute
		If ($arTypes{$i}=Is object:K8:27)
			$0[$arNames{$i}]:=OB Copy:C1225($1[$arNames{$i}])
		Else 
			$0[$arNames{$i}]:=$1[$arNames{$i}]
		End if 
	Else 
		// sinon on regarde si c'est un objet et on fait un appel récursif
		If ($arTypes{$i}=Is object:K8:27)
			$0[$arNames{$i}]:=OB Copy:C1225(mergeResources($1[$arNames{$i}]; $0[$arNames{$i}]))
		End if 
	End if 
End for 
