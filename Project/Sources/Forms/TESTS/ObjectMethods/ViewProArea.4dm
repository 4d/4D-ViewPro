var $e : Object
$e:=FORM Event:C1606

Case of 
		
		//______________________________________________________
	: ($e.code=On VP Ready:K2:59)
		
		If (Storage:C1525.dev.doc#Null:C1517)
			
			Form:C1466.vp.load(File:C1566(Storage:C1525.dev.doc; fk platform path:K87:2))
			
		End if 
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: (False:C215)
		
		
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		
		//______________________________________________________
End case 