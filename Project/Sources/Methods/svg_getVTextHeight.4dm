//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$text)
C_OBJECT:C1216($2;$fontObj)
C_LONGINT:C283($0)

$text:=$1
$fontObj:=$2

C_TEXT:C284($svgSrc)
C_TEXT:C284($svgRef)
C_PICTURE:C286($svgImg)
C_LONGINT:C283($height)
C_LONGINT:C283($width)
C_OBJECT:C1216($valObj)
C_TEXT:C284($fontSize)


$svgSrc:="<?xml version=\"1.0\" encoding=\"UTF-16\" standalone=\"no\" ?><svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">"
$svgSrc:=$svgSrc+"<text style=\""

$fontSize:="14.6664px"

If ($fontObj#Null:C1517)
	If ($fontObj.family#Null:C1517)
		$svgSrc:=$svgSrc+"font-family:"+$fontObj.family+";"
	End if 
	
	If ($fontObj.size#Null:C1517)
		$svgSrc:=$svgSrc+"font-size:"+$fontObj.size+";"
		$fontSize:=$fontObj.size
	End if 
	
	If ($fontObj.weight#Null:C1517)
		$svgSrc:=$svgSrc+"font-weight:"+$fontObj.weight+";"
	End if 
	
	If ($fontObj.style#Null:C1517)
		$svgSrc:=$svgSrc+"font-style:"+$fontObj.style+";"
	End if 
	
	If ($fontObj.variant#Null:C1517)
		$svgSrc:=$svgSrc+"font-variant:"+$fontObj.variant+";"
	End if 
Else 
	$svgSrc:=$svgSrc+"font-family:"+themeFont+";font-size:14.6664px;"
End if 

$svgSrc:=$svgSrc+"\">"

$valObj:=New object:C1471("x";0;"y";0;"height";1000;"wordWrap";False:C215;"hAlign";LEFT_HORIZONTAL_ALIGN;"vAlign";TOP_VERTICAL_ALIGN)

svg_printVerticalText ("";$text;$fontSize;$valObj;False:C215;->$svgSrc)

$svgSrc:=$svgSrc+"</text>"
$svgSrc:=$svgSrc+"</svg>"

$svgRef:=DOM Parse XML variable:C720($svgSrc)

SVG EXPORT TO PICTURE:C1017($svgRef;$svgImg)

PICTURE PROPERTIES:C457($svgImg;$width;$height)

$0:=$height

