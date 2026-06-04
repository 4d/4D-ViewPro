//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Text
var $elemRef : Text
var $2 : Text
var $valueStr : Text
var $3 : Text
var $fontSize : Text
var $4 : Object
var $valObj : Object
var $5 : Boolean
var $isHtml : Boolean
var $6 : Pointer
var $svgSrc : Pointer
var $posX : Real
var $posY : Real
var $i : Integer
var $j : Integer
var $k : Integer
//ARRAY LONGINT($columnArray; 0)
var char_space : Real
var $lf : Text
$lf:="\n"

$elemRef:=$1
$valueStr:=$2
$fontSize:=$3
$valObj:=$4
$isHtml:=$5

If ($elemRef="")
	$svgSrc:=$6
End if 

If ($valObj.wordWrapInfo#Null:C1517)
	char_space:=$valObj.wordWrapInfo.lineHeight
Else 
	char_space:=(Num:C11($fontSize; ".")*1.23)
End if 

/*
If ($valObj.wordWrap=True)

$nbChar:=(($valObj.height-10)/char_space)
$nbColumn:=1



$j:=1
$k:=1
$n:=1
$word:=False
For ($i; 1; Length($valueStr))

If ($i=11)
//  TRACE
End if 

If ($valueStr[[$i]]=" ") | ($valueStr[[$i]]="-")
If ($word)
$word:=False
End if 

Else 
If (Not($word))
$n:=$i

$word:=True
End if 

End if 

Case of 
: ($i=(Length($valueStr)))
APPEND TO ARRAY($columnArray; $i-$k+1)

: ($j=$nbChar)
If ($n#$k)
$nbColumn:=$nbColumn+1
APPEND TO ARRAY($columnArray; $n-$k)
$i:=$n-1
$k:=$n

Else 
$nbColumn:=$nbColumn+1
APPEND TO ARRAY($columnArray; $nbChar)
$n:=$i+1
$k:=$i+1

End if 

$j:=0

: ($valueStr[[$i]]=$lf)
$nbColumn:=$nbColumn+1
APPEND TO ARRAY($columnArray; $i-$k+1)
$n:=$i+1
$k:=$n
$j:=0

End case 
$j:=$j+1
End for 
End if 
*/

Case of 
	: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
		$posX:=Choose:C955($isHtml; char_space/4; $valObj.x+(char_space/2))
		
	: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.wordWrapInfo=Null:C1517)
		$posX:=Choose:C955($isHtml; -(Num:C11($fontSize; ".")/2); $valObj.x)+($valObj.width/2)
		
	: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.wordWrapInfo=Null:C1517)
		$posX:=Choose:C955($isHtml; -char_space; $valObj.x-(char_space/2))+$valObj.width
		
	: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.wordWrapInfo#Null:C1517)
		$posX:=Choose:C955($isHtml; 0; $valObj.x)+($valObj.width/2)-((($valObj.wordWrapInfo.lines.length-Choose:C955($isHtml; 0.5; 1))/2)*char_space)
		
	: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.wordWrap#Null:C1517)
		$posX:=Choose:C955($isHtml; 0; $valObj.x)+$valObj.width-(($valObj.wordWrapInfo.lines.length-Choose:C955($isHtml; 0; 0.5))*char_space)
		
End case 

If ($valObj.wordWrapInfo#Null:C1517)
	var $lines : Collection
	var $word : Text
	$lines:=$valObj.wordWrapInfo.lines
	
	$i:=1
	For ($j; 0; ($lines.length-1))
		
		$word:=$lines[$j].text.text
		
		Case of 
			: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
				$posY:=Choose:C955($isHtml; Num:C11($fontSize; ".")/2; $valObj.y+char_space)
				
			: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
				$posY:=Choose:C955($isHtml; 0; $valObj.y)+($valObj.height/2)-(((Length:C16($word)-Choose:C955($isHtml; 0; 1.5))/2)*char_space)
				
			: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
				$posY:=Choose:C955($isHtml; 0; $valObj.y)+$valObj.height-((Length:C16($word)-Choose:C955($isHtml; 0; 0.5))*char_space)
		End case 
		For ($k; 1; Length:C16($word))
			
			If (($posX-Choose:C955($isHtml; 0; $valObj.x))>0) & (($posX-Choose:C955($isHtml; 0; $valObj.x))<$valObj.width)
				svg_printVerticalChar($elemRef; $word[[$k]]; $posX; $posY; $isHtml; $valObj; $svgSrc)
			End if 
			
			$posY:=$posY+char_space
			$i:=$i+1
			
		End for 
		$posX:=$posX+char_space
		
	End for 
	
Else 
	
	$posY:=svg_getVerticalYPos($valObj; $fontSize; $valueStr; $isHtml)
	
	For ($i; 1; Length:C16($valueStr))
		
		If (($posY-Choose:C955($isHtml; 0; $valObj.y)+char_space)>0) & (($posY-Choose:C955($isHtml; 0; $valObj.y))<($valObj.height+char_space))
			svg_printVerticalChar($elemRef; $valueStr[[$i]]; $posX; $posY; $isHtml; $valObj; $svgSrc)
		End if 
		$posY:=$posY+char_space
		
	End for 
	
	
End if 