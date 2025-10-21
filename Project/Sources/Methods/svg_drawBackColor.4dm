//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1; $svgRef)
C_COLLECTION:C1488($2; $bcCol)

$svgRef:=$1
$bcCol:=$2

var $rect : Object
C_TEXT:C284($elemRef)
C_TEXT:C284($pointStr)

For each ($rect; $bcCol)
	If ($rect.isOriented)
		$pointStr:=String:C10($rect.x+$rect.offset; "&xml;")+","+String:C10($rect.y; "&xml;")+" "+String:C10($rect.x+$rect.w+$rect.offset; "&xml;")+","+String:C10($rect.y; "&xml")\
			+" "+String:C10($rect.x+$rect.w; "&xml;")+","+String:C10($rect.y+$rect.h; "&xml")+" "+String:C10($rect.x; "&xml;")+","+String:C10($rect.y+$rect.h; "&xml;")
		$elemRef:=DOM Create XML element:C865($svgRef; "/svg/polygon"; "points"; $pointStr; "fill"; $rect.c; "stroke"; $rect.c; "shape-rendering"; "crispEdges")
	Else 
		$elemRef:=DOM Create XML element:C865($svgRef; "/svg/rect"; "x"; $rect.x; "y"; $rect.y; "width"; $rect.w; "height"; $rect.h; "fill"; $rect.c; "shape-rendering"; "crispEdges")
	End if 
End for each 