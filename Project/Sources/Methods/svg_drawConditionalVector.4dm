//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($svgRef : Text; $vectorCol : Collection)

var $vectorObj; $vector; $node : Object
var $defsRef; $groupRef : Text

If ($vectorCol#Null:C1517)
	$defsRef:=""
	
	For each ($vectorObj; $vectorCol)
		If ($vectorObj#Null:C1517)
			If (Value type:C1509($vectorObj.vector)=Is object:K8:27)
				$vector:=$vectorObj.vector
				
				If (Value type:C1509($vector.defs)=Is collection:K8:32)
					If ($vector.defs.length>0)
						If ($defsRef="")
							$defsRef:=DOM Create XML element:C865($svgRef; "/svg/defs")
						End if 
						
						For each ($node; $vector.defs)
							svg_appendConditionalVectorNode($defsRef; $node)
						End for each 
					End if 
				End if 
				
				If (Value type:C1509($vector.elements)=Is collection:K8:32)
					If ($vector.elements.length>0)
						$groupRef:=DOM Create XML element:C865($svgRef; "/svg/g"; "transform"; "translate("+String:C10($vectorObj.x; "&xml;")+" "+String:C10($vectorObj.y; "&xml;")+")")
						
						For each ($node; $vector.elements)
							svg_appendConditionalVectorNode($groupRef; $node)
						End for each 
					End if 
				End if 
			End if 
		End if 
	End for each 
End if 
