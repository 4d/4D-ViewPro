//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1; $padStr)
C_OBJECT:C1216($2; $cellPadding)
C_LONGINT:C283($i; $j)
var $count : Integer

$padStr:=$1
$cellPadding:=$2

$i:=1
$j:=0

$cellPadding.top:=""
$cellPadding.right:=""
$cellPadding.bottom:=""
$cellPadding.left:=""

$count:=Split string:C1554($padStr; " ").count()

If ($count=1)
	$cellPadding.top:=$padStr
	$cellPadding.left:=$padStr
	$cellPadding.right:=$padStr
	$cellPadding.bottom:=$padStr
Else 
	For ($i; 1; Length:C16($padStr))
		
		Case of 
			: ($padStr[[$i]]=" ")
				$j:=$j+1
			: ($j=0)
				$cellPadding.top:=$cellPadding.top+$padStr[[$i]]
			: ($j=1)
				$cellPadding.right:=$cellPadding.right+$padStr[[$i]]
			: ($j=2)
				$cellPadding.bottom:=$cellPadding.bottom+$padStr[[$i]]
			: ($j=3)
				$cellPadding.left:=$cellPadding.left+$padStr[[$i]]
		End case 
	End for 
End if 