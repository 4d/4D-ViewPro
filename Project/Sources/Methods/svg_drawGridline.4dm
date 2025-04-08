//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($svgRef : Text; $lineObj : Object; $bcObj : Object; $range : Object; $colPos : Pointer; $rowPos : Pointer; $gridInfo : Object; $mergeTab : Collection)

var $color : Text
$color:="rgb(212,212,212)"

Case of 
	: ($gridInfo=Null:C1517)
	: ($gridInfo.color=Null:C1517)
	: (Value type:C1509($gridInfo.color)=Is text:K8:3)
		$color:=svg_retrieveColor ($gridInfo.color)
	Else 
		ASSERT:C1129(Structure file:C489#Structure file:C489(*);"grid info.color is not a text value")
End case 

var $drawVGrid : Boolean
$drawVGrid:=True:C214

Case of 
	: ($gridInfo=Null:C1517)
	: (Value type:C1509($gridInfo.showVerticalGridline)#Is boolean:K8:9)
	Else 
		$drawVGrid:=$gridInfo.showVerticalGridline
End case 

var $drawHGrid : Boolean
$drawHGrid:=True:C214

Case of 
	: ($gridInfo=Null:C1517)
	: (Value type:C1509($gridInfo.showHorizontalGridline)#Is boolean:K8:9)
	Else 
		$drawHGrid:=$gridInfo.showHorizontalGridline
End case 

var $cellMergeStatus : Object
var $elemRef : Text
var $X; $Y : Integer

If ($drawHGrid)
	
	var $lineH : Object
	var $noBgH; $noBrdH : Boolean
	
	For ($Y;$range.y1;$range.y2+1)
		
		$lineH:=Null:C1517
		
		For ($X;$range.x1;$range.x2)
			
			$cellMergeStatus:=svg_getCellMergeStatus ($Y;$X;$mergeTab)
			
			$noBgH:=True:C214
			
			If ($bcObj#Null:C1517)
				If ($bcObj.bcGrid#Null:C1517)
					If ($bcObj.bcGrid[String:C10($Y)]#Null:C1517)
						If ($bcObj.bcGrid[String:C10($Y)][String:C10($X)]#Null:C1517)
							If (String:C10($bcObj.bcGrid[String:C10($Y)][String:C10($X)].col)#"$4D_NOCOLOR")
								$noBgH:=False:C215
							End if 
						End if 
					End if 
					If ($bcObj.bcGrid[String:C10($Y-1)]#Null:C1517)
						If ($bcObj.bcGrid[String:C10($Y-1)][String:C10($X)]#Null:C1517)
							If (String:C10($bcObj.bcGrid[String:C10($Y-1)][String:C10($X)].col)#"$4D_NOCOLOR")
								$noBgH:=False:C215
							End if 
						End if 
					End if 
				End if 
			End if 
			
			$noBrdH:=True:C214
			
/*If ($lineObj#Null)
If ($lineObj.H#Null)
If ($lineObj.H[String($X)+";"+String($Y)]#Null)
$noBrdH:=False
End if 
End if 
End if*/
			
			If ($lineObj#Null:C1517)
				If ($lineObj.sortedMap#Null:C1517)
					If (svg_checkColIndex ($lineObj.sortedMap;$Y))
						If (svg_checkColIndex ($lineObj.sortedMap[$Y];$X))
							If ($lineObj.sortedMap[$Y][$X].H#Null:C1517)
								If ($lineObj.sortedMap[$y][$x].H.isOriented=False:C215)
									$noBrdH:=False:C215
								End if 
								If ($lineObj.sortedMap[$y][$x].H.isOriented=True:C214)
									$noBgH:=True:C214
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
			
			If ($noBrdH)
				
				If ($cellMergeStatus.type#FREE)
					$noBrdH:=$cellMergeStatus.topBorder
				End if 
				
			End if 
			
			If ($noBgH) & ($noBrdH)
				If ($lineH=Null:C1517)
					$lineH:=New object:C1471
					$lineH.y1:=$rowPos->{Int:C8($Y-$range.y1+1)}
					$lineH.y2:=$lineH.y1
					$lineH.x1:=$colPos->{Int:C8($X-$range.x1+1)}
					$lineH.x2:=$colPos->{Int:C8($X-$range.x1+2)}
				Else 
					$lineH.x2:=$colpos->{Int:C8($X-$range.x1+2)}
				End if 
			Else 
				If ($lineH#Null:C1517)
					$elemRef:=DOM Create XML element:C865($svgRef;"line";"x1";$lineH.x1;"x2";$lineH.x2;"y1";$lineH.y1;"y2";$lineH.y2;"stroke";$color;"vector-effect";"non-scalling-stroke";"stroke-width";1;"shape-rendering";"crispEdges")
					$lineH:=Null:C1517
				End if 
			End if 
			
		End for 
		
		If ($lineH#Null:C1517)
			$elemRef:=DOM Create XML element:C865($svgRef;"line";"x1";$lineH.x1;"x2";$lineH.x2;"y1";$lineH.y1;"y2";$lineH.y2;"stroke";$color;"vector-effect";"non-scalling-stroke";"stroke-width";1;"shape-rendering";"crispEdges")
			$lineH:=Null:C1517
		End if 
		
	End for 
	
End if 

If ($drawVGrid)
	
	var $lineV : Object
	var $noBgV; $noBrdV : Boolean
	
	For ($X;$range.x1;$range.x2+1)
		
		$lineV:=Null:C1517
		
		For ($Y;$range.y1;$range.y2)
			
			$cellMergeStatus:=svg_getCellMergeStatus ($Y;$X;$mergeTab)
			
			$noBgV:=True:C214
			
			If ($bcObj#Null:C1517)
				If ($bcObj.bcGrid#Null:C1517)
					If ($bcObj.bcGrid[String:C10($Y)]#Null:C1517)
						If ($bcObj.bcGrid[String:C10($Y)][String:C10($X)]#Null:C1517)
							If (String:C10($bcObj.bcGrid[String:C10($Y)][String:C10($X)].col)#"$4D_NOCOLOR")
								$noBgV:=False:C215
							End if 
						End if 
						If ($bcObj.bcGrid[String:C10($Y)][String:C10($X-1)]#Null:C1517)
							If (String:C10($bcObj.bcGrid[String:C10($Y)][String:C10($X-1)].col)#"$4D_NOCOLOR")
								$noBgV:=False:C215
							End if 
						End if 
					End if 
				End if 
			End if 
			
			$noBrdV:=True:C214
			
/*If ($lineObj#Null)
If ($lineObj.V#Null)
If ($lineObj.V[String($X)+";"+String($Y)]#Null)
$noBrdV:=False
End if 
End if 
End if */
			
			If ($lineObj#Null:C1517)
				If ($lineObj.sortedMap#Null:C1517)
					If (svg_checkColIndex ($lineObj.sortedMap;$Y))
						If (svg_checkColIndex ($lineObj.sortedMap[$Y];$X))
							If ($lineObj.sortedMap[$Y][$X].V#Null:C1517)
								$noBrdV:=False:C215
							End if 
						End if 
					End if 
				End if 
			End if 
			
			If ($noBrdV)
				
				If ($cellMergeStatus.type#FREE)
					$noBrdV:=$cellMergeStatus.leftBorder
				End if 
				
			End if 
			
			If ($noBgV) & ($noBrdV)
				If ($lineV=Null:C1517)
					$lineV:=New object:C1471
					$lineV.y1:=$rowPos->{Int:C8($Y-$range.y1+1)}
					$lineV.y2:=$rowPos->{Int:C8($Y-$range.y1+2)}
					$lineV.x1:=$colPos->{Int:C8($X-$range.x1+1)}
					$lineV.x2:=$lineV.x1
				Else 
					$lineV.y2:=$rowPos->{Int:C8($Y-$range.y1+2)}
				End if 
			Else 
				If ($lineV#Null:C1517)
					$elemRef:=DOM Create XML element:C865($svgRef;"line";"x1";$lineV.x1;"x2";$lineV.x2;"y1";$lineV.y1;"y2";$lineV.y2;"stroke";$color;"vector-effect";"non-scalling-stroke";"stroke-width";1;"shape-rendering";"crispEdges")
					$lineV:=Null:C1517
				End if 
			End if 
			
		End for 
		
		If ($lineV#Null:C1517)
			$elemRef:=DOM Create XML element:C865($svgRef;"line";"x1";$lineV.x1;"x2";$lineV.x2;"y1";$lineV.y1;"y2";$lineV.y2;"stroke";$color;"vector-effect";"non-scalling-stroke";"stroke-width";1;"shape-rendering";"crispEdges")
			$lineV:=Null:C1517
		End if 
		
	End for 
	
End if 