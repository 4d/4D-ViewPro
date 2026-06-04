//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Object
var $box : Object
var $2 : Text
var $svgRef : Text
var $3 : Text
var $color : Text
$box:=$1
$svgRef:=$2
$color:=$3

var $elemRef : Text
$elemRef:=DOM Create XML element:C865($svgRef;"/svg/line";"x1";$box.topLeft.x;"y1";$box.topLeft.y;"x2";$box.topRight.x;"y2";$box.topRight.y;"class";"top";"stroke";$color)
$elemRef:=DOM Create XML element:C865($svgRef;"/svg/line";"x1";$box.topRight.x;"y1";$box.topRight.y;"x2";$box.bottomRight.x;"y2";$box.bottomRight.y;"class";"right";"stroke";"black")
$elemRef:=DOM Create XML element:C865($svgRef;"/svg/line";"x1";$box.topLeft.x;"y1";$box.topLeft.y;"x2";$box.bottomLeft.x;"y2";$box.bottomLeft.y;"class";"left";"stroke";"black")
$elemRef:=DOM Create XML element:C865($svgRef;"/svg/line";"x1";$box.bottomLeft.x;"y1";$box.bottomLeft.y;"x2";$box.bottomRight.x;"y2";$box.bottomRight.y;"class";"bottom";"stroke";"black")