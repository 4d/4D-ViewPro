//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1; $elemRef)
C_TEXT:C284($2; $valueStr; $3; $fontSize)
C_OBJECT:C1216($4; $valObj)
C_BOOLEAN:C305($5; $isHtml)
C_POINTER:C301($6; $svgSrc)

C_REAL:C285($posX)
C_REAL:C285($posY)
C_LONGINT:C283($i; $j; $k)
//C_LONGINT($nbColumn; $nbChar;  $n)
//ARRAY LONGINT($columnArray; 0)
C_REAL:C285(char_space)
//C_BOOLEAN($word)
C_TEXT:C284($lf)

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
	C_COLLECTION:C1488($lines)
	C_TEXT:C284($word)
	
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