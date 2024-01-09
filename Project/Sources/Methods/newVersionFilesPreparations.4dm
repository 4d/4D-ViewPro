//%attributes = {}
var $platformPath; $t; $version : Text
var $log : Object
var $c : Collection
var $file : 4D:C1709.File
var $distribution; $new; $old; $src; $tgt; $workFolder : 4D:C1709.Folder

$log:={\
errors: []; \
warnings: []\
}


// Mark:-Preparing the work folder
$workFolder:=Folder:C1567(fk desktop folder:K87:19).folder("SJS_WORK_Folder")

If ($workFolder.exists)
	
	$workFolder.delete(Delete with contents:K24:24)
	
End if 

$workFolder.create()

$platformPath:=Select folder:C670("Select the folder containing the new version sent by GrapeCity"; ""; Use sheet window:K24:11)

If (OK=0)
	
	return 
	
End if 

MESSAGE:C88("Copy distribution to working folder")

$distribution:=Folder:C1567($platformPath; fk platform path:K87:2).copyTo($workFolder; fk overwrite:K87:5)

$c:=Split string:C1554($distribution.fullName; " ")
$version:=$c.last()

$platformPath:=Select folder:C670("Select the current \"/4eDimension/ThirdParty/SpreadJS\" folder"; ""; Use sheet window:K24:11)

If (OK=0)
	
	return 
	
End if 

MESSAGE:C88("Preparing old and new folders")

$old:=Folder:C1567($platformPath; fk platform path:K87:2).copyTo($workFolder; "SpreadJS old version"; fk overwrite:K87:5)
$new:=$old.copyTo($workFolder; "SpreadJS new version"; fk overwrite:K87:5)


// Mark:-Copy new files - SpreadJS folder
$src:=$distribution.folder("SpreadJS")

$tgt:=$new.folder("SpreadJS")

$tgt.folder("css").delete(Delete with contents:K24:24)
$tgt.folder("definition").delete(Delete with contents:K24:24)
$tgt.folder("scripts").delete(Delete with contents:K24:24)
$tgt.folder("scripts").create()

$src.folder("css").copyTo($tgt)
$src.folder("definition").copyTo($tgt)

For each ($t; [\
"scripts/gc.spread.sheets.all."+$version+".js"; \
"scripts/gc.spread.sheets.all."+$version+".min.js"\
])
	
	If ($src.file($t).exists)
		
		$src.file($t).copyTo($tgt.folder("scripts"); fk overwrite:K87:5)
		
	Else 
		
		$log.errors.push("Missing file: /"+Replace string:C233($src.file($t).path; $workFolder.path; ""))
		
	End if 
End for each 

$tgt.folder("scripts/interop").create()

For each ($t; [\
"scripts/interop/gc.spread.excelio."+$version+".js"; \
"scripts/interop/gc.spread.excelio."+$version+".min.js"\
])
	
	If ($src.file($t).exists)
		
		$src.file($t).copyTo($tgt.folder("scripts/interop"); fk overwrite:K87:5)
		
	Else 
		
		$log.errors.push("Missing file: /"+Replace string:C233($src.file($t).path; $workFolder.path; ""))
		
	End if 
End for each 

$src.folder("scripts/plugins").copyTo($tgt.folder("scripts"))
$src.folder("scripts/resources").copyTo($tgt.folder("scripts"))

$src.file("LICENSE").copyTo($tgt; fk overwrite:K87:5)
$src.file("SPREADJS-EULA.pdf").copyTo($tgt; fk overwrite:K87:5)


// Mark:-Copy new files - Designer folder
$src:=$distribution.folder("Designer/Designer Component")
$tgt:=$new.folder("Designer")

$tgt.folder("css").delete(Delete with contents:K24:24)
$tgt.folder("definition").delete(Delete with contents:K24:24)
$tgt.folder("samples/purejs").delete(Delete with contents:K24:24)
$tgt.folder("scripts").delete(Delete with contents:K24:24)

$src.folder("css").copyTo($tgt)
$src.folder("definition").copyTo($tgt)
$src.folder("scripts").copyTo($tgt)

$tgt.folder("samples/purejs").create()

For each ($t; [\
"samples/purejs/custom.css"; \
"samples/purejs/index.html"; \
"samples/purejs/welcome.png"\
])
	
	If ($src.file($t).exists)
		
		$src.file($t).copyTo($tgt.folder("samples/purejs"); fk overwrite:K87:5)
		
	Else 
		
		$log.errors.push("Missing file: /"+Replace string:C233($src.file($t).path; $workFolder.path; ""))
		
	End if 
End for each 

$src.file("README.md").copyTo($tgt; fk overwrite:K87:5)


// Mark:-Standardizing file names
For each ($file; $new.files(fk recursive:K87:7).query("fullName = :1"; "@"+$version+"@"))
	
	$file.rename(Replace string:C233($file.name; "."+$version; "")+$file.extension)
	
End for each 


//mark:-Prepare designer.all
$file:=$new.file("Designer/scripts/gc.spread.sheets.designer.all.js")

If ($file.exists)
	
	$file.copyTo($new.folder("Designer.Designer Component/scripts"); fk overwrite:K87:5)
	
Else 
	
	$log.errors.push("Missing file: /"+Replace string:C233($file.path; $workFolder.path; ""))
	
End if 


// Mark:-Compare with old repo

$c:=$old.files(fk recursive:K87:7)

For each ($file; $new.files(fk recursive:K87:7+fk ignore invisible:K87:22))
	
	If ($c.query("path = :1"; Replace string:C233($file.path; "SpreadJS new version"; "SpreadJS old version")).length=1)
		
		continue
		
	End if 
	
	$log.warnings.push("File added: "+Replace string:C233($file.path; $workFolder.path+"SpreadJS new version"; ""))
	
End for each 

$c:=$new.files(fk recursive:K87:7)

For each ($file; $old.files(fk recursive:K87:7+fk ignore invisible:K87:22))
	
	If ($c.query("path = :1"; Replace string:C233($file.path; "SpreadJS old version"; "SpreadJS new version")).length=1)
		
		continue
		
	End if 
	
	$log.warnings.push("File removed: "+Replace string:C233($file.path; $workFolder.path+"SpreadJS old version"; ""))
	
End for each 

// Mark:-Resume

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
	
	OPEN URL:C673($workFolder.file("newVersion.log").platformPath)
	
End if 

BEEP:C151