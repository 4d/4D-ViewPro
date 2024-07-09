//%attributes = {"invisible":true}
#DECLARE($workFolder : 4D:C1709.Folder; $distribution : 4D:C1709.Folder; $origin : 4D:C1709.Folder) : Object

// Mark:-Preparing the work folder

var $log : Object:={\
errors: []; \
warnings: []\
}

If (Not:C34($distribution.exists))
	$log.errors.push("distribution "+$distribution.path+" not exists")
	return $log
End if 

If (Not:C34($origin.exists))
	$log.errors.push("origin old version "+$origin.path+" not exists")
	return $log
End if 


If ($workFolder.exists)
	
	$workFolder.delete(Delete with contents:K24:24)
	
End if 

$workFolder.create()

var $old : 4D:C1709.Folder:=$origin.copyTo($workFolder; "SpreadJS old version"; fk overwrite:K87:5)
var $new : 4D:C1709.Folder:=$old.copyTo($workFolder; "SpreadJS new version"; fk overwrite:K87:5)

// Mark:- getting version (from folder name)

var $c : Collection:=Split string:C1554($distribution.fullName; " ")
var $version : Text:=$c.last()
var $posFound; $lengthFound : Integer
If (Match regex:C1019("\\d+(\\.\\d+)+"; $version; 1; $posFound; $lengthFound))
	$version:=Substring:C12($version; $posFound; $lengthFound)
End if 

// Mark:-Copy new files - SpreadJS folder
var $src : 4D:C1709.Folder:=$distribution.folder("SpreadJS")
var $tgt : 4D:C1709.Folder:=$new.folder("SpreadJS")

$tgt.folder("css").delete(Delete with contents:K24:24)
$tgt.folder("definition").delete(Delete with contents:K24:24)
$tgt.folder("scripts").delete(Delete with contents:K24:24)
$tgt.folder("scripts").create()

$src.folder("css").copyTo($tgt)
$src.folder("definition").copyTo($tgt)

var $t : Text
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
var $file : 4D:C1709.File
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

return $log