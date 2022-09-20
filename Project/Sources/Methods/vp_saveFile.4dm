//%attributes = {"invisible":true}
C_TEXT:C284($1; $2)
C_BOOLEAN:C305($3)
C_TEXT:C284($content; $fileName)
C_OBJECT:C1216($0)
C_BOOLEAN:C305($allowAllFiles)

$0:=New object:C1471("status"; "failed")

$content:=$1
$fileName:=$2
$allowAllFiles:=$3

If (Length:C16($content)>0)
	C_BLOB:C604($blob)
	
	BASE64 DECODE:C896($content; $blob)
	
	If (BLOB size:C605($blob)>0)
		
		C_TEXT:C284($selectedName)
		C_OBJECT:C1216($object_path)
		
		$object_path:=Path to object:C1547($fileName)
		
		C_TEXT:C284($ext)
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