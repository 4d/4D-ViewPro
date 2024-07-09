
var $workFolder : 4D:C1709.Folder:=Folder:C1567(fk desktop folder:K87:19).folder("SJS_WORK_Folder")

// Mark:-requesting folder

$platformPath:=Select folder:C670("Select the folder containing the new version sent by GrapeCity"; ""; Use sheet window:K24:11)

If (OK=0)
	
	return 
	
End if 


OBJECT SET VALUE:C1742("status"; "Copy distribution to working folder")

var $distribution : 4D:C1709.Folder:=Folder:C1567($platformPath; fk platform path:K87:2).copyTo($workFolder; fk overwrite:K87:5)

OBJECT SET VALUE:C1742("distribution"; $distribution.path)


var $platformPath : Text:=Select folder:C670("Select the current \"/4eDimension/ThirdParty/SpreadJS\" folder"; ""; Use sheet window:K24:11)

If (OK=0)
	
	return 
	
End if 

OBJECT SET VALUE:C1742("status"; "Preparing old and new folders")


var $log:=_preparationUpgrade($workFolder; $distribution; Folder:C1567($platformPath; fk platform path:K87:2))


// Mark:-Resume
var $t : Text
If ($log.errors.length>0)\
 | ($log.warnings.length>0)
	
	If ($log.errors.length>0)
		
		$t:="ERRORS:\r  - "
		$t+=$log.errors.join("\r  - ")
		$t+="\r\r"
		
	Else 
		
		$t:=""
		
	End if 
	
	If ($log.warnings.length>0)
		
		$t+="WARNINGS:\r  - "
		$t+=$log.warnings.join("\r  - ")
		$t+="\r"
		
	End if 
	
	$workFolder.file("newVersion.log").setText($t)
	
	//OPEN URL($workFolder.file("newVersion.log").platformPath)
	
	OBJECT SET VALUE:C1742("log"; $t)
	
Else 
	
	OBJECT SET VALUE:C1742("log"; "All this was done without error nor warning :-)")
	
End if 

Form:C1466.workFolder:=$workFolder
Form:C1466.log:=$workFolder.file("newVersion.log")

OBJECT SET VALUE:C1742("status"; "")

BEEP:C151