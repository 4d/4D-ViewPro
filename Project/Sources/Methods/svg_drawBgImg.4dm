//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$svgRef)
C_COLLECTION:C1488($2;$bgImgCol)

C_TEXT:C284($backgroundImage;$backgroundImageLayout;$elemRef)
C_LONGINT:C283($x1;$y1;$width;$height;$pictX;$pictY;$pictWidth;$pictHeight)
C_OBJECT:C1216($bgObj)

$svgRef:=$1
$bgImgCol:=$2

If ($bgImgCol#Null:C1517)
	For each ($bgObj;$bgImgCol)
		
		$backgroundImage:=$bgObj.bg
		$backgroundImageLayout:=$bgObj.lay
		$x1:=$bgObj.x
		$y1:=$bgObj.y
		$width:=$bgObj.w
		$height:=$bgObj.h
		
		$elemRef:=DOM Create XML element:C865($svgRef;"/svg/clipPath";"id";String:C10($x1)+";"+String:C10($y1))
		$elemRef:=DOM Create XML element:C865($elemRef;"rect";"x";$x1;"y";$y1;"width";$width;"height";$height)
		
		$elemRef:=DOM Create XML element:C865($svgRef;"/svg/image";"clip-path";"url(#"+String:C10($x1)+";"+String:C10($y1)+")")
		
		
		svg_getPictSize (->$backgroundImage;->$pictWidth;->$pictHeight)
		
		Case of 
			: ($backgroundImageLayout="")
				DOM SET XML ATTRIBUTE:C866($elemRef;"x";$x1;"y";$y1)
				
			: ($backgroundImageLayout="1")
				$pictX:=$x1+($width/2)-($pictWidth/2)
				$pictX:=Choose:C955($pictX<$x1;$x1;$pictX)
				$pictY:=$y1+($height/2)-($pictHeight/2)
				$pictY:=Choose:C955($pictY<$y1;$y1;$pictY)
				
				DOM SET XML ATTRIBUTE:C866($elemRef;"x";$pictX;"y";$pictY)
				
			Else 
				DOM SET XML ATTRIBUTE:C866($elemRef;"x";$x1;"y";$y1)
				
		End case 
		
		Case of 
			: ($backgroundImageLayout="")
				DOM SET XML ATTRIBUTE:C866($elemRef;"preserveAspectRatio";"none")
				
			: ($backgroundImageLayout="0")
				DOM SET XML ATTRIBUTE:C866($elemRef;"preserveAspectRatio";"none")
				
			: ($backgroundImageLayout="1")
				DOM SET XML ATTRIBUTE:C866($elemRef;"preserveAspectRatio";"xMidyMid")
				
			: ($backgroundImageLayout="2")
				DOM SET XML ATTRIBUTE:C866($elemRef;"preserveAspectRatio";"xMidyMid")
				
			: ($backgroundImageLayout="3")
				DOM SET XML ATTRIBUTE:C866($elemRef;"preserveAspectRatio";"xMinyMin")
				
			Else 
				DOM SET XML ATTRIBUTE:C866($elemRef;"preserveAspectRatio";"none")
				
		End case 
		
		Case of 
			: ($backgroundImageLayout="")
				DOM SET XML ATTRIBUTE:C866($elemRef;"width";$width;"height";$height)
				
			: ($backgroundImageLayout="1") | ($backgroundImageLayout="3")
				DOM SET XML ATTRIBUTE:C866($elemRef;"width";$pictWidth;"height";$pictHeight)
				
			Else 
				DOM SET XML ATTRIBUTE:C866($elemRef;"width";$width;"height";$height)
				
		End case 
		
		DOM SET XML ATTRIBUTE:C866($elemRef;"xlink:href";$backgroundImage)
		
	End for each 
End if 