//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($svgRef;$1)
C_OBJECT:C1216($lineObj;$2;$bcObj;$3;$range;$4;$gridInfo;$7)
C_POINTER:C301($colPos;$5;$rowPos;$6)
C_COLLECTION:C1488($mergeTab;$8)

$svgRef:=$1
$lineObj:=$2
$bcObj:=$3
$range:=$4
$colPos:=$5
$rowPos:=$6
$gridInfo:=$7
$mergeTab:=$8

C_TEXT:C284($color)
C_OBJECT:C1216($cellMergeStatus)

$color:="rgb(212,212,212)"

Case of 
	: ($gridInfo=Null:C1517)
	: ($gridInfo.color=Null:C1517)
	: (Value type:C1509($gridInfo.color)=Is text:K8:3)
		$color:=svg_retrieveColor ($gridInfo.color)
	Else 
		ASSERT:C1129(Structure file:C489#Structure file:C489(*);"grid info.color is not a text value")
End case 

C_BOOLEAN:C305($drawVGrid)

$drawVGrid:=True:C214

Case of 
	: ($gridInfo=Null:C1517)
	: (Value type:C1509($gridInfo.showVerticalGridline)#Is boolean:K8:9)
	Else 
		$drawVGrid:=$gridInfo.showVerticalGridline
End case 

C_BOOLEAN:C305($drawHGrid)

$drawHGrid:=True:C214

Case of 
	: ($gridInfo=Null:C1517)
	: (Value type:C1509($gridInfo.showHorizontalGridline)#Is boolean:K8:9)
	Else 
		$drawHGrid:=$gridInfo.showHorizontalGridline
End case 

If ($drawHGrid)
	
	C_LONGINT:C283($X;$Y)
	C_OBJECT:C1216($lineH)
	C_BOOLEAN:C305($noBgH)
	C_BOOLEAN:C305($noBrdH)
	C_TEXT:C284($elemRef)
	
	For ($Y;$range.y1;$range.y2+1)
		
		$lineH:=Null:C1517
		
		For ($X;$range.x1;$range.x2)
			
			$cellMergeStatus:=svg_getCellMergeStatus ($Y;$X;$mergeTab)
			
			$noBgH:=True:C214
			
			If ($bcObj#Null:C1517)
				If ($bcObj.bcGrid#Null:C1517)
					If ($bcObj.bcGrid[String:C10($Y)]#Null:C1517)
						If ($bcObj.bcGrid[String:C10($Y)][String:C10($X)]#Null:C1517)
							$noBgH:=False:C215
						End if 
					End if 
					If ($bcObj.bcGrid[String:C10($Y-1)]#Null:C1517)
						If ($bcObj.bcGrid[String:C10($Y-1)][String:C10($X)]#Null:C1517)
							$noBgH:=False:C215
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
	
	C_LONGINT:C283($X;$Y)
	C_OBJECT:C1216($lineV)
	C_BOOLEAN:C305($noBgV)
	C_BOOLEAN:C305($noBrdV)
	C_TEXT:C284($elemRef)
	
	For ($X;$range.x1;$range.x2+1)
		
		$lineV:=Null:C1517
		
		For ($Y;$range.y1;$range.y2)
			
			$cellMergeStatus:=svg_getCellMergeStatus ($Y;$X;$mergeTab)
			
			$noBgV:=True:C214
			
			If ($bcObj#Null:C1517)
				If ($bcObj.bcGrid#Null:C1517)
					If ($bcObj.bcGrid[String:C10($Y)]#Null:C1517)
						If ($bcObj.bcGrid[String:C10($Y)][String:C10($X)]#Null:C1517)
							$noBgV:=False:C215
						End if 
						If ($bcObj.bcGrid[String:C10($Y)][String:C10($X-1)]#Null:C1517)
							$noBgV:=False:C215
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