//%attributes = {"invisible":true}
C_OBJECT:C1216($1)

C_TEXT:C284($Txt_key)
C_OBJECT:C1216(err)

// ----------------------------------------------------
If (Count parameters:C259=0)  // Catching
	
	err.count:=Num:C11(err.count)+1
	
	_4D THROW ERROR:C1520
	
Else   // Populate
	
	If (Not:C34(OB Is empty:C1297(err)))
		
		For each ($Txt_key; $1)
			
			err[$Txt_key]:=$1[$Txt_key]
			
		End for each 
	End if 
End if 
