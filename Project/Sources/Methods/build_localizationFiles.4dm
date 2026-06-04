//%attributes = {}
var $respath : Text
var $fileName : Text
var $cmd : Text
var $cmdName : Text
var $countryCode : Text
var $dom : Text
var $group : Text
var $transunit_cmd : Text
var $transunit_desc : Text
var $target : Text
var $val : Text
var $i : Integer
var $j : Integer
var $nb : Integer
$respath:=Get 4D folder:C485(Current resources folder:K5:16)

ARRAY TEXT:C222($folders;0)
FOLDER LIST:C473($respath;$folders)

For ($i;1;Size of array:C274($folders))
	If ($folders{$i}="@.lproj")
		
		$countryCode:=Uppercase:C13(Substring:C12($folders{$i};1;2))
		$fileName:=$respath+$folders{$i}+Folder separator:K24:12+"4DSyntaxVP"+$countryCode+".xlf"
		
		$dom:=DOM Parse XML source:C719($fileName)
		
		$group:=DOM Find XML element:C864($dom;"xliff/file/body/group")
		
		$nb:=DOM Count XML elements:C726($group;"trans-unit")
		
		For ($j;1;$nb;2)
			$transunit_cmd:=DOM Get XML element:C725($group;"trans-unit";$j;$val)
			$target:=DOM Get XML element:C725($transunit_cmd;"target";1;$cmd)
			
			$cmdName:=Substring:C12($cmd;1;Position:C15(" (";$cmd)-1)
			
			DOM SET XML ATTRIBUTE:C866($transunit_cmd;"id";$j;"resname";"method_proto_"+$cmdName)
			
			$transunit_desc:=DOM Get XML element:C725($group;"trans-unit";$j+1;$val)
			DOM SET XML ATTRIBUTE:C866($transunit_desc;"id";$j+1;"resname";"method_desc_"+$cmdName)
			
		End for 
		
		DOM EXPORT TO FILE:C862($dom;$fileName)
		DOM CLOSE XML:C722($dom)
		
	End if 
	
End for 