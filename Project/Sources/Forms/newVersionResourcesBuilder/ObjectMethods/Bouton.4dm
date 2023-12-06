C_TEXT:C284($selected)
C_OBJECT:C1216($file)
$selected:=Select document:C905(""; "html"; "Select index.html in Designer Component/samples/purejs folder"; 0)
If (ok=1)
	$file:=File:C1566(document; fk platform path:K87:2)
	vposixPath:=$file.path
	vposixPath:="file:///"+vPosixPath
	vposixPath:=Replace string:C233(vPosixPath; " "; "%20")
End if 
