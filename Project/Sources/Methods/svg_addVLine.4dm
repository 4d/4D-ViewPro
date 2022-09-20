//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1; $lineObj)
C_LONGINT:C283($2; $3; $iterX; $iterY)
C_LONGINT:C283($4; $leftBorderStyle)
C_TEXT:C284($5; $leftBorderColor)

$lineObj:=$1
$iterX:=$2
$iterY:=$3
$leftBorderStyle:=$4
$leftBorderColor:=$5

C_TEXT:C284($sIterx; $sIterY)

$sIterX:=String:C10($iterX)
$sIterY:=String:C10($iterY)

If ($leftBorderStyle=6) | ($leftBorderStyle=0)
	
	If ($lineObj.double=Null:C1517)
		$lineObj.double:=New object:C1471
	End if 
	
	If ($lineObj.double[$sIterY]=Null:C1517)
		$lineObj.double[$sIterY]:=New object:C1471
	End if 
	
	If ($lineObj.double[$sIterY][$sIterX]=Null:C1517)
		$lineObj.double[$sIterY][$sIterX]:=New object:C1471
	End if 
	
	If ($leftBorderStyle=0)
		$lineObj.double[$sIterY][$sIterX].vb:=EMPTY_STRING
	End if 
	If ($leftBorderStyle=6) & ($lineObj.double[$sIterY][$sIterX].vb=Null:C1517)
		$lineObj.double[$sIterY][$sIterX].vb:=$leftBorderColor
		$lineObj.double[$sIterY][$sIterX].upDrawed:=False:C215
		$lineObj.double[$sIterY][$sIterX].downDrawed:=False:C215
		$lineObj.double[$sIterY][$sIterX].leftDrawed:=False:C215
		$lineObj.double[$sIterY][$sIterX].rightDrawed:=False:C215
		$lineObj.double[$sIterY][$sIterX].DDUpDrawed:=False:C215
		$lineObj.double[$sIterY][$sIterX].DDDownDrawed:=False:C215
		$lineObj.double[$sIterY][$sIterX].DUUpDrawed:=False:C215
		$lineObj.double[$sIterY][$sIterX].DUDownDrawed:=False:C215
	End if 
	
	If ($lineObj.V[$sIterX+";"+$sIterY]#Null:C1517)
		$lineObj.V[$sIterX+";"+$sIterY]:=Null:C1517
	End if 
End if 

If ($leftBorderStyle>=0) & ($leftBorderStyle<=13)
	
	If ($lineObj.V[$sIterX+";"+$sIterY]#Null:C1517)
		Case of 
			: ($leftBorderStyle=0)
				$lineObj.V[$sIterX+";"+$sIterY]:=Null:C1517
				
			: (Not:C34(svg_hasBorderPriority($lineObj.V[$sIterX+";"+$sIterY].style; $leftBorderStyle)))
				$lineObj.V[$sIterX+";"+$sIterY].styleCol:=String:C10($leftBorderStyle)+";"+$leftBorderColor
				$lineObj.V[$sIterX+";"+$sIterY].style:=$leftBorderStyle
				$lineObj.V[$sIterX+";"+$sIterY].color:=$leftBorderColor
				
		End case 
		
	Else 
		
		$lineObj.V[$sIterX+";"+$sIterY]:=New object:C1471
		$lineObj.V[$sIterX+";"+$sIterY].styleCol:=String:C10($leftBorderStyle)+";"+$leftBorderColor
		$lineObj.V[$sIterX+";"+$sIterY].style:=$leftBorderStyle
		$lineObj.V[$sIterX+";"+$sIterY].color:=$leftBorderColor
		
	End if 
	
End if 
