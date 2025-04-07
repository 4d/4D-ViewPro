//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($style : Object; $parsed : Object)

If ($parsed.topBorderStyle=NONE_BORDER_STYLE)
	Case of 
		: (Value type:C1509($style.borderTop)=Is undefined:K8:13)
		: ($style.borderTop=Null:C1517)
			$parsed.topBorderStyle:=0
		: (Value type:C1509($style.borderTop)#Is object:K8:27)
		: ($style.borderTop.style=Null:C1517)
		: (Value type:C1509($style.borderTop.style)#Is real:K8:4)
			$parsed.topBorderStyle:=0
		Else 
			$parsed.topBorderStyle:=$style.borderTop.style
			$parsed.topBorderColor:="black"
			If (Value type:C1509($style.borderTop.color)=Is text:K8:3)
				$parsed.topBorderColor:=svg_retrieveColor($style.borderTop.color)
			End if 
	End case 
End if 

If ($parsed.bottomBorderStyle=NONE_BORDER_STYLE)
	Case of 
		: (Value type:C1509($style.borderBottom)=Is undefined:K8:13)
		: ($style.borderBottom=Null:C1517)
			$parsed.bottomBorderStyle:=0
		: (Value type:C1509($style.borderBottom)#Is object:K8:27)
		: ($style.borderBottom.style=Null:C1517)
		: (Value type:C1509($style.borderBottom.style)#Is real:K8:4)
			$parsed.bottomBorderStyle:=0
		Else 
			$parsed.bottomBorderStyle:=$style.borderBottom.style
			$parsed.bottomBorderColor:="black"
			If (Value type:C1509($style.borderBottom.color)=Is text:K8:3)
				$parsed.bottomBorderColor:=svg_retrieveColor($style.borderBottom.color)
			End if 
	End case 
End if 

If ($parsed.leftBorderStyle=NONE_BORDER_STYLE)
	Case of 
		: (Value type:C1509($style.borderLeft)=Is undefined:K8:13)
		: ($style.borderLeft=Null:C1517)
			$parsed.leftBorderStyle:=0
		: (Value type:C1509($style.borderLeft)#Is object:K8:27)
		: ($style.borderLeft.style=Null:C1517)
		: (Value type:C1509($style.borderLeft.style)#Is real:K8:4)
			$parsed.leftBorderStyle:=0
		Else 
			$parsed.leftBorderStyle:=$style.borderLeft.style
			$parsed.leftBorderColor:="black"
			If (Value type:C1509($style.borderLeft.color)=Is text:K8:3)
				$parsed.leftBorderColor:=svg_retrieveColor($style.borderLeft.color)
			End if 
	End case 
End if 

If ($parsed.rightBorderStyle=NONE_BORDER_STYLE)
	Case of 
		: (Value type:C1509($style.borderRight)=Is undefined:K8:13)
		: ($style.borderRight=Null:C1517)
			$parsed.rightBorderStyle:=0
		: (Value type:C1509($style.borderRight)#Is object:K8:27)
		: ($style.borderRight.style=Null:C1517)
		: (Value type:C1509($style.borderRight.style)#Is real:K8:4)
			$parsed.rightBorderStyle:=0
		Else 
			$parsed.rightBorderStyle:=$style.borderRight.style
			$parsed.rightBorderColor:="black"
			If (Value type:C1509($style.borderRight.color)=Is text:K8:3)
				$parsed.rightBorderColor:=svg_retrieveColor($style.borderRight.color)
			End if 
	End case 
End if 

If ($parsed.diagonalUpStyle=NONE_BORDER_STYLE)
	Case of 
		: (Value type:C1509($style.diagonalUp)=Is undefined:K8:13)
		: ($style.diagonalUp=Null:C1517)
			$parsed.diagonalUpStyle:=0
		: (Value type:C1509($style.diagonalUp)#Is object:K8:27)
		: ($style.diagonalUp.style=Null:C1517)
		: (Value type:C1509($style.diagonalUp.style)#Is real:K8:4)
			$parsed.diagonalUpStyle:=0
		Else 
			$parsed.diagonalUpStyle:=$style.diagonalUp.style
			$parsed.diagonalUpColor:="black"
			If (Value type:C1509($style.diagonalUp.color)=Is text:K8:3)
				$parsed.diagonalUpColor:=svg_retrieveColor($style.diagonalUp.color)
			End if 
	End case 
End if 

If ($parsed.diagonalDownStyle=NONE_BORDER_STYLE)
	Case of 
		: (Value type:C1509($style.diagonalDown)=Is undefined:K8:13)
		: ($style.diagonalDown=Null:C1517)
			$parsed.diagonalDownStyle:=0
		: (Value type:C1509($style.diagonalDown)#Is object:K8:27)
		: ($style.diagonalDown.style=Null:C1517)
		: (Value type:C1509($style.diagonalDown.style)#Is real:K8:4)
			$parsed.diagonalDownStyle:=0
		Else 
			$parsed.diagonalDownStyle:=$style.diagonalDown.style
			$parsed.diagonalDownColor:="black"
			If (Value type:C1509($style.diagonalDown.color)=Is text:K8:3)
				$parsed.diagonalDownColor:=svg_retrieveColor($style.diagonalDown.color)
			End if 
	End case 
End if 

If ($parsed.hAlign=NONE_HORIZONTAL_ALIGN)
	
	If (Value type:C1509($style.hAlign)=Is real:K8:4)
		
		Case of 
			: ($style.hAlign=0)
				$parsed.hAlign:=LEFT_HORIZONTAL_ALIGN
			: ($style.hAlign=1)
				$parsed.hAlign:=CENTER_HORIZONTAL_ALIGN
			: ($style.hAlign=2)
				$parsed.hAlign:=RIGHT_HORIZONTAL_ALIGN
		End case 
		
	End if 
End if 

If ($parsed.backColor="")
	Case of 
		: (Value type:C1509($style.backColor)=Is null:K8:31)
			$parsed.backColor:=svg_retrieveColor("")  // NO COLOR
		: (Value type:C1509($style.backColor)=Is text:K8:3)
			$parsed.backColor:=svg_retrieveColor($style.backColor)
	End case 
End if 

If ($parsed.fill="")
	If (Value type:C1509($style.foreColor)=Is text:K8:3)
		$parsed.fill:=svg_retrieveColor($style.foreColor)
	End if 
End if 

If ($parsed.vAlign=NONE_VERTICAL_ALIGN)
	
	If (Value type:C1509($style.vAlign)=Is real:K8:4)
		
		Case of 
			: ($style.vAlign=0)
				$parsed.vAlign:=TOP_VERTICAL_ALIGN
			: ($style.vAlign=1)
				$parsed.vAlign:=CENTER_VERTICAL_ALIGN
			: ($style.vAlign=2)
				$parsed.vAlign:=BOTTOM_VERTICAL_ALIGN
		End case 
		
	End if 
	
End if 

If ($parsed.font="")
	If (Value type:C1509($style.font)=Is text:K8:3)
		
		$parsed.font:=$style.font
		$parsed.fontObj:=VP Font to object($parsed.font)
		$parsed.font:=Replace string:C233($parsed.font; "\""; "'")
		If ($parsed.fontObj.size#Null:C1517)
			C_COLLECTION:C1488($fontLineSizeCol)
			
			$fontLineSizeCol:=Split string:C1554($parsed.fontObj.size; "/")
			
			If (Num:C11($fontLineSizeCol[0]; ".")=0)
				$parsed.fontObj.size:=Null:C1517
			Else 
				$parsed.fontObj.size:=svg_convertUnitToPx($fontLineSizeCol[0])
			End if 
			
			Case of 
				: ($fontLineSizeCol.length<2) & (Value type:C1509($parsed.fontObj.size)=Is text:K8:3)
					$parsed.fontObj.lineHeight:=1.2*Num:C11($parsed.fontObj.size; ".")
				: ($fontLineSizeCol[1]="normal") & (Value type:C1509($parsed.fontObj.size)=Is text:K8:3)
					$parsed.fontObj.lineHeight:=1.2*Num:C11($parsed.fontObj.size; ".")
				: (String:C10(Num:C11($fontLineSizeCol[1]; "."); "&xml;")=$fontLineSizeCol[1]) & (Value type:C1509($parsed.fontObj.size)=Is text:K8:3)
					$parsed.fontObj.lineHeight:=Num:C11($fontLineSizeCol[1]; ".")*Num:C11($parsed.fontObj.size; ".")
				Else 
					$parsed.fontObj.lineHeight:=Num:C11(svg_convertUnitToPx($fontLineSizeCol[1]); ".")
			End case 
		End if 
		
	End if 
End if 

If ($parsed.textDecoration="")
	Case of 
		: (Value type:C1509($style.textDecoration)=Is real:K8:4)
			
			If ($style.textDecoration=0)
				$parsed.textDecoration:="none"
				
			Else 
				
				Case of 
					: (($style.textDecoration & 1)>0)
						$parsed.textDecoration:="underline"
					: (($style.textDecoration & 8)>0)
						$parsed.textDecoration:="double underline"
				End case 
				
				If (($style.textDecoration & 2)>0)
					$parsed.textDecoration:=$parsed.textDecoration+" line-through"
				End if 
				
				If (($style.textDecoration & 4)>0)
					$parsed.textDecoration:=$parsed.textDecoration+" overline"
				End if 
				
			End if 
		: (Value type:C1509($style.textDecoration)=Is null:K8:31)
			
			$parsed.textDecoration:="$4D_tdnull"
			
	End case 
End if 

If ($parsed.isVerticalText=2)
	If (Value type:C1509($style.isVerticalText)=Is boolean:K8:9)
		
		$parsed.isVerticalText:=Choose:C955($style.isVerticalText; 1; 0)
		
	End if 
	
End if 

If ($parsed.formatInfo=Null:C1517)
	If (Value type:C1509($style.formatInfo)=Is object:K8:27)
		$parsed.formatInfo:=$style.formatInfo
		
		If (Value type:C1509($parsed.formatInfo.color)=Is text:K8:3)
			$parsed.fill:=svg_retrieveColor($parsed.formatInfo.color)
		End if 
	End if 
End if 

If ($parsed.cellTypeName="")
	If (Value type:C1509($style.cellType)=Is object:K8:27)
		
		If (Value type:C1509($style.cellType.typeName)=Is text:K8:3)
			$parsed.cellTypeName:=$style.cellType.typeName
		End if 
		
		If (Value type:C1509($style.cellType.pict)=Is text:K8:3)
			$parsed.pict:=$style.cellType.pict
		End if 
		
	End if 
End if 

If ($parsed.backgroundImage="")
	If (Value type:C1509($style.backgroundImage)=Is text:K8:3)
		$parsed.backgroundImage:=$style.backgroundImage
	End if 
End if 

If ($parsed.backgroundImageLayout="")
	If (Value type:C1509($style.backgroundImageLayout)=Is real:K8:4)
		$parsed.backgroundImageLayout:=String:C10($style.backgroundImageLayout)
	End if 
End if 

If ($parsed.wordWrap=2)
	If (Value type:C1509($style.wordWrap)=Is boolean:K8:9)
		
		$parsed.wordWrap:=Choose:C955($style.wordWrap; 1; 0)
		
	End if 
	
End if 

If ($parsed.textIndent="")
	If (Value type:C1509($style.textIndent)=Is real:K8:4)
		
		If (($parsed.hAlign=CENTER_HORIZONTAL_ALIGN) & ($parsed.isVerticalText#1)) | (($parsed.vAlign=CENTER_VERTICAL_ALIGN) & ($parsed.isVerticalText=1))
			$parsed.textIndent:=String:C10($style.textIndent/2)
			
		Else 
			$parsed.textIndent:=String:C10($style.textIndent)
			
		End if 
	End if 
	
End if 

If ($parsed.cellPadding=Null:C1517)
	If (Value type:C1509($style.cellPadding)=Is text:K8:3)
		$parsed.cellPadding:=New object:C1471
		svg_getCellPadding($style.cellPadding; $parsed.cellPadding)
	End if 
	
End if 

If ($parsed.shrinkToFit=2)
	If (Value type:C1509($style.shrinkToFit)=Is boolean:K8:9)
		
		$parsed.shrinkToFit:=Choose:C955($style.shrinkToFit; 1; 0)
		
	End if 
	
End if 

If ($parsed.textOrientation=NONE_TEXT_ORIENTATION)
	If (Value type:C1509($style.textOrientation)=Is real:K8:4)
		$parsed.textOrientation:=$style.textOrientation
		If ($parsed.textOrientation>90) | ($parsed.textOrientation<-90)
			$parsed.textOrientation:=0
		End if 
	End if 
	If (Value type:C1509($style.textOrientation)=Is text:K8:3)
		$parsed.textOrientation:=Num:C11($style.textOrientation)
		If ($parsed.textOrientation>90) | ($parsed.textOrientation<-90)
			$parsed.textOrientation:=0
		End if 
	End if 
End if 

If ($parsed.wordWrapInfo=Null:C1517)
	If (Value type:C1509($style.wordWrapInfo)=Is object:K8:27)
		$parsed.wordWrapInfo:=$style.wordWrapInfo
	End if 
End if 