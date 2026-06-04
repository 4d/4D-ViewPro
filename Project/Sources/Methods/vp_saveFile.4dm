//%attributes = {"invisible":true}
var $1 : Text
var $2 : Text
var $3 : Boolean
var $content : Text
var $fileName : Text
var $0 : Object
var $allowAllFiles : Boolean
$0:=New object:C1471("status"; "failed")

$content:=$1
$fileName:=$2
$allowAllFiles:=$3

If (Length:C16($content)>0)
	var $blob : Blob
	BASE64 DECODE:C896($content; $blob)
	
	If (BLOB size:C605($blob)>0)
		
		var $selectedName : Text
		var $object_path : Object
		$object_path:=Path to object:C1547($fileName)
		
		var $ext : Text
		$ext:=$object_path.extension
		
		If ($allowAllFiles)
			$ext:="*"
		End if 
		
		$selectedName:=Select document:C905(System folder:C487(Documents folder:K41:18)+$fileName; $ext; ""; File name entry:K24:17)
		
		If (Length:C16($selectedName)>0)
			
			BLOB TO DOCUMENT:C526(document; $blob)
			
			If (ok=1)
				
				$0.status:="success"
				$0.fileName:=$selectedName
				
			End if 
		End if 
		
	End if 
	
End if 