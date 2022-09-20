//%attributes = {"invisible":true,"shared":true,"preemptive":"capable"}
C_TEXT:C284($1)
C_OBJECT:C1216($0)

C_OBJECT:C1216($obj)
C_TEXT:C284($Txt_font)
$Txt_font:=$1

$obj:=New object:C1471()

C_COLLECTION:C1488($elements)

$elements:=Split string:C1554($Txt_font; " "; sk ignore empty strings:K86:1+sk trim spaces:K86:2)

C_LONGINT:C283($i)
C_TEXT:C284($element)
C_BOOLEAN:C305($parseSize; $parseName)
$parseSize:=False:C215
$parseName:=False:C215

$obj.family:=""

For ($i; 0; $elements.length-1)
	$element:=$elements[$i]
	
	If (Not:C34($parseSize))
		// parsing weight or style
		
		If (($element="normal") | ($element="initial") | ($element="inherit"))
			// nothing
		Else 
			If ($element="small-caps")
				$obj.variant:=$element
			Else 
				If (($element="oblique") | ($element="italic"))
					$obj.style:=$element
				Else 
					If (($element="lighter") | \
						($element="bold") | \
						($element="bolder") | \
						($element="100") | \
						($element="200") | \
						($element="300") | \
						($element="400") | \
						($element="500") | \
						($element="600") | \
						($element="700") | \
						($element="800") | \
						($element="900"))
						$obj.weight:=$element
					Else 
						$parseSize:=True:C214
					End if 
				End if 
			End if 
		End if 
	End if 
	
	If ($parseName)
		$obj.family:=$obj.family+$element
		If ($i<($elements.length-1))
			$obj.family:=$obj.family+" "
		End if 
	Else 
		If ($parseSize)
			$obj.size:=$element
			$parseName:=True:C214
		End if 
	End if 
	
End for 

C_TEXT:C284($family)
$family:=$obj.family
If (Length:C16($family)>2)
	If (($family[[1]]="\"") | \
		($family[[1]]="'"))
		$family:=Substring:C12($family; 2)
	End if 
	If (($family[[Length:C16($family)]]="\"") | \
		($family[[Length:C16($family)]]="'"))
		$family:=Substring:C12($family; 1; Length:C16($family)-1)
	End if 
End if 

C_LONGINT:C283($hasComma)
$hasComma:=Position:C15(","; $family)
If ($hasComma>0)
	$family:=Substring:C12($family; 1; $hasComma-1)
End if 
$obj.family:=$family

$0:=$obj
