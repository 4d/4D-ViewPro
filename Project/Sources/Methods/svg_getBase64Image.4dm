//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$URI)
C_TEXT:C284($0)
C_PICTURE:C286($pict)
C_BLOB:C604($blobImage)
C_LONGINT:C283($statut)

$URI:=$1

$statut:=0

Case of 
	: (Position:C15("file://";$URI)>0)
		
		READ PICTURE FILE:C678(Replace string:C233($URI;"file://";"");$pict)
		
		If (Picture size:C356($pict)>0)
			$statut:=1
		End if 
	: (Position:C15("http://";$URI)>0) | (Position:C15("https://";$URI)>0)
		
		$statut:=HTTP Get:C1157($URI;$blobImage)
		
	Else 
		$0:=$URI
End case 

If (Bool:C1537($statut))
	Case of 
		: (Position:C15(".png";$URI)>0)
			PICTURE TO BLOB:C692($pict;$blobImage;"image/png")
			BASE64 ENCODE:C895($blobImage;$0)
			$0:="data:image/png;base64,"+$0
			
		: (Position:C15(".gif";$URI)>0)
			PICTURE TO BLOB:C692($pict;$blobImage;"image/gif")
			BASE64 ENCODE:C895($blobImage;$0)
			$0:="data:image/gif;base64,"+$0
			
		: (Position:C15(".jpg";$URI)>0)
			PICTURE TO BLOB:C692($pict;$blobImage;"image/jpg")
			BASE64 ENCODE:C895($blobImage;$0)
			$0:="data:image/jpg;base64,"+$0
			
	End case 
End if 