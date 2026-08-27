//%attributes = {}
#DECLARE($current : Object; $previous : Object) : Object

var $key : Text

var $i : Integer
var $merged : Object

ARRAY TEXT:C222($arNames; 0)
ARRAY LONGINT:C221($arTypes; 0)

// $current -> objet de la nouvelle version avec des attributs en plus ou en moins
// $previous -> objet contenant les attributs localisés de la version précédente
// $merged -> objet contenant les attributs localisés de la nouvelle version,
//            les nouveaux attribus proviennent de la nouvelle version et ne sont pas traduits

// Première phase, on copie la source et on retire tous les objets
// Qui ont été supprimés dans la nouvelle version

$merged:=OB Copy:C1225($previous)

For each ($key; $previous)
	
	If ($current[$key]=Null:C1517)
		
		OB REMOVE:C1226($merged; $key)
		
	End if 
End for each 

// Deuxième phase, on passe en revue toutes les propriétés de la nouvelle version
// Et on ajoute celles qui ne sont pas dans la source

For each ($key; $current)
	
	If ($merged[$key]=Null:C1517)
		
		// Si la propriété n'existe pas on l'ajoute
		$merged[$key]:=Value type:C1509($current[$key])=Is object:K8:27\
			 ? OB Copy:C1225($current[$key])\
			 : $current[$key]
		
	Else 
		
		If (Value type:C1509($current[$key])=Is object:K8:27)
			
			$merged[$key]:=OB Copy:C1225(mergeResources($current[$key]; $merged[$key]))
			
		End if 
	End if 
End for each 

return $merged