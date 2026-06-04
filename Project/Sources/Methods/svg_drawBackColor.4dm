//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Text
var $svgRef : Text
var $2 : Collection
var $bcCol : Collection
$svgRef:=$1
$bcCol:=$2

var $rect : Object
var $elemRef : Text
var $pointStr : Text
For each ($rect;$bcCol)
	If ($rect.isOriented)
		$pointStr:=String:C10($rect.x+$rect.offset;"&xml;")+","+String:C10($rect.y;"&xml;")+" "+String:C10($rect.x+$rect.w+$rect.offset;"&xml;")+","+String:C10($rect.y;"&xml")\
			+" "+String:C10($rect.x+$rect.w;"&xml;")+","+String:C10($rect.y+$rect.h;"&xml")+" "+String:C10($rect.x;"&xml;")+","+String:C10($rect.y+$rect.h;"&xml;")
		$elemRef:=DOM Create XML element:C865($svgRef;"/svg/polygon";"points";$pointStr;"fill";$rect.c;"stroke";$rect.c;"shape-rendering";"crispEdges")
	Else 
		$elemRef:=DOM Create XML element:C865($svgRef;"/svg/rect";"x";$rect.x;"y";$rect.y;"width";$rect.w;"height";$rect.h;"fill";$rect.c;"shape-rendering";"crispEdges")
	End if 
End for each 