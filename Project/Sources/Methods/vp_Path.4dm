//%attributes = {"invisible":true}
/*
path := ***vp_Path*** ( path ; Param_2 )
-> path (Text)
-> Param_2 (Text)
<- path (Object)
________________________________________________________
*/
#DECLARE($path : Text; $extension : Text)->$pathObject : Object

var $isOK : Boolean

// ----------------------------------------------------
// Initialisations
var $nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=1; "Missing parameter"))
	
	ARRAY TEXT:C222($extensionsArray; 4)
	$extensionsArray{1}:=".4vp"
	$extensionsArray{2}:=".xlsx"
	$extensionsArray{3}:=".pdf"
	$extensionsArray{4}:=".csv"
	
	// Optional parameters
	If ($nbParameters>=2)
		
		If (Length:C16($extension)>0)
			
			$extensionsArray{1}:=$extension  // Optional, default is ".4vp"
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$pathObject:=Path to object:C1547($path)

If (Length:C16($pathObject.name)>0)
	
	If ((Length:C16($pathObject.extension)=0) & ($extension#".csv"))
		
		$pathObject.extension:=$extensionsArray{1}
		
	End if 
	
	If (Length:C16($pathObject.parentFolder)=0)
		
		// Save the document near the 4D structure file
		$pathObject.parentFolder:=Get 4D folder:C485(Database folder:K5:14; *)
		
	Else 
		
		// Verify pathname validity
		$isOK:=(Test path name:C476($pathObject.parentFolder)=Is a folder:K24:2)
		
		If (Test path name:C476($pathObject.parentFolder)#Is a folder:K24:2)
			
			// Folder "{name}" not found ({path}).
			err_THROW({component: "xbox"; code: 650; name: Path to object:C1547($pathObject.parentFolder).name; path: $pathObject.parentFolder})
			
			$pathObject:=New object:C1471
			
		End if 
	End if 
End if 
