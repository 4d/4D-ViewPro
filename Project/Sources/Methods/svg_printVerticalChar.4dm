//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Text
var $elemRef : Text
var $childRef : Text
var $2 : Text
var $c : Text
var $3 : Real
var $posX : Real
var $4 : Real
var $posY : Real
var $5 : Boolean
var $isHtml : Boolean
var $6 : Object
var $valObj : Object
var $7 : Pointer
var $svgSource : Pointer
$elemRef:=$1
$c:=$2
$posX:=$3
$posY:=$4
$isHtml:=$5
$valObj:=$6

If ($elemRef="")
	$svgSource:=$7
End if 

If ($isHtml=False:C215)
	
	If ($elemRef#"")
		$childRef:=DOM Create XML element:C865($elemRef; "tspan"; "text-anchor"; "middle"; "x"; $posX; "y"; $posY)
	Else 
		$svgSource->:=$svgSource->+"<tspan text-anchor=\"middle\" x=\""+String:C10($posX; "&xml;")+"\" y=\""+String:C10($posY; "&xml;")+"\">"
	End if 
	
Else 
	//$svgSource->:=$svgSource->+"<p style=\"left:"+String($posX;"&xml;")+"px;top:"+String($posY-char_space;"&xml;")+"px;"
	
	var $styleStr : Text
	$styleStr:="left:"+String:C10($posX; "&xml;")+"px;top:"+String:C10($posY-char_space; "&xml;")+"px;"
	
	Case of 
		: ($valObj.textDecoration=Null:C1517)
		: (Position:C15("line-through"; $valObj.textDecoration)>0)
			$styleStr:=$styleStr+"text-decoration:line-through;"
			
			//$svgSource->:=$svgSource->+"text-decoration:line-through;"
	End case 
	
	$childRef:=DOM Create XML element:C865($elemRef; "p"; "style"; $styleStr)
	
	//$svgSource->:=$svgSource->+"\">"
End if 

If ($elemRef#"")
	DOM SET XML ELEMENT VALUE:C868($childRef; $c)
Else 
	Case of 
		: ($c="&")
			$svgSource->:=$svgSource->+"&amp;"
		: ($c=">")
			$svgSource->:=$svgSource->+"&gt;"
		: ($c="<")
			$svgSource->:=$svgSource->+"&lt;"
		: ($c="\"")
			$svgSource->:=$svgSource->+"&quot;"
		: ($c="'")
			$svgSource->:=$svgSource->+"&apos;"
		Else 
			$svgSource->:=$svgSource->+$c
	End case 
	
	//If ($isHtml=False)
	$svgSource->:=$svgSource->+"</tspan>"
	//Else 
	//$svgSource->:=$svgSource->+"</p>"
	//End if 
End if 