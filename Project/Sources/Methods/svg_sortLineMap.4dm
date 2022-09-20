//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($lineObj;$1;$range;$2)

C_LONGINT:C283($iterY;$iterX)
C_OBJECT:C1216($mapCell;$sortedMapCell)

$lineObj:=$1
$range:=$2

If ($lineObj.map#Null:C1517)
	If ($lineObj.sortedMap=Null:C1517)
		$lineObj.sortedMap:=New collection:C1472
	End if 
	
	
	For ($iterY;$range.y1;$range.y2)
		
		If (svg_checkColIndex ($lineObj.map;$iterY))
			
			For ($iterX;$range.x1;$range.x2)
				
				If (svg_checkColIndex ($lineObj.map[$iterY];$iterx))
					
					If (svg_checkColIndex ($lineObj.map[$iterY][$iterX];BORDER_TOP))
						
						$mapCell:=$lineObj.map[$iterY][$iterX][BORDER_TOP]
						$sortedMapCell:=svg_getSortedMapCell ($lineObj.sortedMap;$iterY;$iterX)
						
						If ($sortedMapCell.H=Null:C1517)
							
							$sortedMapCell.H:=$mapCell
							
						Else 
							
							If ($mapCell.isOriented)
								
								$sortedMapCell.H:=$mapCell
								
							Else 
								
								If (Not:C34($sortedMapCell.H.isOriented))
									
									If (Not:C34(svg_hasBorderPriority ($sortedMapCell.H.style;$mapCell.style)))
										
										$sortedMapCell.H:=$mapCell
										
									End if 
									
								End if 
								
							End if 
							
						End if 
					End if 
					
					If (svg_checkColIndex ($lineObj.map[$iterY][$iterX];BORDER_LEFT))
						
						$mapCell:=$lineObj.map[$iterY][$iterX][BORDER_LEFT]
						$sortedMapCell:=svg_getSortedMapCell ($lineObj.sortedMap;$iterY;$iterX)
						
						If ($sortedMapCell.V=Null:C1517)
							
							$sortedMapCell.V:=$mapCell
							
						Else 
							
							If ($mapCell.isOriented)
								
								$sortedMapCell.V:=$mapCell
								
							Else 
								
								If (Not:C34($sortedMapCell.V.isOriented))
									
									If (Not:C34(svg_hasBorderPriority ($sortedMapCell.V.style;$mapCell.style)))
										
										$sortedMapCell.V:=$mapCell
										
									End if 
									
								End if 
								
							End if 
							
						End if 
					End if 
					
					If (svg_checkColIndex ($lineObj.map[$iterY][$iterX];BORDER_BOTTOM))
						
						$sortedMapCell:=svg_getSortedMapCell ($lineObj.sortedMap;$iterY+1;$iterX)
						$sortedMapCell.H:=$lineObj.map[$iterY][$iterX][BORDER_BOTTOM]
						$sortedMapCell.H.isOriented:=False:C215
						
					End if 
					
					If (svg_checkColIndex ($lineObj.map[$iterY][$iterX];BORDER_RIGHT))
						
						$sortedMapCell:=svg_getSortedMapCell ($lineObj.sortedMap;$iterY;$iterX+1)
						$sortedMapCell.V:=$lineObj.map[$iterY][$iterX][BORDER_RIGHT]
						
					End if 
					
				End if 
				
			End for 
		End if 
		
	End for 
End if 