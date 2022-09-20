//%attributes = {"invisible":true}
C_LONGINT:C283($index; $n; $1)
$index:=$1

C_LONGINT:C283($code)
$code:=Character code:C91("A")
C_TEXT:C284($sb)

While ($index>0)
	$n:=Mod:C98($index-1; 26)
	$sb:=Char:C90($code+$n)+$sb
	$index:=$index\26
End while 

$0:=$sb
