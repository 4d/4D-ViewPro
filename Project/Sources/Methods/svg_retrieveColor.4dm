//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1; $color; $0)

$color:=$1

Case of 
	: ($color="hyperlink") | ($color="followedHyperlink")
		$0:="rgb("+String:C10(theme.themeColor[$color].r)+","+String:C10(theme.themeColor[$color].g)+","+String:C10(theme.themeColor[$color].b)+")"
		
	: ($color="Text@") | ($color="Background@") | ($color="Accent@")
		C_COLLECTION:C1488($colorCol)
		C_OBJECT:C1216($colorObj)
		
		$colorObj:=Null:C1517
		$colorCol:=Split string:C1554($color; " ")
		
		If ($colorCol.length>=2)
			$color:=Lowercase:C14($colorCol[0])+$colorCol[1]
			$colorObj:=OB Copy:C1225(theme.themeColor[$color])
		Else 
			$colorObj:=Null:C1517
		End if 
		
		$colorObj.factor:=0
		If ($colorCol.length>=3)
			$colorObj.factor:=Num:C11($colorCol[2])
		End if 
		
		If ($colorObj=Null:C1517)
			$0:="#000000"
		Else 
			svg_applyLum($colorObj)
			
			$colorObj.r:=Choose:C955($colorObj.r>255; 255; $colorObj.r)
			$colorObj.g:=Choose:C955($colorObj.g>255; 255; $colorObj.g)
			$colorObj.b:=Choose:C955($colorObj.b>255; 255; $colorObj.b)
			
			$0:="rgb("+String:C10(Round:C94($colorObj.r; 0))+","+String:C10(Round:C94($colorObj.g; 0))+","+String:C10(Round:C94($colorObj.b; 0))+")"
		End if 
	Else 
		$0:=$color
End case 