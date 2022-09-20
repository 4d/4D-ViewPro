//%attributes = {"invisible":true}
  // creates a picture from an uri created with vp_make_picture

C_OBJECT:C1216($1)
C_TEXT:C284($2)

C_OBJECT:C1216($obj)
C_TEXT:C284($attributeName)

$obj:=$1
$attributeName:=$2

If (Value type:C1509($obj[$attributeName])=Is text:K8:3)
	C_TEXT:C284($Txt_pict)
	$Txt_pict:=$obj[$attributeName]
	If (Length:C16($Txt_pict)>22)
		C_TEXT:C284($mime;$codec)
		$mime:=Substring:C12($Txt_pict;1;22)
		
		Case of 
			: ($mime="data:image/png;base64,")
				$codec:=".png"
			: ($mime="data:image/jpg;base64,")
				$codec:=".jpg"
			: ($mime="data:image/gif;base64,")
				$codec:=".gif"
		End case 
		
		If ($codec#"")
			C_BLOB:C604($Blb_buffer)
			C_PICTURE:C286($pict)
			
			$Txt_pict:=Substring:C12($Txt_pict;23)
			
			BASE64 DECODE:C896($Txt_pict;$Blb_buffer)
			BLOB TO PICTURE:C682($Blb_buffer;$pict;$codec)
			CLEAR VARIABLE:C89($Blb_buffer)
			
			$obj[$attributeName]:=$pict
			
		End if 
	End if 
End if 
