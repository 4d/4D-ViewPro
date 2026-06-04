//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Object
var $valObj : Object
var $2 : Text
var $fontSize : Text
var $3 : Text
var $valueStr : Text
var $4 : Boolean
var $isHtml : Boolean
var $0 : Real
$valObj:=$1
$fontSize:=$2
$valueStr:=$3
$isHtml:=$4

Case of 
	: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
		$0:=Choose:C955($isHtml;Num:C11($fontSize;".")/2;$valObj.y+char_space)
		
	: ($valObj.vAlign=CENTER_VERTICAL_ALIGN) & ($valObj.wordWrap=False:C215)
		$0:=Choose:C955($isHtml;0;$valObj.y)+($valObj.height/2)-(((Length:C16($valueStr)-Choose:C955($isHtml;0;1.5))*char_space)/2)
		
	: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN) & ($valObj.wordWrap=False:C215)
		$0:=Choose:C955($isHtml;0;$valObj.y-4)+$valObj.height-((Length:C16($valueStr)-Choose:C955($isHtml;0;1))*char_space)
		
End case 