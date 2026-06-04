//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Text
var $text : Text
var $2 : Object
var $fontObj : Object
var $0 : Real
var $style : Text
$text:=$1
$fontObj:=$2

$style:=""
If ($fontObj#Null:C1517)
	If ($fontObj.family#Null:C1517)
		$style:=$style+"font-family:\""+$fontObj.family+"\";"
	End if 
	
	If ($fontObj.size#Null:C1517)
		$style:=$style+"font-size:"+$fontObj.size+";"
	End if 
	
	If ($fontObj.weight#Null:C1517)
		$style:=$style+"font-weight:"+$fontObj.weight+";"
	End if 
	
	If ($fontObj.style#Null:C1517)
		$style:=$style+"font-style:"+$fontObj.style+";"
	End if 
	
	If ($fontObj.variant#Null:C1517)
		$style:=$style+"font-variant:"+$fontObj.variant+";"
	End if 
Else 
	$style:=$style+"font-family:\""+themeFont+"\";font-size:14.6664px;"
End if 


If (svgPicture=Null:C1517)
	var $svgSrc : Text
	var $svgRef : Text
	$text:=Replace string:C233($text; "&"; "&amp;")
	$text:=Replace string:C233($text; ">"; "&gt;")
	$text:=Replace string:C233($text; "<"; "&lt;")
	$text:=Replace string:C233($text; "\""; "&quot;")
	$text:=Replace string:C233($text; "'"; "&apos;")
	$text:=Replace string:C233($text; " "; "&#160;")
	
	$style:=Replace string:C233($style; "&"; "&amp;")
	$style:=Replace string:C233($style; ">"; "&gt;")
	$style:=Replace string:C233($style; "<"; "&lt;")
	$style:=Replace string:C233($style; "\""; "&quot;")
	$style:=Replace string:C233($style; "'"; "&apos;")
	//$text:=Replace string($text; " "; "&#160;")
	
	
	$svgSrc:="<?xml version=\"1.0\" encoding=\"UTF-16\" standalone=\"no\" ?><svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" >"
	$svgSrc:=$svgSrc+"<text id=\"1\" x=\"0\" y=\"0\" style=\""+$style+"\">"+$text+"</text></svg>"
	
	$svgRef:=DOM Parse XML variable:C720($svgSrc)
	
	SVG EXPORT TO PICTURE:C1017($svgRef; svgPicture; Get XML data source:K45:16)
	SVG SET ATTRIBUTE:C1055(svgPicture; ""; "4d-dynamicPictureSize"; True:C214; *)  // ask the bounds to be updated for each call to SVG SET ATTRIBUTE
	DOM CLOSE XML:C722($svgRef)
Else 
	
	SVG SET ATTRIBUTE:C1055(svgPicture; "1"; "style"; $style; "4d-text"; $text; *)
	
End if 

var $width : Real

var $height : Real
PICTURE PROPERTIES:C457(svgPicture; $width; $height)

$0:=$width

