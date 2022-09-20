//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($priorityTable)

$priorityTable:=New object:C1471
$priorityTable["0"]:=0
$priorityTable["9"]:=1
$priorityTable["1"]:=1
$priorityTable["3"]:=1
$priorityTable["4"]:=1
$priorityTable["7"]:=1
$priorityTable["11"]:=1
$priorityTable["2"]:=2
$priorityTable["10"]:=2
$priorityTable["12"]:=2
$priorityTable["8"]:=2
$priorityTable["13"]:=2
$priorityTable["5"]:=3
$priorityTable["6"]:=3


C_TEXT:C284($1;$svgRef)
C_OBJECT:C1216($2;$lineObj)
C_OBJECT:C1216($3;$range)
C_POINTER:C301($4;$colPos;$5;$rowPos)
C_OBJECT:C1216($line)
C_TEXT:C284($dash_array)
C_LONGINT:C283($iterX;$iterY)
C_TEXT:C284($sIterX;$sIterY)
C_BOOLEAN:C305($else)

$svgRef:=$1
$lineObj:=$2
$range:=$3
$colPos:=$4
$rowPos:=$5

C_TEXT:C284($elemRef)
C_TEXT:C284($xPath)

$xPath:="/svg/line"
/*
For ($iterY;$range.y1;$range.y2+1)
$strIterY:=String($iterY)
For ($iterX;$range.x1;$range.x2+1)
$strIterX:=String($iterX)

If ($lineObj.H[$strIterX+";"+$strIterY]#Null)
If ($lineObj.H[$strIterX+";"+$strIterY].style#6)
If ($lineObj.H[String($iterX-1)+";"+$strIterY]#Null)
If ($lineObj.H[$strIterX+";"+$strIterY].styleCol=$lineObj.H[String($iterX-1)+";"+$strIterY].styleCol)
$lineObj.H[$strIterX+";"+$strIterY].lineNum:=$lineObj.H[String($iterX-1)+";"+$strIterY].lineNum
$lineObj.lines[$lineObj.H[String($iterX-1)+";"+$strIterY].lineNum].x2:=$colPos->{Int($iterX-$range.x1+2)}
Else 
$line:=New object
$line.y1:=$rowPos->{Int($iterY-$range.y1+1)}
$line.y2:=$rowPos->{Int($iterY-$range.y1+1)}
$line.x1:=$colPos->{Int($iterX-$range.x1+1)}
$line.x2:=$colPos->{Int($iterX-$range.x1+2)}
$lineObj.H[$strIterX+";"+$strIterY].lineNum:=$lineObj.lines.length
$line.style:=$lineObj.H[$strIterX+";"+$strIterY].style
$line.color:=$lineObj.H[$strIterX+";"+$strIterY].color
$lineObj.lines.push($line)
End if 
Else 
$line:=New object
$line.y1:=$rowPos->{Int($iterY-$range.y1+1)}
$line.y2:=$rowPos->{Int($iterY-$range.y1+1)}
$line.x1:=$colPos->{Int($iterX-$range.x1+1)}
$line.x2:=$colPos->{Int($iterX-$range.x1+2)}
$lineObj.H[$strIterX+";"+$strIterY].lineNum:=$lineObj.lines.length
$line.style:=$lineObj.H[$strIterX+";"+$strIterY].style
$line.color:=$lineObj.H[$strIterX+";"+$strIterY].color
$lineObj.lines.push($line)
End if 
End if 
End if 

If ($lineObj.V[$strIterX+";"+$strIterY]#Null)
If ($lineObj.V[$strIterX+";"+$strIterY].style#6)
If ($lineObj.V[$strIterX+";"+String($iterY-1)]#Null)
If ($lineObj.V[$strIterX+";"+$strIterY].styleCol=$lineObj.V[$strIterX+";"+String($iterY-1)].styleCol)
$lineObj.V[$strIterX+";"+$strIterY].lineNum:=$lineObj.V[$strIterX+";"+String($iterY-1)].lineNum
$lineObj.lines[$lineObj.V[$strIterX+";"+String($iterY-1)].lineNum].y2:=$rowPos->{Int($iterY-$range.y1+2)}
Else 
$line:=New object
$line.y1:=$rowPos->{Int($iterY-$range.y1+1)}
$line.y2:=$rowPos->{Int($iterY-$range.y1+2)}
$line.x1:=$colPos->{Int($iterX-$range.x1+1)}
$line.x2:=$colPos->{Int($iterX-$range.x1+1)}
$lineObj.V[$strIterX+";"+$strIterY].lineNum:=$lineObj.lines.length
$line.style:=$lineObj.V[$strIterX+";"+$strIterY].style
$line.color:=$lineObj.V[$strIterX+";"+$strIterY].color
$lineObj.lines.push($line)
End if 
Else 
$line:=New object
$line.y1:=$rowPos->{Int($iterY-$range.y1+1)}
$line.y2:=$rowPos->{Int($iterY-$range.y1+2)}
$line.x1:=$colPos->{Int($iterX-$range.x1+1)}
$line.x2:=$colPos->{Int($iterX-$range.x1+1)}
$lineObj.V[$strIterX+";"+$strIterY].lineNum:=$lineObj.lines.length
$line.style:=$lineObj.V[$strIterX+";"+$strIterY].style
$line.color:=$lineObj.V[$strIterX+";"+$strIterY].color
$lineObj.lines.push($line)
End if 
End if 
End if 

End for 
End for 
*/

If ($lineObj.sortedMap#Null:C1517)
	
	For ($iterY;$range.y1;$range.y2+1)
		
		If (svg_checkColIndex ($lineObj.sortedMap;$iterY))
			
			For ($iterX;$range.x1;$range.x2+1)
				
				If (svg_checkColIndex ($lineObj.sortedMap[$iterY];$iterX))
					
					If ($lineObj.sortedMap[$iterY][$iterX].H#Null:C1517)
						
						$line:=New object:C1471
						
						
						If ($lineObj.sortedMap[$itery][$iterX].H.style#6)
							If ($lineObj.sortedMap[$iterY][$iterX].H.isOriented)
								
								$line.y1:=$rowPos->{Int:C8($iterY-$range.y1+1)}
								$line.y2:=$rowPos->{Int:C8($iterY-$range.y1+1)}
								$line.x1:=$colPos->{Int:C8($iterX-$range.x1+1)}+$lineObj.sortedMap[$iterY][$iterX].H.offset
								$line.x2:=$colPos->{Int:C8($iterX-$range.x1+2)}+$lineObj.sortedMap[$iterY][$iterX].H.offset
								$line.style:=$lineObj.sortedMap[$iterY][$iterX].H.style
								$line.color:=$lineObj.sortedMap[$iterY][$iterX].H.color
								
								$lineObj.lines.push($line)
								
							Else 
								
								$else:=True:C214
								If ($iterX>0)
									If ($lineObj.sortedMap[$iterY][$iterX].H.style#6)
										If (svg_checkColIndex ($lineObj.sortedMap[$iterY];$iterX-1))
											If ($lineObj.sortedMap[$iterY][$iterX-1].H#Null:C1517)
												If (Not:C34($lineObj.sortedMap[$iterY][$iterX-1].H.isOriented))
													If ($lineObj.sortedMap[$iterY][$iterX].H.style=$lineObj.sortedMap[$iterY][$iterX-1].H.style) & \
														($lineObj.sortedMap[$iterY][$iterX].H.color=$lineObj.sortedMap[$iterY][$iterX-1].H.color)
														$else:=False:C215
														
														$lineObj.sortedMap[$iterY][$iterX].H.lineNum:=$lineObj.sortedMap[$iterY][$iterX-1].H.lineNum
														$lineObj.lines[$lineObj.sortedMap[$iterY][$iterX].H.lineNum].x2:=$colPos->{Int:C8($iterX-$range.x1+2)}
													End if 
												End if 
											End if 
										End if 
									End if 
								End if 
								
								If ($else)
									
									$line.y1:=$rowPos->{Int:C8($iterY-$range.y1+1)}
									$line.y2:=$rowPos->{Int:C8($iterY-$range.y1+1)}
									$line.x1:=$colPos->{Int:C8($iterX-$range.x1+1)}
									$line.x2:=$colPos->{Int:C8($iterX-$range.x1+2)}
									$line.style:=$lineObj.sortedMap[$iterY][$iterX].H.style
									$line.color:=$lineObj.sortedMap[$iterY][$iterX].H.color
									$line.lineNum:=$lineObj.lines.length
									$lineObj.sortedMap[$iterY][$iterX].H.lineNum:=$line.lineNum
									
									$lineObj.lines.push($line)
									
								End if 
								
							End if 
						Else 
							
							If ($lineObj.double=Null:C1517)
								$lineObj.double:=New object:C1471
							End if 
							
							$sIterY:=String:C10($iterY)
							If ($lineObj.double[$sIterY]=Null:C1517)
								$lineObj.double[$sIterY]:=New object:C1471
							End if 
							
							$sIterX:=String:C10($iterX)
							If ($lineObj.double[$sIterY][$sIterX]=Null:C1517)
								$lineObj.double[$sIterY][$sIterX]:=New object:C1471
							End if 
							
							$lineObj.double[$sIterY][$sIterX].hr:=$lineObj.sortedMap[$itery][$iterX].H.color
							$lineObj.double[$sIterY][$sIterX].hrOffset:=$lineObj.sortedMap[$itery][$iterX].H.offset
							$lineObj.double[$sIterY][$sIterX].hrOriented:=$lineObj.sortedMap[$iterY][$iterX].H.isOriented
							
							$lineObj.double[$sIterY][$sIterX].upDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].downDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].leftDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].rightDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DDUpDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DDDownDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DUUpDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DUDownDrawed:=False:C215
							
						End if 
					End if 
					
					If ($lineObj.sortedMap[$iterY][$iterX].V#Null:C1517)
						
						$line:=New object:C1471
						
						If ($lineObj.sortedMap[$itery][$iterX].V.style#6)
							
							If ($lineobj.sortedMap[$iterY][$iterX].V.isOriented)
								
								$line.y1:=$rowPos->{Int:C8($iterY-$range.y1+1)}
								$line.y2:=$rowPos->{Int:C8($iterY-$range.y1+2)}
								$line.x1:=$colPos->{Int:C8($iterX-$range.x1+1)}+$lineObj.sortedMap[$iterY][$iterX].V.offset
								$line.x2:=$colPos->{Int:C8($iterX-$range.x1+1)}
								$line.style:=$lineObj.sortedMap[$iterY][$iterX].V.style
								$line.color:=$lineObj.sortedMap[$iterY][$iterX].V.color
								
								$lineObj.lines.push($line)
								
							Else 
								$else:=True:C214
								If ($iterY>0)
									If (svg_checkColIndex ($lineObj.sortedMap;$iterY-1))
										If (svg_checkColIndex ($lineObj.sortedMap[$iterY-1];$iterX))
											If ($lineObj.sortedMap[$iterY-1][$iterX].V#Null:C1517)
												If (Not:C34($lineObj.sortedMap[$iterY-1][$iterX].V.isOriented))
													If ($lineObj.sortedMap[$iterY][$iterX].V.style=$lineObj.sortedMap[$iterY-1][$iterX].V.style) & \
														($lineObj.sortedMap[$iterY][$iterX].V.color=$lineObj.sortedMap[$iterY-1][$iterX].V.color)
														$else:=False:C215
														
														$lineObj.sortedMap[$iterY][$iterX].V.lineNum:=$lineObj.sortedMap[$iterY-1][$iterX].V.lineNum
														$lineObj.lines[$lineObj.sortedMap[$iterY][$iterX].V.lineNum].y2:=$rowPos->{Int:C8($iterY-$range.y1+2)}
													End if 
												End if 
											End if 
										End if 
									End if 
								End if 
								
								If ($else)
									
									$line.y1:=$rowPos->{Int:C8($iterY-$range.y1+1)}
									$line.y2:=$rowPos->{Int:C8($iterY-$range.y1+2)}
									$line.x1:=$colPos->{Int:C8($iterX-$range.x1+1)}
									$line.x2:=$colPos->{Int:C8($iterX-$range.x1+1)}
									$line.style:=$lineObj.sortedMap[$iterY][$iterX].V.style
									$line.color:=$lineObj.sortedMap[$iterY][$iterX].V.color
									$line.lineNum:=$lineObj.lines.length
									$lineObj.sortedMap[$iterY][$iterX].V.lineNum:=$line.lineNum
									
									$lineObj.lines.push($line)
									
								End if 
								
							End if 
							
						Else 
							
							If ($lineObj.double=Null:C1517)
								$lineObj.double:=New object:C1471
							End if 
							
							$sIterY:=String:C10($iterY)
							If ($lineObj.double[$sIterY]=Null:C1517)
								$lineObj.double[$sIterY]:=New object:C1471
							End if 
							
							$sIterX:=String:C10($iterX)
							If ($lineObj.double[$sIterY][$sIterX]=Null:C1517)
								$lineObj.double[$sIterY][$sIterX]:=New object:C1471
							End if 
							
							$lineObj.double[$sIterY][$sIterX].vb:=$lineObj.sortedMap[$itery][$iterX].V.color
							$lineObj.double[$sIterY][$sIterX].vbOffset:=$lineObj.sortedMap[$itery][$iterX].V.offset
							$lineObj.double[$sIterY][$sIterX].vbOriented:=$lineObj.sortedMap[$iterY][$iterX].V.isOriented
							
							$lineObj.double[$sIterY][$sIterX].upDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].downDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].leftDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].rightDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DDUpDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DDDownDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DUUpDrawed:=False:C215
							$lineObj.double[$sIterY][$sIterX].DUDownDrawed:=False:C215
							
						End if 
						
					End if 
					
				End if 
				
			End for 
			
		End if 
		
	End for 
	
End if 

For each ($line;$lineObj.lines)
	If ($line#Null:C1517)
		If ($line.style#0)
			Case of 
				: ($line.style=13)
					Case of 
						: ($line.y1=$line.y2)
							
							$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scaling-stroke";"shape-rendering";"crispEdges";"x1";$line.x1;"y1";$line.y1-1;"x2";$line.x2;"y2";$line.y2-1;\
								"stroke";$line.color;"stroke-width";1;"stroke-dasharray";"11,1,5,1")
							$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scaling-stroke";"shape-rendering";"crispEdges";"x1";$line.x1;"y1";$line.y1;"x2";$line.x2;"y2";$line.y2;\
								"stroke";$line.color;"stroke-width";1;"stroke-dasharray";"10,2,4,2")
							
						: ($line.x1=$line.x2)
							
							$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scalling-stroke";"shape-rendering";"crispEdges";"x1";$line.x1-1;"y1";$line.y1;"x2";$line.x2-1;"y2";$line.y2;\
								"stroke";$line.color;"stroke-witdh";1;"stroke-dasharray";"11,1,5,1")
							$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scalling-stroke";"shape-rendering";"crispEdges";"x1";$line.x1;"y1";$line.y1;"x2";$line.x2;"y2";$line.y2;\
								"stroke";$line.color;"stroke-witdh";1;"stroke-dasharray";"10,2,4,2")
							
						Else 
							
							$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scalling-stroke";"x1";$line.x1;"y1";$line.y1;"x2";$line.x2;"y2";$line.y2;\
								"stroke";$line.color;"stroke-witdh";1;"stroke-dasharray";"11,1,5,1")
							$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scalling-stroke";"x1";$line.x1+1;"y1";$line.y1;"x2";$line.x2+1;"y2";$line.y2;\
								"stroke";$line.color;"stroke-witdh";1;"stroke-dasharray";"10,2,4,2")
							
					End case 
				Else 
					Case of 
						: (($line.style=1) | ($line.style=2) | ($line.style=5))
							$dash_array:=" "
						: ($line.style=7)
							$dash_array:="1"
						: ($line.style=3)
							$dash_array:="3,1"
						: ($line.style=8)
							$dash_array:="9,3"
						: ($line.style=4)
							$dash_array:="2,2"
						: (($line.style=11) | ($line.style=12))
							$dash_array:="9,3,3,3,3,3"
						: (($line.style=9) | ($line.style=10))
							$dash_array:="8,2,2,2"
					End case 
					
					If ($line.x1=$line.x2) | ($line.y1=$line.y2)
						$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scalling-stroke";"shape-rendering";"crispEdges";"x1";$line.x1;"y1";$line.y1;"x2";$line.x2;"y2";$line.y2;\
							"stroke";$line.color;"stroke-width";$priorityTable[String:C10($line.style)];"stroke-dasharray";$dash_array)
					Else 
						$elemRef:=DOM Create XML element:C865($svgRef;$xPath;"vector-effect";"non-scalling-stroke";"x1";$line.x1;"y1";$line.y1;"x2";$line.x2;"y2";$line.y2;\
							"stroke";$line.color;"stroke-width";$priorityTable[String:C10($line.style)];"stroke-dasharray";$dash_array)
					End if 
			End case 
		End if 
	End if 
End for each 
