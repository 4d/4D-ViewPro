//%attributes = {"invisible":true,"preemptive":"capable"}
C_POINTER:C301($1)
C_PICTURE:C286($0;$pict)
C_TEXT:C284($Txt_pict)

$Txt_pict:=$1->

If (Length:C16($Txt_pict)>22)
	C_TEXT:C284($codec)
	
	Case of 
		: (Position:C15("data:image/png;base64,";$Txt_pict)=1)
			$codec:=".png"
		: (Position:C15("data:image/jpg;base64,";$Txt_pict)=1)
			$codec:=".jpg"
		: (Position:C15("data:image/jpeg;base64,";$Txt_pict)=1)
			$codec:=".jpeg"
		: (Position:C15("data:image/gif;base64,";$Txt_pict)=1)
			$codec:=".gif"
	End case 
	
	If ($codec#"")
		C_BLOB:C604($Blb_buffer)
		C_PICTURE:C286($pict)
		
		$Txt_pict:=Substring:C12($Txt_pict;23)
		
		BASE64 DECODE:C896($Txt_pict;$Blb_buffer)
		BLOB TO PICTURE:C682($Blb_buffer;$pict;$codec)
		CLEAR VARIABLE:C89($Blb_buffer)
		
		$0:=$pict
		
	End if 
End if 