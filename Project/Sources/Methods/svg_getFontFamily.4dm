//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Collection
var $colFont : Collection
var $2 : Integer
var $indexFont : Integer
var $0 : Text
var $strFont : Text
var $i : Integer
var $pos : Integer
var $replace : Boolean
$colFont:=$1
$indexFont:=$2

For ($i;$indexFont+1;$colFont.length-1)
	$strFont:=$strFont+$colFont[$i]+" "
End for 

$replace:=True:C214
While ($replace)
	$pos:=Position:C15("\"";$strFont)
	If ($pos=0)
		$replace:=False:C215
	Else 
		$strFont:=Change string:C234($strFont;"'";$pos)
	End if 
End while 
$0:=$strFont