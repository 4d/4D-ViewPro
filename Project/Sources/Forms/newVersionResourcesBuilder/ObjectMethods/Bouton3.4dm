
var $path:=Select folder:C670("select designer.custom folder")

If (ok=1)
	
	_buildLocalizationResources(Folder:C1567($path; fk platform path:K87:2); "Zone Web"; ".new")
	
End if 

ALERT:C41("done")
