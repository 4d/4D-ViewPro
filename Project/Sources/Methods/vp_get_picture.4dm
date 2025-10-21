//%attributes = {"invisible":true}
// creates a picture from an uri created with vp_make_picture
#DECLARE($obj : Object; $attributeName : Text)


If (Value type:C1509($obj[$attributeName])=Is text:K8:3)
	var $Txt_pict : Text
	$Txt_pict:=$obj[$attributeName]
	If (Length:C16($Txt_pict)>22)
		var $mime; $codec : Text
		$mime:=Substring:C12($Txt_pict; 1; 22)
		
		Case of 
			: ($mime="data:image/png;base64,")
				$codec:=".png"
			: ($mime="data:image/jpg;base64,")
				$codec:=".jpg"
			: ($mime="data:image/gif;base64,")
				$codec:=".gif"
		End case 
		
		If ($codec#"")
			var $Blb_buffer : Blob
			var $pict : Picture
			
			$Txt_pict:=Substring:C12($Txt_pict; 23)
			
			BASE64 DECODE:C896($Txt_pict; $Blb_buffer)
			BLOB TO PICTURE:C682($Blb_buffer; $pict; $codec)
			CLEAR VARIABLE:C89($Blb_buffer)
			
			$obj[$attributeName]:=$pict
			
		End if 
	End if 
End if 
