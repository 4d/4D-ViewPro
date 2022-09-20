//%attributes = {"invisible":true,"preemptive":"capable"}
C_POINTER:C301($4; $colPos; $5; $rowPos)
C_OBJECT:C1216($2; $lineObj; $3; $range; $doubleLineObj)
C_TEXT:C284($1; $svgRef)

$svgRef:=$1
$lineObj:=$2
$range:=$3
$colPos:=$4
$rowPos:=$5

$doubleLineObj:=$lineObj.double

C_LONGINT:C283($iterY; $iterX; $iterY2; $iterX2)
C_OBJECT:C1216($intersec)
C_REAL:C285($startX; $startY; $endX; $endY)
C_REAL:C285($l; $h; $L; $H)
C_BOOLEAN:C305($continue)

C_TEXT:C284($xPath; $elemRef)
$xPath:="/svg/line"

For ($iterY; $range.y1; $range.y2+1)
	For ($iterX; $range.x1; $range.x2+1)
		
		If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_RIGHT))
			$intersec:=$doubleLineObj[String:C10($iterY)][String:C10($iterX)]
			
			If ($intersec.upDrawed#True:C214)
				$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_UP))
						$startX:=$startX+3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX; DLI_DOWN) | ($lineObj.V[String:C10($iterX)+";"+String:C10($iterY-1)]#Null:C1517))
						$startX:=$startX+1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX-1; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX-$range.x1+1)}-$colPos->{Int:C8($iterX-$range.x1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$startX:=$startX-1+(2*($l/$h))
						
					Else 
						$startX:=$startX-1
						
				End case 
				
				$iterX2:=$iterX
				
				$continue:=True:C214
				While ($continue)
					
					If ($doubleLineObj[String:C10($iterY)][String:C10($iterX2)]#Null:C1517)
						$doubleLineObj[String:C10($iterY)][String:C10($iterX2)].upDrawed:=True:C214
					End if 
					
					$iterX2:=$iterX2+1
					
					Case of 
						: (Not:C34(svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_RIGHT)))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX2; DLI_DOWN))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX2-1; DLI_DIAGONAL_DOWN))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_DIAGONAL_UP))
							$continue:=False:C215
							
						: ($intersec.hr#$doubleLineObj[String:C10($iterY)][String:C10($iterX2)].hr)
							$continue:=False:C215
							
					End case 
					
				End while 
				
				$endX:=$colPos->{Int:C8($iterX2-$range.x1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX2-1; DLI_DIAGONAL_DOWN))
						$endX:=$endX-3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX2; DLI_DOWN) | ($lineObj.V[String:C10($iterX2)+";"+String:C10($iterY-1)]#Null:C1517))
						$endX:=$endX-1
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX2-$range.x1+2)}-$colPos->{Int:C8($iterX2-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$endX:=$endX+1-(2*($l/$h))
					Else 
						$endX:=$endX+1
						
				End case 
				
				$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-1
				$endY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-1
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "shape-rendering"; "crispEdges"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.hr; "stroke-width"; 1)
				
			End if 
			
			If ($intersec.downDrawed#True:C214)
				$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_DOWN))
						$startX:=$startX+3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DOWN) | ($lineObj.V[String:C10($iterX)+";"+String:C10($iterY)]#Null:C1517))
						$startX:=$startX+1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX-1; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX-$range.x1+1)}-$colPos->{Int:C8($iterX-$range.x1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$startX:=$startX-1+(2*($l/$h))
						
					Else 
						$startX:=$startX-1
				End case 
				
				$iterX2:=$iterX
				
				$continue:=True:C214
				While ($continue)
					
					If ($doubleLineObj[String:C10($iterY)][String:C10($iterX2)]#Null:C1517)
						$doubleLineObj[String:C10($iterY)][String:C10($iterX2)].downDrawed:=True:C214
					End if 
					
					$iterX2:=$iterX2+1
					
					Case of 
						: (Not:C34(svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_RIGHT)))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_DOWN))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_DIAGONAL_DOWN))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX2-1; DLI_DIAGONAL_UP))
							$continue:=False:C215
							
						: ($intersec.hr#$doubleLineObj[String:C10($iterY)][String:C10($iterX2)].hr)
							$continue:=False:C215
							
					End case 
					
				End while 
				
				$endX:=$colPos->{Int:C8($iterX2-$range.x1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX2-1; DLI_DIAGONAL_UP))
						$endX:=$endX-3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_DOWN) | ($lineObj.V[String:C10($iterX2)+";"+String:C10($iterY)]#Null:C1517))
						$endX:=$endX-1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX2; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX2-$range.x1+1)}-$colPos->{Int:C8($iterX2-$range.x1+2)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1+2)}
						
						$endX:=$endX+1-(2*($l/$h))
						
					Else 
						$endX:=$endX+1
						
				End case 
				
				$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+1
				$endY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+1
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "shape-rendering"; "crispEdges"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.hr; "stroke-width"; 1)
				
				//$svgSource->:=$svgSource->+"<line vector-effect=\"non-scaling-stroke\" shape-rendering=\"crispEdges\" x1=\""+String($startX;"&xml")+"\" y1=\""+String($startY;"&xml")+"\" x2=\""+String($endX;"&xml")+"\" y2=\""\
																									+String($endY;"&xml")+"\" stroke=\""+$intersec.hr+"\" stroke-width=\"1\"/>"
				
			End if 
			
		End if 
		
		If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DOWN))
			$intersec:=$doubleLineObj[String:C10($iterY)][String:C10($iterX)]
			
			If ($intersec.leftDrawed#True:C214)
				$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX-1; DLI_DIAGONAL_UP))
						$startY:=$startY+3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX-1; DLI_RIGHT) | ($lineObj.H[String:C10($iterX-1)+";"+String:C10($iterY)]#Null:C1517))
						$startY:=$startY+1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX-1; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX-$range.x1+1)}-$colPos->{Int:C8($iterX-$range.x1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$startX:=$startX-1+(2*($h/$l))
						
					Else 
						$startY:=$startY-1
						
				End case 
				
				$iterY2:=$iterY
				
				$continue:=True:C214
				While ($continue)
					
					If ($doubleLineObj[String:C10($iterY2)]#Null:C1517)
						
						If ($doubleLineObj[String:C10($iterY2)][String:C10($iterX)]#Null:C1517)
							$doubleLineObj[String:C10($iterY2)][String:C10($iterX)].leftDrawed:=True:C214
						End if 
						
					End if 
					
					$iterY2:=$iterY2+1
					
					Case of 
						: (Not:C34(svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_DOWN)))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX-1; DLI_RIGHT))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2+1; $iterX-1; DLI_DIAGONAL_UP))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2-1; $iterX-1; DLI_DIAGONAL_DOWN))
							$continue:=False:C215
							
						: ($intersec.vb#$doubleLineObj[String:C10($iterY2)][String:C10($iterX)].vb)
							$continue:=False:C215
							
					End case 
					
				End while 
				
				$endY:=$rowPos->{Int:C8($iterY2-$range.y1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2-1; $iterX-1; DLI_DIAGONAL_DOWN))
						$endY:=$endY-3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX-1; DLI_RIGHT) | ($lineObj.H[String:C10($iterX-1)+";"+String:C10($iterY2)]#Null:C1517))
						$endY:=$endY-1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2+1; $iterX-1; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX-$range.x1+1)}-$colPos->{Int:C8($iterX-$range.x1)}
						$h:=$rowPos->{Int:C8($iterY2-$range.y1+2)}-$rowPos->{Int:C8($iterY2-$range.y1+1)}
						
						$endY:=$endY+1-(2*($h/$l))
						
					Else 
						$endY:=$endY+1
						
				End case 
				
				$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}-1
				$endX:=$colPos->{Int:C8($iterX-$range.x1+1)}-1
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "shape-rendering"; "crispEdges"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.vb; "stroke-width"; 1)
				
				//$svgSource->:=$svgSource->+"<line vector-effect=\"non-scaling-stroke\" shape-rendering=\"crispEdges\" x1=\""+String($startX;"&xml")+"\" y1=\""+String($startY;"&xml")+"\" x2=\""+String($endX;"&xml")+"\" y2=\""\
																									+String($endY;"&xml")+"\" stroke=\""+$intersec.vb+"\" stroke-width=\"1\"/>"
				
			End if 
			
			If ($intersec.rightDrawed#True:C214)
				$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_DOWN))
						$startY:=$startY+3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_RIGHT) | ($lineObj.H[String:C10($iterX)+";"+String:C10($iterY)]#Null:C1517))
						$startY:=$startY+1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$startY:=$startY-1+(2*($h/$l))
						
					Else 
						$startY:=$startY-1
						
				End case 
				
				$iterY2:=$iterY
				
				$continue:=True:C214
				While ($continue)
					
					If ($doubleLineObj[String:C10($iterY2)]#Null:C1517)
						
						If ($doubleLineObj[String:C10($iterY2)][String:C10($iterX)]#Null:C1517)
							$doubleLineObj[String:C10($iterY2)][String:C10($iterX)].rightDrawed:=True:C214
						End if 
						
					End if 
					
					$iterY2:=$iterY2+1
					
					Case of 
						: (Not:C34(svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_DOWN)))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_RIGHT))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_DIAGONAL_DOWN))
							$continue:=False:C215
							
						: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_DIAGONAL_UP))
							$continue:=False:C215
							
						: ($intersec.vb#$doubleLineObj[String:C10($iterY2)][String:C10($iterX)].vb)
							$continue:=False:C215
							
					End case 
					
				End while 
				
				$endY:=$rowPos->{Int:C8($iterY2-$range.y1+1)}
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_DIAGONAL_UP))
						$endY:=$endY-3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_RIGHT) | ($lineObj.H[String:C10($iterX)+";"+String:C10($iterY2)]#Null:C1517))
						$endY:=$endY-1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY2; $iterX; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY2-$range.y1+2)}-$rowPos->{Int:C8($iterY2-$range.y1+1)}
						
						$endY:=$endY+1-(2*($h/$l))
						
					Else 
						$endY:=$endY+1
						
				End case 
				
				$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
				$endX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "shape-rendering"; "crispEdges"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.vb; "stroke-width"; 1)
				
				//$svgSource->:=$svgSource->+"<line vector-effect=\"non-scaling-stroke\" shape-rendering=\"crispEdges\" x1=\""+String($startX;"&xml")+"\" y1=\""+String($startY;"&xml")+"\" x2=\""+String($endX;"&xml")+"\" y2=\""\
																									+String($endY;"&xml")+"\" stroke=\""+$intersec.vb+"\" stroke-width=\"1\"/>"
				
			End if 
			
		End if 
		
		If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_UP))
			$intersec:=$doubleLineObj[String:C10($iterY)][String:C10($iterX)]
			
			If ($intersec.DUUpDrawed#Null:C1517)
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX; DLI_DOWN) | ($lineObj.V[String:C10($iterX)+";"+String:C10($iterY-1)]#Null:C1517))
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX-1; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-3+(2*($h/$l))
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX-1; DLI_RIGHT) | ($lineObj.H[String:C10($iterX-1)+";"+String:C10($iterY)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1-(2*($l/$h))
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-1
						
					Else 
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-3
						
				End case 
				
				If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX; DLI_DIAGONAL_DOWN))
					$l:=($colPos->{Int:C8($iterX-$range.x1+2)}-3)-($colPos->{Int:C8($iterX-$range.x1+1)}+3)
					$h:=($rowPos->{Int:C8($iterY-$range.y1+1)}-3)-($rowPos->{Int:C8($iterY-$range.y1)}+3)
					
					$H:=$h+2
					$L:=$l+2
					
					$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+2+($h/2)
					$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3-(((($h/2)+1)/$H)*$L)
					
					$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
						"stroke"; $intersec.du; "stroke-width"; 1)
					
					$startX:=$colPos->{Int:C8($iterX-$range.x1+2)}-2-($l/2)
					$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-3-(((($l/2)+1)/$L)*$H)
					
				End if 
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX; DLI_RIGHT) | ($lineObj.H[String:C10($iterX)+";"+String:C10($iterY-1)]#Null:C1517))
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-2; $iterX; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3+(2*($h/$l))
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}
						
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-2; $iterX+1; DLI_DOWN) | ($lineObj.V[String:C10($iterX+1)+";"+String:C10($iterY-2)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+1-(2*($h/$l))
						
					Else 
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+1
						
				End case 
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.du; "stroke-width"; 1)
				
			End if 
			
			If ($intersec.DUDownDrawed#Null:C1517)
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_RIGHT) | ($lineObj.H[String:C10($iterX)+";"+String:C10($iterY)]#Null:C1517))
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3-(2*($h/$l))
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DOWN) | ($lineObj.V[String:C10($iterX)+";"+String:C10($iterY)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-1+(2*($h/$l))
						
					Else 
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}-1
						
				End case 
				
				If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX; DLI_DIAGONAL_DOWN))
					$l:=($colPos->{Int:C8($iterX-$range.x1+2)}-3)-($colPos->{Int:C8($iterX-$range.x1+1)}+3)
					$h:=($rowPos->{Int:C8($iterY-$range.y1+1)}-3)-($rowPos->{Int:C8($iterY-$range.y1)}+3)
					
					$H:=$h+2
					$L:=$l+2
					
					$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-2-($l/2)
					$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+3+(((($l/2)+1)/$L)*$H)
					
					$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
						"stroke"; $intersec.du; "stroke-width"; 1)
					
					$startY:=$rowPos->{Int:C8($iterY-$range.y1)}+2+($h/2)
					$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3+(((($h/2)+1)/$H)*$L)
				End if 
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX+1; DLI_DOWN) | ($lineObj.V[String:C10($iterX+1)+";"+String:C10($iterY-1)]#Null:C1517))
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX+1; DLI_DIAGONAL_DOWN))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+3-(2*($h/$l))
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX+1; DLI_RIGHT) | ($lineObj.H[String:C10($iterX+1)+";"+String:C10($iterY-1)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+1)}-$rowPos->{Int:C8($iterY-$range.y1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1+(2*($l/$h))
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+1
						
					Else 
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1
						$endY:=$rowPos->{Int:C8($iterY-$range.y1)}+3
						
				End case 
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.du; "stroke-width"; 1)
				
			End if 
			
		End if 
		
		If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_DOWN))
			$intersec:=$doubleLineObj[String:C10($iterY)][String:C10($iterX)]
			
			If ($intersec.DDUpDrawed#Null:C1517)
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_RIGHT) | ($lineObj.H[String:C10($iterX)+";"+String:C10($iterY)]#Null:C1517))
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3-(2*($h/$l))
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY-1; $iterX; DLI_DOWN) | ($lineObj.V[String:C10($iterX)+";"+String:C10($iterY-1)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+1-(2*($h/$l))
						
					Else 
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+1
						
				End case 
				
				If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX; DLI_DIAGONAL_UP))
					$l:=($colPos->{Int:C8($iterX-$range.x1+2)}-3)-($colPos->{Int:C8($iterX-$range.x1+1)}+3)
					$h:=($rowPos->{Int:C8($iterY-$range.y1+2)}-3)-($rowPos->{Int:C8($iterY-$range.y1+1)}+3)
					
					$H:=$h+2
					$L:=$l+2
					
					$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-2-($l/2)
					$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-3-(((($l/2)+1)/$L)*$H)
					
					$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
						"stroke"; $intersec.dd; "stroke-width"; 1)
					
					$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+2+($h/2)
					$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+3+(((($h/2)+1)/$H)*$L)
					
				End if 
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX+1; DLI_DOWN) | ($lineObj.V[String:C10($iterX+1)+";"+String:C10($iterY)]#Null:C1517))
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX+1; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-3+(2*($h/$l))
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX+1; DLI_RIGHT) | ($lineObj.H[String:C10($iterX+1)+";"+String:C10($iterY+1)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1+(2*($l/$h))
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-1
						
					Else 
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-3
						
				End case 
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.dd; "stroke-width"; 1)
				
			End if 
			
			If ($intersec.DDDownDrawed#Null:C1517)
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX; DLI_DOWN) | ($lineObj.V[String:C10($iterX)+";"+String:C10($iterY)]#Null:C1517))
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+3
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX-1; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+3-(2*($h/$l))
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY; $iterX-1; DLI_RIGHT) | ($lineObj.H[String:C10($iterX-1)+";"+String:C10($iterY)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1-(2*($l/$h))
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+1
						
					Else 
						$startX:=$colPos->{Int:C8($iterX-$range.x1+1)}+1
						$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+3
						
				End case 
				
				If (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX; DLI_DIAGONAL_UP))
					$l:=($colPos->{Int:C8($iterX-$range.x1+2)}-3)-($colPos->{Int:C8($iterX-$range.x1+1)}+3)
					$h:=($rowPos->{Int:C8($iterY-$range.y1+2)}-3)-($rowPos->{Int:C8($iterY-$range.y1+1)}+3)
					
					$H:=$h+2
					$L:=$l+2
					
					$endY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+2+($h/2)
					$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3-(((($h/2)+1)/$H)*$L)
					
					$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
						"stroke"; $intersec.dd; "stroke-width"; 1)
					
					$startX:=$colPos->{Int:C8($iterX-$range.x1+2)}-2-($l/2)
					$startY:=$rowPos->{Int:C8($iterY-$range.y1+1)}+3+(((($l/2)+1)/$L)*$H)
					
				End if 
				
				Case of 
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX; DLI_RIGHT) | ($lineObj.H[String:C10($iterX)+";"+String:C10($iterY+1)]#Null:C1517))
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-1
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+2; $iterX; DLI_DIAGONAL_UP))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3+(2*($h/$l))
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}
						
					: (svg_hasDoubleLineIntersection($doubleLineObj; $iterY+1; $iterX+1; DLI_DOWN) | ($lineObj.V[String:C10($iterX+1)+";"+String:C10($iterY+1)]#Null:C1517))
						$l:=$colPos->{Int:C8($iterX-$range.x1+2)}-$colPos->{Int:C8($iterX-$range.x1+1)}
						$h:=$rowPos->{Int:C8($iterY-$range.y1+2)}-$rowPos->{Int:C8($iterY-$range.y1+1)}
						
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-1
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-1+(2*($h/$l))
						
					Else 
						$endX:=$colPos->{Int:C8($iterX-$range.x1+2)}-3
						$endY:=$rowPos->{Int:C8($iterY-$range.y1+2)}-1
						
				End case 
				
				$elemRef:=DOM Create XML element:C865($svgRef; $xPath; "vector-effect"; "non-scaling-stroke"; "x1"; $startX; "y1"; $startY; "x2"; $endX; "y2"; $endY; \
					"stroke"; $intersec.dd; "stroke-width"; 1)
				
			End if 
			
		End if 
		
	End for 
End for 