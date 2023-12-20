If (Form:C1466.vp.load(Folder:C1567("/RESOURCES/DEV")))
	
	If (Storage:C1525.dev=Null:C1517)
		
		Use (Storage:C1525)
			
			Storage:C1525.dev:=New shared object:C1526
			
		End use 
	End if 
	
	Use (Storage:C1525.dev)
		
		Storage:C1525.dev.doc:=DOCUMENT
		
	End use 
End if 