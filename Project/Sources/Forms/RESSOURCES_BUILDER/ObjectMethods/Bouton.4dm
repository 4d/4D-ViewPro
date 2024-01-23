var $name : Text
var $file : 4D:C1709.File

$name:=Select document:C905(8858; "html"; "Select \"index.html\" in < Designer Component/samples/purejs > folder"; 0)

If (OK=1)
	
	$file:=File:C1566(DOCUMENT; fk platform path:K87:2)
	vposixPath:=Replace string:C233("file:///"+$file.path; " "; "%20")
	
End if 