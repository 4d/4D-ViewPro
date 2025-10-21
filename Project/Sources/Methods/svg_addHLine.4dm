//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($lineObj : Object; $iterX : Integer; $iterY : Integer; $topBorderStyle : Integer; $topBorderColor : Text)

var $sIterY; $sIterX : Text

$sIterY:=String:C10($iterY)
$sIterX:=String:C10($iterX)

If ($topBorderStyle=6)
	
	If ($lineObj.double=Null:C1517)
		$lineObj.double:=New object:C1471
	End if 
	
	If ($lineObj.double[$sIterY]=Null:C1517)
		$lineObj.double[$sIterY]:=New object:C1471
	End if 
	
	If ($lineObj.double[$sIterY][$sIterX]=Null:C1517)
		$lineObj.double[$sIterY][$sIterX]:=New object:C1471
	End if 
	
	$lineObj.double[$sIterY][$sIterX].hr:=$topBorderColor
	$lineObj.double[$sIterY][$sIterX].upDrawed:=False:C215
	$lineObj.double[$sIterY][$sIterX].downDrawed:=False:C215
	$lineObj.double[$sIterY][$sIterX].leftDrawed:=False:C215
	$lineObj.double[$sIterY][$sIterX].rightDrawed:=False:C215
	$lineObj.double[$sIterY][$sIterX].DDUpDrawed:=False:C215
	$lineObj.double[$sIterY][$sIterX].DDDownDrawed:=False:C215
	$lineObj.double[$sIterY][$sIterX].DUUpDrawed:=False:C215
	$lineObj.double[$sIterY][$sIterX].DUDownDrawed:=False:C215
	
	If ($lineObj.H[$sIterX+";"+$sIterY]#Null:C1517)
		$lineObj.H[$sIterX+";"+$sIterY]:=Null:C1517
	End if 
End if 


If ($topBorderStyle>0) & ($topBorderStyle<=13)
	
	If ($lineObj.H[$sIterX+";"+$sIterY]=Null:C1517)
		$lineObj.H[$sIterX+";"+$sIterY]:=New object:C1471
		$lineObj.H[$sIterX+";"+$sIterY].styleCol:=String:C10($topBorderStyle)+";"+$topBorderColor
		$lineObj.H[$sIterX+";"+$sIterY].style:=$topBorderStyle
		$lineObj.H[$sIterX+";"+$sIterY].color:=$topBorderColor
		
	Else 
		If (Not:C34(svg_hasBorderPriority($lineObj.H[$sIterX+";"+$sIterY].style; $topBorderStyle)))
			$lineObj.H[$sIterX+";"+$sIterY].styleCol:=String:C10($topBorderStyle)+";"+$topBorderColor
			$lineObj.H[$sIterX+";"+$sIterY].style:=$topBorderStyle
			$lineObj.H[$sIterX+";"+$sIterY].color:=$topBorderColor
			
		End if 
	End if 
	
End if 

