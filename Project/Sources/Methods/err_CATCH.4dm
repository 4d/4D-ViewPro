//%attributes = {"invisible":true}
#DECLARE($error : Object)

var $key : Text

If (Count parameters:C259=0)  // Catching
	
	err.count:=Num:C11(err.count)+1
	
	_4D THROW ERROR:C1520
	
Else   // Populate
	
	If (Not:C34(OB Is empty:C1297(err)))
		
		For each ($key; $error)
			
			err[$key]:=$error[$key]
			
		End for each 
	End if 
End if 