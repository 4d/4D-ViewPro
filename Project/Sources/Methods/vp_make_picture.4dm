//%attributes = {"invisible":true}
// receives an attribute that can be either a pict or a path to a picture file
// sets the attribute to a text with an uri with the picture embedded
// if we receive already an uri does nothing
#DECLARE($obj : Object; $attributeName : Text)


var $pict : Picture
ok:=0

If (Value type:C1509($obj[$attributeName])=Is picture:K8:10)
	$pict:=$obj[$attributeName]
	ok:=1
Else 
	var $filePath : Text
	If (Value type:C1509($obj[$attributeName])=Is object:K8:27)
		If ($obj[$attributeName].isFile)
			$filePath:=$obj[$attributeName].platformPath
		End if 
	End if 
	If (Value type:C1509($obj[$attributeName])=Is text:K8:3)
		$filePath:=$obj[$attributeName]
	End if 
	
	If (($filePath#"") & ($filePath#"data:image/@"))
		READ PICTURE FILE:C678($filePath; $pict)
		If (ok=0)
			READ PICTURE FILE:C678(Get 4D folder:C485(Database folder:K5:14; *)+$filePath; $pict)
		End if 
		If (ok=0)
			READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16; *)+$filePath; $pict)
		End if 
	End if 
End if 

If (ok=1)
	ARRAY TEXT:C222($codecs; 0)
	ARRAY TEXT:C222($prefered_codecs_order; 0)
	APPEND TO ARRAY:C911($prefered_codecs_order; ".png")
	APPEND TO ARRAY:C911($prefered_codecs_order; ".jpg")
	APPEND TO ARRAY:C911($prefered_codecs_order; ".gif")
	
	GET PICTURE FORMATS:C1406($pict; $codecs)
	
	var $codec : Text
	var $wanted_codec; $Lon_i : Integer
	$Lon_i:=1
	
	While (($Lon_i<=Size of array:C274($prefered_codecs_order)) & ($codec=""))
		$wanted_codec:=Find in array:C230($codecs; $prefered_codecs_order{$Lon_i})
		If ($wanted_codec#-1)
			$codec:=$prefered_codecs_order{$Lon_i}
		End if 
		$Lon_i:=$Lon_i+1
	End while 
	
	If ($codec="")
		$codec:=".png"
	End if 
	
	var $Blb_buffer : Blob
	var $Txt_image : Text
	
	PICTURE TO BLOB:C692($pict; $Blb_buffer; $codec)
	BASE64 ENCODE:C895($Blb_buffer; $Txt_image)
	CLEAR VARIABLE:C89($Blb_buffer)
	
	$obj[$attributeName]:="data:image/"+Delete string:C232($codec; 1; 1)+";base64,"+$Txt_image
	
End if 

