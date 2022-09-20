//%attributes = {"invisible":true,"preemptive":"capable"}
C_COLLECTION:C1488($1;$colFont)
C_LONGINT:C283($2;$indexFont)
C_TEXT:C284($0;$strFont)
C_LONGINT:C283($i;$pos)
C_BOOLEAN:C305($replace)

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