//%attributes = {"invisible":true,"preemptive":"capable"}
C_COLLECTION:C1488($2; $valCol)
C_TEXT:C284($1; $svgRef)
C_OBJECT:C1216($valObj)
C_LONGINT:C283($3; $svgHeight; $4; $svgWidth)
C_TEXT:C284($valueStr)

// C_TEXT($htmlHAlign; $htmlVAlign)
// C_TEXT($switchRef; $foRef; $bodyRef; $divRef)

C_TEXT:C284($styleStr; $gRef; $elemRef)

C_TEXT:C284($fontSize)
C_REAL:C285($lineHeight)

$fontSize:="14.6664px"
$lineHeight:=17.5997

$svgRef:=$1
$valCol:=$2
$svgHeight:=$3
$svgWidth:=$4

If ($valCol.length>0)
	
	// COMMENTED CODE BELOW WAS TO USE HTML FOR UNSUPPORTED SVG FEATURE IN WEB BROWSER //
	
	//$switchRef:=DOM Create XML element($svgRef; "/svg/switch")
	//$foRef:=DOM Create XML element($switchRef; "foreignObject"; "requiredFeatures"; "http://www.w3.org/TR/SVG11/feature#Extensibility"; "height"; $svgHeight; "width"; $svgWidth; "x"; 0; "y"; 0)
	//$bodyRef:=DOM Create XML element($foRef; "body"; "xmlns"; "http://www.w3.org/1999/xhtml"; "style"; "height:"+String($svgHeight)+"px; width:"+String($svgWidth)+"px; top:0px; left:0px; margin:0px;"; "onload"; "fit_textarea()")
	//$elemRef:=DOM Create XML element($bodyRef; "script"; "type"; "text/javascript"; "language"; "javascript")
	//DOM SET XML ELEMENT VALUE($elemRef; "function fit_textarea(){var elemTab=document.getElementsByTagName(\"textarea\");for(var i=0;i < elemTab.length;i++){elemTab[i].style.height=\"0px\";elemTab[i].style.height=elemTab[i].scrollHeight+\"px"+"\";}"+"}")
	//$elemRef:=DOM Create XML element($bodyRef; "style")
	//DOM SET XML ELEMENT VALUE($elemRef; "p{position:absolute;}div{position:absolute;overflow:hidden;}textarea{position:absolute;font:"+$fontSize+" "+themeFont+";border:none;resize:none;background:transparent;}textarea:focus{outline:none;}")
	
/*
For each ($valObj; $valCol)
	
$fontSize:="14.6664px"
	
$valueStr:=String($valObj.value)
	
If ($valObj.textIndent#"")
Case of 
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False)
If ($valObj.wordWrap=True)
$valObj.x:=$valObj.x+(Num($valObj.textIndent)*8)
$valObj.width:=$valObj.width-(Num($valObj.textIndent)*16)
	
End if 
	
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False)
$valObj.x:=$valObj.x+(Num($valObj.textIndent)*8)
$valObj.width:=$valObj.width-(Num($valObj.textIndent)*8)
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False)
$valObj.width:=$valObj.width-(Num($valObj.textIndent)*8)
	
: ($valObj.vAlign=TOP_VERTICAL_ALIGN) & ($valObj.isVerticalText=True)
$valObj.y:=$valObj.y+(Num($valObj.textIndent)*8)
$valObj.height:=$valObj.height-(Num($valObj.textIndent)*8)
	
	
: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN) & ($valObj.isVerticalText=True)
$valObj.height:=$valObj.height-(Num($valObj.textIndent)*8)
	
End case 
End if 
	
If ($valObj.cellPadding#Null)
$valObj.x:=$valObj.x+Num($valObj.cellPadding.left)
$valObj.y:=$valObj.y+Num($valObj.cellPadding.top)
$valObj.width:=$valObj.width-Num($valObj.cellPadding.left)-Num($valObj.cellPadding.right)
$valObj.height:=$valObj.height-Num($valObj.cellPadding.top)-Num($valObj.cellPadding.bottom)
	
End if 
	
Case of 
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
$htmlHAlign:="left"
	
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
$htmlHAlign:="center"
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
$htmlHAlign:="right"
	
End case 
	
Case of 
: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
$htmlVAlign:="top"
	
: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
$htmlVAlign:="middle"
	
: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
$htmlVAlign:="bottom"
	
End case 
	
$styleStr:=""
Case of 
: ($valObj.textWidth>$valObj.width) & ($valObj.cellPadding#Null) & ($valObj.wordWrap=False) & ($valObj.isVerticalText=False)
$styleStr:=$styleStr+"height:"+String($valObj.height+Num($valObj.cellPadding.top)+Num($valObj.cellPadding.bottom); "&xml;")+"px;top:"+String($valObj.y-Num($valObj.cellPadding.top); "&xml;")+"px;"
	
Else 
$styleStr:=$styleStr+"height:"+String($valObj.height; "&xml;")+"px;top:"+String($valObj.y; "&xml;")+"px;"
End case 
	
If (($valObj.isVerticalText) | ($valObj.isMerged#FREE)) & ($valObj.wordWrapInfo=Null)
$styleStr:=$styleStr+"left:"+String($valObj.x; "&xml;")+"px;width:"+String($valObj.width)+"px;"
	
Else 
Case of 
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.rightOverflow=$valObj.cellBorderRight) & ($valObj.cellPadding#Null)
$styleStr:=$styleStr+"left:"+String($valObj.x; "&xml;")+"px;width:"+String($valObj.width; "&xml;")+"px;"
	
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.leftOverflow=$valObj.cellBorderLeft) & ($valObj.rightOverflow=$valObj.cellBorderRight) & ($valObj.cellPadding#Null)
$styleStr:=$styleStr+"left:"+String($valObj.x; "&xml;")+"px;width:"+String($valObj.width; "&xml;")+"px;"
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.leftOverflow=$valObj.cellBorderLeft) & ($valObj.cellPadding#Null)
$styleStr:=$styleStr+"left:"+String($valObj.x; "&xml;")+"px;width:"+String($valObj.width; "&xml;")+"px;"
	
: ($valObj.wordWrapInfo#Null)
$styleStr:=$styleStr+"left:"+String($valObj.leftOverflow; "&xml;")+"px;width:"+String($valObj.rightOverflow-$valObj.leftOverflow; "&xml;")+"px;"
	
Else 
$styleStr:=$styleStr+"left:"+String($valObj.leftOverflow; "&xml;")+"px;width:"+String($valObj.rightOverflow-$valObj.leftOverflow; "&xml;")+"px;"
	
End case 
End if 
	
If ($valObj.isVerticalText)
$styleStr:=$styleStr+"overflow:hidden;"
	
End if 
	
If ($valObj.isVerticalText=False)
$elemRef:=DOM Create XML element($bodyRef; "div"; "style"; $styleStr)
$divRef:=$elemRef
$styleStr:=""
	
If ($valObj.vAlign=CENTER_VERTICAL_ALIGN) & ($valObj.cellPadding#Null) & ($valObj.height>0) & ($valObj.textWidth>$valobj.width) & (($valObj.textOrientation=0) | ($valObj.textOrientation=NONE_TEXT_ORIENTATION)) & ($valObj.wordWrapInfo=Null) & ($valObj.isMerged=FREE)
$elemRef:=DOM Create XML element($elemRef; "div"; "style"; "left:0px;width:"+String($valObj.rightOverflow-$valObj.leftOverflow)+"px;top:"+$valObj.cellPadding.top+"px;height:"+String($valObj.height)+"px;")
End if 
	
End if 
	
If ($valObj.wordWrap=False) & ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False) & ($valObj.strPart=Null) & (($valObj.textOrientation=0) | ($valObj.textOrientation=NONE_TEXT_ORIENTATION)) & ($valObj.wordWrapInfo=Null) & ($valObj.isMerged=FREE)
$elemRef:=DOM Create XML element($elemRef; "div"; "style"; "top:0px;left:"+String($valObj.x-$valObj.leftOverflow; "&xml;")+"px;width:"+String($valObj.width)+"px;height:"+String($valObj.height)+"px;overflow:visible;")
	
End if 
	
If ($valObj.isVerticalText=False) & ($valObj.wordWrapInfo=Null)
$elemRef:=DOM Create XML element($elemRef; "textarea")
	
End if 
	
If ($valObj.textDecoration#"")
$styleStr:=$styleStr+"text-decoration:"+$valObj.textDecoration+";"
	
End if 
	
If ($valObj.foreColor#"")
$styleStr:=$styleStr+"color:"+$valObj.foreColor+";"
	
End if 
	
If ($valObj.font#"")
If ($valObj.shrinkToFit#"") & (Num($valObj.shrinkToFit; ".")<Num($fontSize; "."))
If ($valObj.fontObj.family#Null)
$styleStr:=$styleStr+"font-family:"+$valObj.fontObj.family+";"
	
End if 
	
If ($valObj.fontObj.size#Null)
$fontSize:=$valObj.fontObj.size
	
If ($valObj.shrinkToFit#"") & (Num($valObj.shrinkToFit; ".")<Num($fontSize; "."))
$styleStr:=$styleStr+"font-size:"+$valObj.shrinkToFit+";"
	
Else 
$styleStr:=$styleStr+"font-size:"+$fontSize+";"
	
End if 
	
End if 
	
If ($valObj.fontObj.weight#Null)
$styleStr:=$styleStr+"font-weight:"+$valObj.fontObj.weight+";"
	
End if 
	
If ($valObj.fontObj.style#Null)
$styleStr:=$styleStr+"font-style:"+$valObj.fontObj.style+";"
	
End if 
	
If ($valObj.fontObj.variant#Null)
$styleStr:=$styleStr+"font-variant:"+$valObj.fontObj.variant+";"
	
End if 
Else 
$styleStr:=$styleStr+"font:"+$valObj.font+";"
	
End if 
$lineHeight:=$valObj.fontObj.lineHeight
Else 
If ($valObj.shrinkToFit#"") & (Num($valObj.shrinkToFit; ".")<Num($fontSize; "."))
$styleStr:=$styleStr+"font-size:"+$valObj.shrinkToFit+";"
	
Else 
$styleStr:=$styleStr+"font-size:"+$fontSize+";"
	
End if 
	
End if 
	
If ($valObj.wordWrapInfo#Null)
	
If ($valObj.textOrientation=0) | ($valObj.textOrientation=NONE_TEXT_ORIENTATION)
	
C_LONGINT($anchorX; $anchorY)
	
$lineHeight:=$valObj.wordWrapInfo.lineHeight
	
$anchorX:=$valObj.x
	
Case of 
: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
$anchorY:=$valObj.y
$i:=0
	
: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
$anchorY:=$valObj.y+$valObj.height-$lineHeight
$i:=$valObj.wordWrapInfo.lines.length-1
	
Else 
$anchorY:=$valObj.y+($valObj.height/2)-($lineHeight*$valObj.wordWrapInfo.lines.length/2)
$i:=0
	
End case 
	
C_REAL($lastX; $posX; $posY)
C_OBJECT($line)
	
$lastX:=-1
While ($i>=0) & ($i<$valObj.wordWrapInfo.lines.length)
	
$line:=$valObj.wordWrapInfo.lines[$i]
	
$posY:=$anchorY
	
$elemRef:=DOM Create XML element($divRef; "textarea"; "style"; "top:"+String($posY; "&xml;")+"px;left:"+String($anchorX-$valObj.leftOverflow; "&xml;")+"px;width:"+String($line.width; "&xml;")+"px;")
DOM SET XML ELEMENT VALUE($elemRef; $line.text)
	
If ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
$i:=$i-1
$anchorY:=$anchorY-$lineHeight
	
Else 
$i:=$i+1
$anchorY:=$anchorY+$lineHeight
	
End if 
	
End while 
	
Else 
C_LONGINT($step)
C_REAL($offset; $stickX; $stickY; $lastX; $textTranslationX; $textTranslationY)
C_TEXT($HStickCorner; $VStickCorner)
C_OBJECT($rotatedTextBox; $translatedTextBox; $initialTextBox; $rotatedBigBox; $translatedBigBox; $initialBigBox; $line)
	
$lineHeight:=$valObj.wordWrapInfo.lineHeight
$boxWidth:=$valObj.wordWrapInfo.boxWidth
$radOrientation:=$valObj.textOrientation*Degree
$offset:=$lineHeight/Cos((90-$valObj.textOrientation)*Degree)
	
Case of 
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
$stickX:=$valObj.x+1.757
	
If ($valObj.textOrientation>0)
$HStickCorner:="topLeft"
$i:=0
$step:=1
	
Else 
$HStickCorner:="bottomLeft"
$i:=$valObj.wordWrapInfo.lines.length-1
$step:=-1
	
End if 
	
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
$stickX:=$valObj.x+($valObj.width/2)-((Abs(Cos($radOrientation)*$boxWidth)+(($valObj.wordWrapInfo.lines.length-1)*$offset)+Abs(Sin($radOrientation)*$lineHeight))/2)
$i:=0
$step:=1
	
If ($valObj.textOrientation>0)
$HStickCorner:="topLeft"
	
Else 
$HStickCorner:="bottomLeft"
	
End if 
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
$stickX:=$valObj.x+$valObj.width-1.75
	
If ($valObj.textOrientation>0)
$HStickCorner:="bottomRight"
$i:=$valObj.wordWrapInfo.lines.length-1
$step:=-1
	
Else 
$HStickCorner:="topRight"
$i:=0
$step:=1
	
End if 
	
End case 
	
Case of 
: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
$stickY:=$valObj.y+1.75
	
If ($valObj.textOrientation>0)
$VStickCorner:="topRight"
	
Else 
$VStickCorner:="topLeft"
	
End if 
	
: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
$stickY:=$valObj.y+($valObj.height/2)-((Abs(Sin($radOrientation)*$boxWidth)+Abs(Cos($radOrientation)*$lineHeight))/2)
	
If ($valObj.textOrientation>0)
$VStickCorner:="topRight"
	
Else 
$VStickCorner:="topLeft"
	
End if 
	
: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
$stickY:=$valObj.y+$valObj.height-4
	
If ($valObj.textOrientation>0)
$VStickCorner:="bottomLeft"
	
Else 
$VStickCorner:="bottomRight"
	
End if 
	
End case 
	
$lastX:=-1
While ($i>=0) & ($i<$valObj.wordWrapInfo.lines.length)
	
$line:=$valObj.wordWrapInfo.lines[$i]
	
$initialBigBox:=svg_getHTMLTextBox($valObj.x; $valObj.y+(0.8*$lineHeight); $boxWidth; $lineHeight)
$initialTextBox:=svg_getWrappedLineBoxFromBigBox($initialBigBox; $line)
	
$rotatedBigBox:=svg_getRotatedBox($initialBigBox; $initialBigBox.topLeft.x; $initialBigBox.topLeft.y; $radOrientation)
$rotatedTextBox:=svg_getRotatedBox($initialTextBox; $initialBigBox.topLeft.x; $initialBigBox.topLeft.y; $radOrientation)
	
If ($lastX=-1)
$translationX:=$stickX-$rotatedBigBox[$HStickCorner].x
	
Else 
$translationX:=$lastX-$rotatedBigBox[$VStickCorner].x+($offset*$step)
	
End if 
	
$translationY:=$stickY-$rotatedBigBox[$VStickCorner].y
	
$translatedBigBox:=svg_getTranslatedBox($rotatedBigBox; $translationX; $translationY)
$translatedTextBox:=svg_getTranslatedBox($rotatedTextBox; $translationX; $translationY)
	
$translationX2:=0
If ($lastX=-1) & ($valObj.borderOrientation) & ($valObj.textOrientation#90) & ($valObj.textOrientation#-90)
C_OBJECT($P)
Case of 
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
$P:=svg_findIntersection($translatedBigBox[$HStickCorner].x; $translatedBigBox[$HStickCorner].y; $valObj.x; $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset; $valObj.y)
	
$translationX2:=$P.x-$translatedBigBox[$HStickCorner].x
	
$translatedBigBox:=svg_getTranslatedBox($translatedBigBox; $translationX2; 0)
$translatedTextBox:=svg_getTranslatedBox($translatedTextBox; $translationX2; 0)
	
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
$P:=svg_findIntersection($translatedBigBox[$HStickCorner].x; ($translatedBigBox.topLeft.y+$translatedBigBox.bottomRight.y)/2; $valObj.x+($valObj.width/2); $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset+($valObj.width/2); $valObj.y)
	
$translationX2:=$P.x-$translatedBigBox[$HStickCorner].x-((Abs(Cos($radOrientation)*$boxWidth)+(($valObj.wordWrapInfo.lines.length-1)*$offset)+Abs(Sin($radOrientation)*$lineHeight))/2)
	
$translatedBigBox:=svg_getTranslatedBox($translatedBigBox; $translationX2; 0)
$translatedTextBox:=svg_getTranslatedBox($translatedTextBox; $translationX2; 0)
	
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
$P:=svg_findIntersection($translatedBigBox[$HStickCorner].x; $translatedBigBox[$HStickCorner].y; $valObj.x+$valObj.width; $valObj.y+$valObj.height; $valObj.x+$valObj.width+$valObj.borderOffset; $valObj.y)
	
$translationX2:=$P.x-$translatedBigBox[$HStickCorner].x
	
$translatedBigBox:=svg_getTranslatedBox($translatedBigBox; $translationX2; 0)
$translatedTextBox:=svg_getTranslatedBox($translatedTextBox; $translationX2; 0)
	
End case 
End if 
	
$lastX:=$translatedBigBox[$VStickCorner].x
	
//svg_displayBox ($translatedBigBox;$svgRef;"red")
	
//svg_displayBox ($translatedTextBox;$svgRef;"green")
	
$textTranslationX:=$translatedTextBox.topLeft.x-($valObj.x+1.75)
$textTranslationY:=$translatedTextBox.topLeft.y-($valObj.y+1.75)
	
$elemRef:=DOM Create XML element($divRef; "textarea"; "style"; "transform-origin:top left;transform:rotate("+String(-$valObj.textOrientation; "&xml;")+"deg);top:"+String($textTranslationY; "&xml;")+"px;left:"+String($textTranslationX+($valObj.x-$valObj.leftOverflow); "&xml;")+"px;")
DOM SET XML ELEMENT VALUE($elemRef; $line.text)
	
$i:=$i+$step
	
End while 
	
End if 
	
Else 
If ($valObj.isVerticalText=False)
If ($valObj.wordWrap=False)
$styleStr:=$styleStr+"width:"+String($valObj.textWidth)+"px;"
	
Else 
$styleStr:=$styleStr+"width:"+String($valObj.width-4)+"px;"
	
End if 
	
If ($valObj.textOrientation#0) & ($valObj.textOrientation#NONE_TEXT_ORIENTATION)
$styleStr:=$styleStr+"transform-origin:top left;transform:rotate("+String(-$valObj.textOrientation; "&xml;")+"deg);"
	
If ($valObj.shrinkToFit#"")
$lineHeight:=1.2*Num($valObj.shrinkToFit; ".")
End if 
	
C_OBJECT($initialBox)
	
$initialBox:=svg_getHTMLTextBox($valObj.x; $valObj.y+(0.8*$lineHeight); $valObj.textWidth; $lineHeight)
//svg_displayBox ($initialBox;$svgRef;"red")
	
C_OBJECT($rotatedBox)
	
$rotatedBox:=svg_getRotatedBox($initialBox; $valObj.x; $valObj.y; $valObj.textOrientation*Degree)
	
If ($valObj.textOrientation>0)
Case of 
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
$translationX:=(($valObj.x+1.75))-$rotatedBox.topLeft.x
	
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
$translationX:=($valObj.x+($valObj.width/2))-(($rotatedBox.bottomRight.x+$rotatedBox.topLeft.x)/2)
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
$translationX:=($valObj.x+$valObj.width-1.75)-$rotatedBox.bottomRight.x
	
End case 
	
Case of 
: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
$translationY:=($valObj.y+1.75)-$rotatedBox.topRight.y
	
: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
$translationY:=($valObj.y+($valObj.height/2))-(($rotatedBox.bottomLeft.y+$rotatedBox.topRight.y)/2)
	
: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
$translationY:=($valObj.y+$valObj.height-1.75)-$rotatedBox.bottomLeft.y
	
End case 
	
C_OBJECT($translatedBox)
	
$translatedBox:=svg_getTranslatedBox($rotatedBox; $translationX; $translationY)
//svg_displayBox ($translatedBox;$svgRef;"purple")
	
If ($translatedBox.bottomLeft.y>($valObj.y+$valObj.height-1.75))
$translationY:=$translationY+($valObj.y+$valObj.height-1.75)-$translatedBox.bottomLeft.y
$translatedBox:=svg_getTranslatedBox($translatedBox; 0; ($valObj.y+$valObj.height)-$translatedBox.bottomLeft.y)
//svg_displayBox ($translatedBox;$svgRef;"cyan")
End if 
	
//svg_displayBox($translatedBox;$svgRef;"red")
	
//svg_displayBox ($clipBox;$svgRef;"green")
Else 
	
Case of 
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
$translationX:=($valObj.x+1.75)-$rotatedBox.bottomLeft.x
	
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
$translationX:=($valObj.x+($valObj.width/2))-(($rotatedBox.topRight.x+$rotatedBox.bottomLeft.x)/2)
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
$translationX:=($valObj.x+$valObj.width-1.75)-$rotatedBox.topRight.x
	
End case 
	
Case of 
: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
$translationY:=($valObj.y+1.75)-$rotatedBox.topLeft.y
	
: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
$translationY:=($valObj.y+($valObj.height/2))-(($rotatedBox.bottomRight.y+$rotatedBox.topLeft.y)/2)
	
: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
$translationY:=($valObj.y+$valObj.height-1.75)-$rotatedBox.bottomRight.y
	
End case 
	
C_OBJECT($translatedBox)
	
$translatedBox:=svg_getTranslatedBox($rotatedBox; $translationX; $translationY)
//svg_displayBox ($translatedBox;$svgRef;"purple")
	
If ($translatedBox.bottomRight.y>($valObj.y+$valObj.height-1.75))
$translationY:=$translationY+($valObj.y+$valObj.height-1.75)-$translatedBox.bottomRight.y
$translatedBox:=svg_getTranslatedBox($translatedBox; 0; ($valObj.y+$valObj.height)-$translatedBox.bottomRight.y)
//  svg_displayBox ($translatedBox;$svgRef;"cyan")
End if 
End if 
	
/// OFFSET WHEN ROTATED BORDER ////
C_REAL($translationX2)
	
$translationX2:=0
If ($valObj.borderOrientation) & ($valObj.textOrientation#90) & ($valObj.textOrientation#-90)
C_OBJECT($P)
	
Case of 
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.textOrientation>0)
$P:=svg_findIntersection($translatedBox.topLeft.x; $translatedBox.topLeft.y; $valObj.x; $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset; $valObj.y)
	
$translationX2:=$P.x-$translatedBox.topLeft.x
	
$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
	
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.textOrientation<0)
$P:=svg_findIntersection($translatedBox.bottomLeft.x; $translatedBox.bottomLeft.y; $valObj.x; $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset; $valObj.y)
	
$translationX2:=$P.x-$translatedBox.bottomLeft.x
	
$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
	
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
$P:=svg_findIntersection(($translatedBox.topLeft.x+$translatedBox.bottomRight.x)/2; ($translatedBox.topLeft.y+$translatedBox.bottomRight.y)/2; $valObj.x+($valObj.width/2); $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset+($valObj.width/2); $valObj.y)
	
$translationX2:=$P.x-(($translatedBox.topLeft.x+$translatedBox.bottomRight.x)/2)
	
$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
	
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.textOrientation>0)
$P:=svg_findIntersection($translatedBox.bottomRight.x; $translatedBox.bottomRight.y; $valObj.x+$valObj.width; $valObj.y+$valObj.height; $valObj.x+$valObj.width+$valObj.borderOffset; $valObj.y)
	
$translationX2:=$P.x-$translatedBox.bottomRight.x
	
$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.textOrientation<0)
$P:=svg_findIntersection($translatedBox.topLeft.x; $translatedBox.topLeft.y; $valObj.x+$valObj.width; $valObj.y+$valObj.height; $valObj.x+$valObj.width+$valObj.borderOffset; $valObj.y)
	
$translationX2:=$P.x-$translatedBox.topLeft.x
	
$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
	
End case 
End if 
	
//svg_displayBox($translatedBox;$svgRef;"blue")
	
If ($valObj.isMerged=FREE)
$styleStr:=$styleStr+"top:"+String($translationY; "&xml;")+"px;left:"+String($translationX+$translationX2+($valObj.x-$valObj.leftOverflow); "&xml;")+"px;"
Else 
$styleStr:=$styleStr+"top:"+String($translationY; "&xml;")+"px;left:"+String($translationX+$translationX2; "&xml;")+"px;"
End if 
	
Else 
	
Case of 
: ($htmlVAlign="top")
C_TEXT($top)
	
$top:="0"
	
If ($valObj.cellPadding#Null) & ($valObj.textWidth>$valObj.width) & ($valObj.wordWrap=False)
$top:=$valObj.cellPadding.top
End if 
	
If ($valObj.shrinkToFit#"")
If (Num($valObj.shrinkToFit; ".")<Num($fontSize; ".")) & ($valObj.wordWrap=False)
$top:=String(Num($top; ".")+Num($fontSize; ".")-Num($valObj.shrinkToFit; "."); "&xml;")
	
End if 
End if 
	
$styleStr:=$styleStr+"top:"+$top+"px;"
	
: ($htmlVAlign="middle")
If ($valObj.height>0) | ($valObj.cellPadding=Null)
$styleStr:=$styleStr+"top:50%;transform:translateY(-50%);"
	
Else 
$styleStr:=$styleStr+"top:"+String(Num($valObj.cellPadding.top)-($lineHeight/2); "&xml;")+"px;"
	
End if 
	
: ($htmlVAlign="bottom")
C_TEXT($bottom)
	
$bottom:="-4"
	
If ($valObj.cellPadding#Null)
$bottom:=$valObj.cellPadding.bottom
If ((Num($bottom; ".")+$lineHeight+2)>($valObj.height+Num($valObj.cellPadding.bottom)+Num($valObj.cellPadding.top)))
$styleStr:=$styleStr+"top:-3px;"
	
Else 
$styleStr:=$styleStr+"bottom:"+$bottom+"px;"
	
End if 
Else 
$styleStr:=$styleStr+"bottom:"+$bottom+"px;"
End if 
	
End case 
	
If ($valObj.wordWrap=False)
Case of 
: ($valObj.strPart#Null)
//Do Nothing
	
: ($htmlHAlign="left") & (($valObj.cellBorderRight#$valObj.rightOverflow) | ($valObj.cellPadding=Null)) & ($valObj.isMerged=FREE)
$styleStr:=$styleStr+"left:"+String($valObj.x-$valObj.leftOverflow; "&xml;")+"px;"
	
: ($htmlHAlign="right") & (($valObj.cellBorderLeft#$valObj.leftOverflow) | ($valObj.cellPadding=Null)) & ($valObj.isMerged=FREE)
$styleStr:=$styleStr+"right:"+String($valObj.rightOverflow-($valObj.x+$valObj.width); "&xml;")+"px;"
	
: ($htmlHAlign="center") & ((($valObj.cellBorderRight#$valObj.rightOverflow) | ($valObj.cellBorderLeft#$valObj.leftOverflow)) | ($valObj.cellPadding=Null))
$styleStr:=$styleStr+"left:"+String(($valObj.width/2)-(($valObj.textWidth)/2)-4; "&xml;")+"px;"
	
: ($htmlHAlign="left") & (($valObj.cellBorderRight=$valObj.rightOverflow) | ($valObj.isMerged#FREE))
$styleStr:=$styleStr+"left:0px;"
	
: ($htmlHAlign="right") & (($valObj.cellBorderLeft=$valObj.leftOverflow) | ($valObj.isMerged#FREE))
$styleStr:=$styleStr+"right:0px;"
	
: ($htmlHAlign="center")
$styleStr:=$styleStr+"left:"+String(($valObj.width/2)-(($valObj.textWidth)/2)-Num($valObj.cellPadding.left)-4; "&xml;")+"px;"
	
End case 
End if 
End if 
	
If ($valObj.strPart=Null)
$styleStr:=$styleStr+"text-align:"+$htmlHAlign+";"
End if 
	
$styleStr:=$styleStr+"overflow:hidden;"
	
Case of 
: ($valObj.wordWrap=True)
DOM SET XML ATTRIBUTE($elemRef; "wrap"; "hard")
	
: ($valObj.wordWrap=False)
DOM SET XML ATTRIBUTE($elemRef; "wrap"; "off")
	
End case 
	
DOM SET XML ATTRIBUTE($elemRef; "readonly"; "true")
	
End if 
	
Case of 
: ($valObj.isVerticalText)
$elemRef:=DOM Create XML element($bodyRef; "div"; "style"; $styleStr)
svg_printVerticalText($elemRef; $valueStr; Choose($valObj.shrinkToFit#""; $valObj.shrinkToFit; $fontSize); $valObj; True)
	
: ($valObj.strPart#Null)
C_TEXT($part1Ref; $elemStyle; $part1Style)
	
$part1Ref:=DOM Create XML element(DOM Get parent XML element($elemRef); "textarea")
dom_xml_copy_element($elemRef; $part1Ref)
	
$part1Style:=$styleStr
$elemStyle:=$styleStr
	
$part1Style:=$part1Style+"left:0px;"
$elemStyle:=$elemStyle+"right:0px;"
	
$elemStyle:=$elemStyle+"text-align:right"
$part1Style:=$part1Style+"text-align:left"
	
DOM SET XML ATTRIBUTE($elemRef; "style"; $elemStyle)
DOM SET XML ATTRIBUTE($part1Ref; "style"; $part1Style)
DOM SET XML ELEMENT VALUE($elemRef; $valObj.strPart.part2)
DOM SET XML ELEMENT VALUE($part1Ref; $valObj.strPart.part1)
	
Else 
If (Not($valObj.wordWrap))
$valueStr:=Replace string($valueStr; "\n"; " ")
End if 
	
DOM SET XML ATTRIBUTE($elemRef; "style"; $styleStr)
DOM SET XML ELEMENT VALUE($elemRef; $valueStr)
	
End case 
End if 
	
If ($valObj.textIndent#"")
Case of 
: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False)
If ($valObj.wordWrap=True)
$valObj.x:=$valObj.x-(Num($valObj.textIndent)*8)
$valObj.width:=$valObj.width+(Num($valObj.textIndent)*16)
	
End if 
	
: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False)
$valObj.x:=$valObj.x-(Num($valObj.textIndent)*8)
$valObj.width:=$valObj.width+(Num($valObj.textIndent)*8)
	
: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False)
$valObj.width:=$valObj.width+(Num($valObj.textIndent)*8)
	
: ($valObj.vAlign=TOP_VERTICAL_ALIGN) & ($valObj.isVerticalText=True)
$valObj.y:=$valObj.y-(Num($valObj.textIndent)*8)
$valObj.height:=$valObj.height+(Num($valObj.textIndent)*8)
	
: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN) & ($valObj.isVerticalText=True)
$valObj.height:=$valObj.height+(Num($valObj.textIndent)*8)
	
End case 
End if 
	
If ($valObj.cellPadding#Null)
$valObj.x:=$valObj.x-Num($valObj.cellPadding.left)
$valObj.y:=$valObj.y-Num($valObj.cellPadding.top)
$valObj.width:=$valObj.width+Num($valObj.cellPadding.left)+Num($valObj.cellPadding.right)
$valObj.height:=$valObj.height+Num($valObj.cellPadding.top)+Num($valObj.cellPadding.bottom)
	
End if 
	
End for each 
*/
	
	//$gRef:=DOM Create XML element($switchRef; "g"; "xmlns"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink"; "height"; $svgHeight; "width"; $svgWidth; "x"; 0; "y"; 0)
	$gRef:=DOM Create XML element:C865($svgRef; "g"; "xmlns"; "http://www.w3.org/2000/svg"; "xmlns:xlink"; "http://www.w3.org/1999/xlink"; "height"; $svgHeight; "width"; $svgWidth; "x"; 0; "y"; 0)
	
	$elemRef:=DOM Create XML element:C865($gRef; "style")
	DOM SET XML ELEMENT VALUE:C868($elemRef; "textArea{font-size:"+$fontSize+";font-family:'"+themeFont+"';}text{font-size:"+$fontSize+";font-family:'"+themeFont+"';}")
	
	For each ($valObj; $valCol)
		
		$fontSize:="14.6664px"
		$lineHeight:=DEFAULT_LINE_HEIGHT
		
		$valueStr:=String:C10($valObj.value)
		
		If ($valObj.textIndent#"")
			Case of 
				: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False:C215)
					If ($valObj.wordWrap=True:C214)
						$valObj.x:=$valObj.x+(Num:C11($valObj.textIndent)*8)
						$valObj.width:=$valObj.width-(Num:C11($valObj.textIndent)*16)
						
					End if 
					
				: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False:C215)
					$valObj.x:=$valObj.x+(Num:C11($valObj.textIndent)*8)
					$valObj.width:=$valObj.width-(Num:C11($valObj.textIndent)*8)
					
				: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False:C215)
					$valObj.width:=$valObj.width-(Num:C11($valObj.textIndent)*8)
					
				: ($valObj.vAlign=TOP_VERTICAL_ALIGN) & ($valObj.isVerticalText=True:C214)
					$valObj.y:=$valObj.y+(Num:C11($valObj.textIndent)*8)
					$valObj.height:=$valObj.height-(Num:C11($valObj.textIndent)*8)
					
					
				: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN) & ($valObj.isVerticalText=True:C214)
					$valObj.height:=$valObj.height-(Num:C11($valObj.textIndent)*8)
					
			End case 
		End if 
		
		If ($valObj.cellPadding#Null:C1517)
			$valObj.x:=$valObj.x+Num:C11($valObj.cellPadding.left)
			$valObj.y:=$valObj.y+Num:C11($valObj.cellPadding.top)
			$valObj.width:=$valObj.width-Num:C11($valObj.cellPadding.left)-Num:C11($valObj.cellPadding.right)
			$valObj.height:=$valObj.height-Num:C11($valObj.cellPadding.top)-Num:C11($valObj.cellPadding.bottom)
			
		End if 
		
		//// CLIPPING ////
		
		C_TEXT:C284($clipRef)
		
		$clipRef:=DOM Create XML element:C865($gRef; "clipPath"; "id"; String:C10($valObj.x)+"a"+String:C10($valObj.y))
		
		If ($valObj.textOrientation=0) | ($valObj.textOrientation=NONE_TEXT_ORIENTATION)
			
			If ($valObj.textWidth>$valObj.width) & ($valObj.cellPadding#Null:C1517) & (Not:C34($valObj.isVerticalText)) & (Not:C34($valObj.wordWrap))
				$elemRef:=DOM Create XML element:C865($clipRef; "rect"; "y"; $valObj.y-Num:C11($valObj.cellPadding.top); "height"; $valObj.height+Num:C11($valObj.cellPadding.top)+Num:C11($valObj.cellPadding.bottom))
				
			Else 
				$elemRef:=DOM Create XML element:C865($clipRef; "rect"; "y"; $valObj.y; "height"; $valObj.height)
				
			End if 
			
			If (($valObj.wordWrap) & ($valObj.strPart=Null:C1517)) | ($valObj.isMerged#FREE)
				DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.x; "width"; $valObj.width)
				
			Else 
				Case of 
					: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.rightOverflow=$valObj.cellBorderRight) & ($valObj.cellPadding#Null:C1517)
						DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.x; "width"; $valObj.width)
						
					: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.leftOverflow=$valObj.cellBorderLeft) & ($valObj.rightOverflow=$valObj.cellBorderRight) & ($valObj.cellPadding#Null:C1517)
						DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.x; "width"; $valObj.width)
						
					: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.leftOverflow=$valObj.cellBorderLeft) & ($valObj.cellPadding#Null:C1517)
						DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.x; "width"; $valObj.rightOverflow-$valObj.x)
						
					Else 
						DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.leftOverflow; "width"; $valObj.rightOverflow-$valObj.leftOverflow)
						
				End case 
			End if 
			
		End if 
		
		//// ELEM TYPE ////
		
		Case of 
				//: ($valObj.wordWrap=True) & ($valObj.isVerticalText=False) & ($valObj.strPart=Null) & (($valObj.textOrientation=NONE_TEXT_ORIENTATION) | ($valObj.textOrientation=0))
				//$elemRef:=DOM Create XML element($gRef; "textArea")
			: ($valObj.isVerticalText=False:C215) & (($valObj.strPart#Null:C1517) | ($valObj.wordWrapInfo#Null:C1517))
				$elemRef:=DOM Create XML element:C865($gRef; "g"; "clip-path"; "url(#"+String:C10($valObj.x)+"a"+String:C10($valObj.y)+")")
			Else 
				$elemRef:=DOM Create XML element:C865($gRef; "text"; "clip-path"; "url(#"+String:C10($valObj.x)+"a"+String:C10($valObj.y)+")")
				
		End case 
		
		$styleStr:=""
		
		//// FONT ////
		
		If ($valObj.fontObj#Null:C1517)
			If ($valObj.fontObj.family#Null:C1517)
				$styleStr:=$styleStr+"font-family:'"+$valObj.fontObj.family+"';"
				
			End if 
			
			If ($valObj.fontObj.size#Null:C1517)
				$fontSize:=$valObj.fontObj.size
				
				If ($valObj.shrinkToFit#"") & (Num:C11($valObj.shrinkToFit; ".")<Num:C11($fontSize; "."))
					$styleStr:=$styleStr+"font-size:"+$valObj.shrinkToFit+";"
					
				Else 
					$styleStr:=$styleStr+"font-size:"+$fontSize+";"
					
				End if 
			End if 
			
			If ($valObj.fontObj.weight#Null:C1517)
				$styleStr:=$styleStr+"font-weight:"+$valObj.fontObj.weight+";"
				
			End if 
			
			If ($valObj.fontObj.style#Null:C1517)
				$styleStr:=$styleStr+"font-style:"+$valObj.fontObj.style+";"
				
			End if 
			
			If ($valObj.fontObj.variant#Null:C1517)
				$styleStr:=$styleStr+"font-variant:"+$valObj.fontObj.variant+";"
				
			End if 
			
			$lineHeight:=$valObj.fontObj.lineHeight
		Else 
			
			If ($valObj.shrinkToFit#"") & (Num:C11($valObj.shrinkToFit; ".")<Num:C11($fontSize; "."))
				$styleStr:=$styleStr+"font-size:"+$valObj.shrinkToFit+";"
				
			Else 
				$styleStr:=$styleStr+"font-size:"+$fontSize+";"
				
			End if 
		End if 
		
		//// TEXT DECORATION ////
		
		If (($valObj.textDecoration#"") && ($valObj.textDecoration#"$4D_tdnull"))
			
			// Double underline not implemented so it is replaced by a simple underline
			$valObj.textDecoration:=Replace string:C233($valObj.textDecoration; "double"; "")
			
			If ($valObj.isVerticalText)
				If (Position:C15("line-through"; $valObj.textDecoration)>0)
					DOM SET XML ATTRIBUTE:C866($elemRef; "text-decoration"; "line-through")
					
				End if 
			Else 
				DOM SET XML ATTRIBUTE:C866($elemRef; "text-decoration"; $valObj.textDecoration)
				
			End if 
		End if 
		
		//// FORE COLOR ////
		
		If (($valObj.foreColor#"") && ($valObj.foreColor#"$4D_NOCOLOR"))
			
			DOM SET XML ATTRIBUTE:C866($elemRef; "fill"; $valObj.foreColor)
			
		End if 
		
		//// POSITION ////
		
		If ($valObj.wordWrapInfo=Null:C1517) & (($valObj.textOrientation=0) | ($valObj.textOrientation=NONE_TEXT_ORIENTATION))
			Case of 
				: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) | ($valObj.strPart#Null:C1517)
					DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.x+2)
					
				: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
					DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.x+($valObj.width/2); "text-anchor"; "middle")
					
				: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
					DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $valObj.x+$valObj.width-2; "text-anchor"; "end")
					
			End case 
			
			Case of 
				: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
					DOM SET XML ATTRIBUTE:C866($elemRef; "y"; $valObj.y+(0.5*$lineHeight)+3+(0.3*Num:C11($fontSize; ".")))
					
				: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
					DOM SET XML ATTRIBUTE:C866($elemRef; "y"; $valObj.y+(Choose:C955($valObj.height>0; $valObj.height; 0)/2)+((0.66*Num:C11($fontSize; "."))/2))
					
				: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
					DOM SET XML ATTRIBUTE:C866($elemRef; "y"; $valObj.y+Choose:C955($valObj.height>0; $valObj.height; 0)+(0.3*Num:C11($fontSize; "."))-(0.5*$lineHeight))
					
			End case 
		End if 
		
		//// STYLE ////
		DOM SET XML ATTRIBUTE:C866($elemRef; "style"; $styleStr)
		
		
		//// ROTATION AND WORDWRAP ////
		If ($valObj.wordWrapInfo#Null:C1517) & ($valObj.isVerticalText=False:C215)
			
			If ($valObj.textOrientation=0) | ($valObj.textOrientation=NONE_TEXT_ORIENTATION)
				C_LONGINT:C283($anchorX; $anchorY)
				C_TEXT:C284($textRef)
				
				$lineHeight:=$valObj.wordWrapInfo.lineHeight
				
				Case of 
					: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
						$anchorX:=$valObj.x+1.5
						
					: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
						$anchorX:=$valObj.x+$valObj.width-1.5
						
					Else 
						$anchorX:=$valObj.x+($valObj.width/2)
						
				End case 
				
				Case of 
					: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
						$anchorY:=$valObj.y+1.5+(0.8*$lineHeight)
						$i:=0
						
					: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
						$anchorY:=$valObj.y+$valObj.height-1.5-(0.2*$lineHeight)
						$i:=$valObj.wordWrapInfo.lines.length-1
						
					Else 
						$anchorY:=$valObj.y+($valObj.height/2)-($lineHeight*$valObj.wordWrapInfo.lines.length/2)+(0.8*$lineHeight)
						$i:=0
						
				End case 
				
				C_REAL:C285($lastX; $posX; $posY)
				C_OBJECT:C1216($line)
				
				$lastX:=-1
				While ($i>=0) & ($i<$valObj.wordWrapInfo.lines.length)
					
					$line:=$valObj.wordWrapInfo.lines[$i]
					
					Case of 
						: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
							$posX:=$anchorX
							
						: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
							$posX:=$anchorX-$line.width
							
						Else 
							$posX:=$anchorX-($line.width/2)
							
					End case 
					
					$posY:=$anchorY
					
					$textRef:=DOM Create XML element:C865($elemRef; "text"; "x"; $posX; "y"; $posY; "style"; $styleStr)
					DOM SET XML ELEMENT VALUE:C868($textRef; $line.text)
					
					If ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
						$i:=$i-1
						$anchorY:=$anchorY-$lineHeight
						
					Else 
						$i:=$i+1
						$anchorY:=$anchorY+$lineHeight
						
					End if 
					
				End while 
				
			Else 
				C_LONGINT:C283($step)
				C_REAL:C285($offset; $stickX; $stickY; $lastX)
				C_TEXT:C284($HStickCorner; $VStickCorner)
				C_OBJECT:C1216($rotatedTextBox; $translatedTextBox; $initialTextBox; $rotatedBigBox; $translatedBigBox; $initialBigBox; $line)
				
				$lineHeight:=$valObj.wordWrapInfo.lineHeight
				$boxWidth:=$valObj.wordWrapInfo.boxWidth
				$radOrientation:=$valObj.textOrientation*Degree:K30:2
				$offset:=$lineHeight/Cos:C18((90-$valObj.textOrientation)*Degree:K30:2)
				
				Case of 
					: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
						$stickX:=$valObj.x+1.757
						
						If ($valObj.textOrientation>=0)
							$HStickCorner:="topLeft"
							$i:=0
							$step:=1
							
						Else 
							$HStickCorner:="bottomLeft"
							$i:=$valObj.wordWrapInfo.lines.length-1
							$step:=-1
							
						End if 
						
					: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
						$stickX:=$valObj.x+($valObj.width/2)-((Abs:C99(Cos:C18($radOrientation)*$boxWidth)+(($valObj.wordWrapInfo.lines.length-1)*$offset)+Abs:C99(Sin:C17($radOrientation)*$lineHeight))/2)
						$i:=0
						$step:=1
						
						If ($valObj.textOrientation>0)
							$HStickCorner:="topLeft"
							
						Else 
							$HStickCorner:="bottomLeft"
							
						End if 
						
					: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
						$stickX:=$valObj.x+$valObj.width-1.75
						
						If ($valObj.textOrientation>0)
							$HStickCorner:="bottomRight"
							$i:=$valObj.wordWrapInfo.lines.length-1
							$step:=-1
							
						Else 
							$HStickCorner:="topRight"
							$i:=0
							$step:=1
							
						End if 
						
				End case 
				
				Case of 
					: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
						$stickY:=$valObj.y+1.75
						
						If ($valObj.textOrientation>0)
							$VStickCorner:="topRight"
							
						Else 
							$VStickCorner:="topLeft"
							
						End if 
						
					: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
						$stickY:=$valObj.y+($valObj.height/2)-((Abs:C99(Sin:C17($radOrientation)*$boxWidth)+Abs:C99(Cos:C18($radOrientation)*$lineHeight))/2)
						
						If ($valObj.textOrientation>0)
							$VStickCorner:="topRight"
							
						Else 
							$VStickCorner:="topLeft"
							
						End if 
						
					: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
						$stickY:=$valObj.y+$valObj.height-4
						
						If ($valObj.textOrientation>0)
							$VStickCorner:="bottomLeft"
							
						Else 
							$VStickCorner:="bottomRight"
							
						End if 
						
				End case 
				
				$lastX:=-1
				While ($i>=0) & ($i<$valObj.wordWrapInfo.lines.length)
					
					$line:=$valObj.wordWrapInfo.lines[$i]
					
					$initialBigBox:=svg_getTextBox(0; 0; $boxWidth; $lineHeight)
					$initialTextBox:=svg_getWrappedLineBoxFromBigBox($initialBigBox; $line)
					
					$rotatedBigBox:=svg_getRotatedBox($initialBigBox; $initialBigBox.topLeft.x; $initialBigBox.topLeft.y; $radOrientation)
					$rotatedTextBox:=svg_getRotatedBox($initialTextBox; $initialBigBox.topLeft.x; $initialBigBox.topLeft.y; $radOrientation)
					
					If ($lastX=-1)
						$translationX:=$stickX-$rotatedBigBox[$HStickCorner].x
						
					Else 
						$translationX:=$lastX-$rotatedBigBox[$VStickCorner].x+($offset*$step)
						
					End if 
					
					$translationY:=$stickY-$rotatedBigBox[$VStickCorner].y
					
					$translatedBigBox:=svg_getTranslatedBox($rotatedBigBox; $translationX; $translationY)
					$translatedTextBox:=svg_getTranslatedBox($rotatedTextBox; $translationX; $translationY)
					
					If ($lastX=-1) & ($valObj.borderOrientation) & ($valObj.textOrientation#90) & ($valObj.textOrientation#-90)
						C_OBJECT:C1216($P)
						Case of 
							: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
								$P:=svg_findIntersection($translatedBigBox[$HStickCorner].x; $translatedBigBox[$HStickCorner].y; $valObj.x; $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset; $valObj.y)
								
								$translationX:=$P.x-$translatedBigBox[$HStickCorner].x
								
								$translatedBigBox:=svg_getTranslatedBox($translatedBigBox; $translationX; 0)
								$translatedTextBox:=svg_getTranslatedBox($translatedTextBox; $translationX; 0)
								
							: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
								$P:=svg_findIntersection($translatedBigBox[$HStickCorner].x; ($translatedBigBox.topLeft.y+$translatedBigBox.bottomRight.y)/2; $valObj.x+($valObj.width/2); $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset+($valObj.width/2); $valObj.y)
								
								$translationX:=$P.x-$translatedBigBox[$HStickCorner].x-((Abs:C99(Cos:C18($radOrientation)*$boxWidth)+(($valObj.wordWrapInfo.lines.length-1)*$offset)+Abs:C99(Sin:C17($radOrientation)*$lineHeight))/2)
								
								$translatedBigBox:=svg_getTranslatedBox($translatedBigBox; $translationX; 0)
								$translatedTextBox:=svg_getTranslatedBox($translatedTextBox; $translationX; 0)
								
								
							: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
								$P:=svg_findIntersection($translatedBigBox[$HStickCorner].x; $translatedBigBox[$HStickCorner].y; $valObj.x+$valObj.width; $valObj.y+$valObj.height; $valObj.x+$valObj.width+$valObj.borderOffset; $valObj.y)
								
								$translationX:=$P.x-$translatedBigBox[$HStickCorner].x
								
								$translatedBigBox:=svg_getTranslatedBox($translatedBigBox; $translationX; 0)
								$translatedTextBox:=svg_getTranslatedBox($translatedTextBox; $translationX; 0)
								
						End case 
					End if 
					
					$lastX:=$translatedBigBox[$VStickCorner].x
					
					//svg_displayBox ($translatedBigBox;$svgRef;"red")
					
					//svg_displayBox ($translatedTextBox;$svgRef;"green")
					
					$xPos:=$translatedTextBox.topLeft.x
					$yPos:=(0.8*$lineHeight)+$translatedTextBox.topLeft.y
					
					$elemRef:=DOM Create XML element:C865($gRef; "text"; "x"; $xPos; "y"; $yPos; "transform"; "rotate("+String:C10(-$valObj.textOrientation)+", "+String:C10($translatedTextBox.topLeft.x; "&xml;")+", "+String:C10($translatedTextBox.topLeft.y; "&xml;")+")"; "style"; $styleStr)
					DOM SET XML ELEMENT VALUE:C868($elemRef; $line.text)
					
					$i:=$i+$step
					
				End while 
				
			End if 
			
		Else 
			If ($valObj.textOrientation#0) & ($valObj.textOrientation#NONE_TEXT_ORIENTATION) & (Not:C34($valObj.isVerticalText))
				
				C_REAL:C285($radOrientation)
				
				$radOrientation:=$valObj.textOrientation*Degree:K30:2
				
				C_REAL:C285($xPos; $yPos)
				
				//DOM GET XML ATTRIBUTE BY NAME($elemRef;"y";$yPos)
				//DOM GET XML ATTRIBUTE BY NAME($elemRef;"x";$xPos)
				
				$xPos:=0
				$yPos:=0
				
				C_OBJECT:C1216($initialBox)
				
				C_REAL:C285($boxWidth)
				
				$boxWidth:=$valObj.textWidth
				
				If ($valObj.shrinkToFit#"")
					$lineHeight:=1.2*(Num:C11($valObj.shrinkToFit; "."))
				End if 
				
				$initialBox:=svg_getTextBox($xPos; $yPos; $boxWidth; $lineHeight)
				//svg_displayBox ($initialBox;$svgRef;"red")
				
				C_OBJECT:C1216($rotatedBox)
				
				$rotatedBox:=svg_getRotatedBox($initialBox; $initialBox.topLeft.x; $initialBox.topLeft.y; $radOrientation)
				//svg_displayBox ($rotatedBox;$svgRef;"green")
				
				C_REAL:C285($translationX; $translationY)
				
				If ($valObj.textOrientation>0)
					
					/// HORIZONTAL CELL POSITION
					Case of 
						: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
							$translationX:=(($valObj.x+1.75))
							
						: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
							$translationX:=($valObj.x+($valObj.width/2))-(($rotatedBox.bottomRight.x+$rotatedBox.topLeft.x)/2)
							
						: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
							$translationX:=($valObj.x+$valObj.width-1.75)-$rotatedBox.bottomRight.x
							
					End case 
					
					
					/// VERTICAL CELL POSITION
					Case of 
						: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
							$translationY:=($valObj.y+1.75)-$rotatedBox.topRight.y
							
						: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
							$translationY:=$valObj.y+($valObj.height/2)+(($rotatedBox.topLeft.y-$rotatedBox.bottomRight.y)/2)  //+(0.8*$lineHeight)
							
						: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
							$translationY:=($valObj.y+$valObj.height-1.75)-$rotatedBox.bottomLeft.y
							
					End case 
					
					C_OBJECT:C1216($translatedBox)
					
					$translatedBox:=svg_getTranslatedBox($rotatedBox; $translationX; $translationY)
					
					
					/// OFFSET WHEN TEXT BOX IS TO HEIGH
					If ($translatedBox.bottomLeft.y>($valObj.y+$valObj.height-1.75))
						$translationY:=$translationY+($valObj.y+$valObj.height-1.75)-$translatedBox.bottomLeft.y
						$translatedBox:=svg_getTranslatedBox($translatedBox; 0; ($valObj.y+$valObj.height)-$translatedBox.bottomLeft.y)
						
					End if 
					
				Else 
					
					/// HORIZONTAL CELL POSITION
					Case of 
						: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN)
							$translationX:=($valObj.x+1.75)-$rotatedBox.bottomLeft.x
							
						: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
							$translationX:=($valObj.x+($valObj.width/2))-(($rotatedBox.topRight.x+$rotatedBox.bottomLeft.x)/2)
							
						: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN)
							$translationX:=($valObj.x+$valObj.width-1.75)-$rotatedBox.topRight.x
							
					End case 
					
					/// VERTICAL CELL POSITION
					Case of 
						: ($valObj.vAlign=TOP_VERTICAL_ALIGN)
							$translationY:=($valObj.y+1.75)-$rotatedBox.topLeft.y
							
						: ($valObj.vAlign=CENTER_VERTICAL_ALIGN)
							$translationY:=($valObj.y+($valObj.height/2))-(($rotatedBox.bottomRight.y+$rotatedBox.topLeft.y)/2)
							
						: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN)
							$translationY:=($valObj.y+$valObj.height-1.75)-$rotatedBox.bottomRight.y
							
					End case 
					
					C_OBJECT:C1216($translatedBox)
					
					$translatedBox:=svg_getTranslatedBox($rotatedBox; $translationX; $translationY)
					
					/// OFFSET WHEN TEXT BOX IS TO HEIGH
					If ($translatedBox.bottomRight.y>($valObj.y+$valObj.height-1.75))
						$translationY:=$translationY+($valObj.y+$valObj.height-1.75)-$translatedBox.bottomRight.y
						$translatedBox:=svg_getTranslatedBox($translatedBox; 0; ($valObj.y+$valObj.height)-$translatedBox.bottomRight.y)
					End if 
					
				End if 
				
				/// OFFSET WHEN ROTATED BORDER ////
				If ($valObj.borderOrientation) & ($valObj.textOrientation#90) & ($valObj.textOrientation#-90)
					C_OBJECT:C1216($P)
					Case of 
						: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.textOrientation>0)
							$P:=svg_findIntersection($translatedBox.topLeft.x; $translatedBox.topLeft.y; $valObj.x; $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset; $valObj.y)
							
							$translationX:=$P.x-$translatedBox.topLeft.x
							
							$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
							
						: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.textOrientation<0)
							$P:=svg_findIntersection($translatedBox.bottomLeft.x; $translatedBox.bottomLeft.y; $valObj.x; $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset; $valObj.y)
							
							$translationX:=$P.x-$translatedBox.bottomLeft.x
							
							$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
							
						: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN)
							$P:=svg_findIntersection(($translatedBox.topLeft.x+$translatedBox.bottomRight.x)/2; ($translatedBox.topLeft.y+$translatedBox.bottomRight.y)/2; $valObj.x+($valObj.width/2); $valObj.y+$valObj.height; $valObj.x+$valObj.borderOffset+($valObj.width/2); $valObj.y)
							
							$translationX:=$P.x-(($translatedBox.topLeft.x+$translatedBox.bottomRight.x)/2)
							
							$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
							
							
						: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.textOrientation>0)
							$P:=svg_findIntersection($translatedBox.bottomRight.x; $translatedBox.bottomRight.y; $valObj.x+$valObj.width; $valObj.y+$valObj.height; $valObj.x+$valObj.width+$valObj.borderOffset; $valObj.y)
							
							$translationX:=$P.x-$translatedBox.bottomRight.x
							
							$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
							
						: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.textOrientation<0)
							$P:=svg_findIntersection($translatedBox.topLeft.x; $translatedBox.topLeft.y; $valObj.x+$valObj.width; $valObj.y+$valObj.height; $valObj.x+$valObj.width+$valObj.borderOffset; $valObj.y)
							
							$translationX:=$P.x-$translatedBox.topLeft.x
							
							$translatedBox:=svg_getTranslatedBox($translatedBox; $translationX; 0)
							
					End case 
				End if 
				
				//  svg_displayBox ($translatedBox;$svgRef;"green")
				
				C_OBJECT:C1216($clipBox)
				
				$clipBox:=New object:C1471
				
				If ($valObj.isMerged=FREE)
					$clipBox.topLeft:=New object:C1471
					$clipBox.topLeft.y:=$valObj.y
					$clipBox.topLeft.x:=0
					
					$clipBox.bottomLeft:=New object:C1471
					$clipBox.bottomLeft.y:=$valObj.y+$valObj.height
					$clipBox.bottomLeft.x:=0
					
					$clipBox.topRight:=New object:C1471
					$clipBox.topRight.x:=$svgWidth
					$clipBox.topRight.y:=$valObj.y
					
					$clipBox.bottomRight:=New object:C1471
					$clipBox.bottomRight.y:=$valObj.y+$valObj.height
					$clipBox.bottomRight.x:=$svgWidth
				Else 
					$clipBox.topLeft:=New object:C1471
					$clipBox.topLeft.y:=$valObj.y
					$clipBox.topLeft.x:=$valObj.x
					
					$clipBox.bottomLeft:=New object:C1471
					$clipBox.bottomLeft.y:=$valObj.y+$valObj.height
					$clipBox.bottomLeft.x:=$valObj.x
					
					$clipBox.topRight:=New object:C1471
					$clipBox.topRight.x:=$valObj.x+$valObj.width
					$clipBox.topRight.y:=$valObj.y
					
					$clipBox.bottomRight:=New object:C1471
					$clipBox.bottomRight.y:=$valObj.y+$valObj.height
					$clipBox.bottomRight.x:=$valObj.x+$valObj.width
				End if 
				
				$clipBox:=svg_getRotatedBox($clipBox; $translatedBox.topLeft.x; $translatedBox.topLeft.y; -$radOrientation)
				
				C_TEXT:C284($polygonRef)
				
				$polygonRef:=DOM Create XML element:C865($clipRef; "polygon"; "points"; String:C10($clipBox.topLeft.x; "&xml;")+" "+String:C10($clipBox.topLeft.y; "&xml;")+","\
					+String:C10($clipBox.topRight.x; "&xml;")+" "+String:C10($clipBox.topRight.y; "&xml;")+","\
					+String:C10($clipBox.bottomRight.x; "&xml;")+" "+String:C10($clipBox.bottomRight.y; "&xml;")+","\
					+String:C10($clipBox.bottomLeft.x; "&xml;")+" "+String:C10($clipBox.bottomLeft.y; "&xml;"))
				
				$xPos:=$translatedBox.topLeft.x
				$yPos:=(0.8*$lineHeight)+$translatedBox.topLeft.y
				
				DOM SET XML ATTRIBUTE:C866($elemRef; "x"; $xPos)
				DOM SET XML ATTRIBUTE:C866($elemRef; "y"; $yPos)
				
				DOM SET XML ATTRIBUTE:C866($elemRef; "transform"; "rotate("+String:C10(-$valObj.textOrientation)+", "+String:C10($translatedBox.topLeft.x; "&xml;")+", "+String:C10($translatedBox.topLeft.y; "&xml;")+")")
				
			End if 
			
			//// VALUE ////
			Case of 
				: ($valObj.isVerticalText)
					svg_printVerticalText($elemRef; $valueStr; Choose:C955((($valObj.shrinkToFit#"") & (Num:C11($valObj.shrinkToFit; ".")<Num:C11($fontSize; "."))); $valObj.shrinkToFit; $fontSize); $valObj; False:C215)
					
				: ($valObj.strPart#Null:C1517)
					C_TEXT:C284($part1Ref)
					C_TEXT:C284($part2Ref)
					C_REAL:C285($yPos)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($elemRef; "y"; $yPos)
					$part1Ref:=DOM Create XML element:C865($elemRef; "text"; "style"; $styleStr)
					$part2Ref:=DOM Create XML element:C865($elemRef; "text"; "style"; $styleStr)
					DOM SET XML ATTRIBUTE:C866($part1Ref; "x"; $valObj.x+2; "y"; $yPos)
					If ($valObj.textOrientation#0) & ($valObj.textOrientation#NONE_TEXT_ORIENTATION)
						DOM SET XML ATTRIBUTE:C866($part2Ref; "x"; $valObj.x+svg_getTextWidth($valObj.strPart.part1)+2; "y"; $yPos)
					Else 
						DOM SET XML ATTRIBUTE:C866($part2Ref; "x"; $valObj.x+$valObj.width; "y"; $yPos; "text-anchor"; "end")
					End if 
					DOM SET XML ELEMENT VALUE:C868($part2Ref; $valObj.strPart.part2)
					DOM SET XML ELEMENT VALUE:C868($part1Ref; $valObj.strPart.part1)
					
				Else 
					
					//If (Not($valObj.wordWrap))
					$valueStr:=Replace string:C233($valueStr; "\n"; " ")
					//$valueStr:=Replace string($valueStr;"\r";" ")
					//End if 
					
					If (Match regex:C1019(" {2,}"; $valueStr; 1; $pos; $len))
						C_LONGINT:C283($pos; $len; $i)
						C_BOOLEAN:C305($sp)
						
						If ($valObj.wordWrap) & ($valObj.shrinkToFit="")
							$sp:=False:C215
							For ($i; 1; Length:C16($valueStr))
								If ($valueStr[[$i]]#" ")
									$sp:=False:C215
								Else 
									If (Not:C34($sp))
										$sp:=True:C214
									Else 
										$valueStr[[$i-1]]:=" "  //<- espace insecable (alt+255)
										$sp:=False:C215
									End if 
								End if 
							End for 
							
						Else 
							$valueStr:=Replace string:C233($valueStr; " "; " ")  //<- espace insecable (alt+255)
							
						End if 
						
					End if 
					
					
					If ($valObj.wordWrapInfo=Null:C1517)
						DOM SET XML ELEMENT VALUE:C868($elemRef; $valueStr)
					End if 
					
			End case 
		End if 
		
		If ($valObj.textIndent#"")
			Case of 
				: ($valObj.hAlign=CENTER_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False:C215)
					If ($valObj.wordWrap=True:C214)
						$valObj.x:=$valObj.x-(Num:C11($valObj.textIndent)*8)
						
						$valObj.width:=$valObj.width+(Num:C11($valObj.textIndent)*16)
					End if 
					
				: ($valObj.hAlign=LEFT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False:C215)
					$valObj.x:=$valObj.x-(Num:C11($valObj.textIndent)*8)
					$valObj.width:=$valObj.width+(Num:C11($valObj.textIndent)*8)
					
				: ($valObj.hAlign=RIGHT_HORIZONTAL_ALIGN) & ($valObj.isVerticalText=False:C215)
					$valObj.width:=$valObj.width-(Num:C11($valObj.textIndent)*8)
					
				: ($valObj.vAlign=TOP_VERTICAL_ALIGN) & ($valObj.isVerticalText=True:C214)
					$valObj.y:=$valObj.y-(Num:C11($valObj.textIndent)*8)
					$valObj.height:=$valObj.height+(Num:C11($valObj.textIndent)*8)
					
				: ($valObj.vAlign=BOTTOM_VERTICAL_ALIGN) & ($valObj.isVerticalText=True:C214)
					$valObj.height:=$valObj.height+(Num:C11($valObj.textIndent)*8)
					
			End case 
		End if 
		
		If ($valObj.cellPadding#Null:C1517)
			$valObj.x:=$valObj.x-Num:C11($valObj.cellPadding.left)
			$valObj.y:=$valObj.y-Num:C11($valObj.cellPadding.top)
			$valObj.width:=$valObj.width+Num:C11($valObj.cellPadding.left)+Num:C11($valObj.cellPadding.right)
			$valObj.height:=$valObj.height+Num:C11($valObj.cellPadding.top)+Num:C11($valObj.cellPadding.bottom)
			
		End if 
		
	End for each 
	
End if 