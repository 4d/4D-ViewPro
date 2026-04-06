//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($parentRef : Text; $node : Object)

var $elemRef : Text
var $attr; $child : Object

If ($node#Null:C1517)
	If (Value type:C1509($node.tag)=Is text:K8:3)
		$elemRef:=DOM Create XML element:C865($parentRef; $node.tag)
		
		If (Value type:C1509($node.attrs)=Is collection:K8:32)
			For each ($attr; $node.attrs)
				If ($attr#Null:C1517)
					If (Value type:C1509($attr.name)=Is text:K8:3)
						DOM SET XML ATTRIBUTE:C866($elemRef; $attr.name; $attr.value)
					End if 
				End if 
			End for each 
		End if 
		
		If (Value type:C1509($node.children)=Is collection:K8:32)
			For each ($child; $node.children)
				svg_appendConditionalVectorNode($elemRef; $child)
			End for each 
		End if 
	End if 
End if 
