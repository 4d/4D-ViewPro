//%attributes = {"invisible":true}
#DECLARE($rect : Object; $maxWidth : Integer; $maxHeight : Integer)

// ==== left
If ($rect.left>$maxWidth)
	$rect.left:=$maxWidth
End if 

If ($rect.left<1)
	$rect.left:=1
End if 

// ==== right
If ($rect.right#2147483647)
	If ($rect.right>$maxWidth)
		$rect.right:=$maxWidth
	End if 
End if 

If ($rect.right<1)
	$rect.right:=1
End if 

// ==== top
If ($rect.top>$maxHeight)
	$rect.top:=$maxHeight
End if 

If ($rect.top<1)
	$rect.top:=1
End if 

// ==== bottom
If ($rect.bottom#2147483647)
	If ($rect.bottom>$maxHeight)
		$rect.bottom:=$maxHeight
	End if 
End if 

If ($rect.bottom<1)
	$rect.bottom:=1
End if 
