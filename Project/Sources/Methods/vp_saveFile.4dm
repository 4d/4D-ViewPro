//%attributes = {"invisible":true}
#DECLARE($content : Text; $fileName : Text; $allowAllFiles : Boolean)

var $out:=New object:C1471("status"; "failed")

If (Length:C16($content)>0)
	var $blob : Blob
	
	BASE64 DECODE:C896($content; $blob)
	
	If (BLOB size:C605($blob)>0)
		
		
		var $object_path:=Path to object:C1547($fileName)
		
		var $ext : Text:=$object_path.extension
		
		If ($allowAllFiles)
			$ext:="*"
		End if 
		
		var $selectedName : Text:=Select document:C905(System folder:C487(Documents folder:K41:18)+$fileName; $ext; ""; File name entry:K24:17)
		
		If (Length:C16($selectedName)>0)
			
			BLOB TO DOCUMENT:C526(document; $blob)
			
			If (ok=1)
				
				$out.status:="success"
				$out.fileName:=$selectedName
				
			End if 
		End if 
		
	End if 
	
End if 

return $out