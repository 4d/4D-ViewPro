//%attributes = {"invisible":true,"preemptive":"capable"}
var $1 : Pointer
var $0 : Picture
var $Txt_pict : Text
$Txt_pict:=$1->

If (Length:C16($Txt_pict)>22)
	var $codec : Text
	Case of 
		: (Position:C15("data:image/png;base64,"; $Txt_pict)=1)
			$codec:=".png"
		: (Position:C15("data:image/jpg;base64,"; $Txt_pict)=1)
			$codec:=".jpg"
		: (Position:C15("data:image/jpeg;base64,"; $Txt_pict)=1)
			$codec:=".jpeg"
		: (Position:C15("data:image/gif;base64,"; $Txt_pict)=1)
			$codec:=".gif"
	End case 
	
	If ($codec#"")
		var $Blb_buffer : Blob
		var $pict : Picture
		$Txt_pict:=Substring:C12($Txt_pict; 23)
		
		BASE64 DECODE:C896($Txt_pict; $Blb_buffer)
		BLOB TO PICTURE:C682($Blb_buffer; $pict; $codec)
		CLEAR VARIABLE:C89($Blb_buffer)
		
		$0:=$pict
		
	End if 
End if 