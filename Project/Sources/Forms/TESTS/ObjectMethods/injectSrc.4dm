
// simulate copy files of resources
var $platformPath : Text
$platformPath:=Folder:C1567(fk home folder:K87:24).folder("git").folder("4edimension").platformPath  // I know is for me
$platformPath:=Select folder:C670("Select root of main repo"; $platformPath)

If (Length:C16($platformPath)=0)
	return   // cancel 
End if 

var $reverse:=Shift down:C543

var $folder : 4D:C1709.Folder
$folder:=Folder:C1567($platformPath; fk platform path:K87:2)

If (Not:C34($folder.exists))
	return 
End if 

var $copyFileText : Text
var $lang : Text

For each ($lang; New collection:C1472("en"; "fr"))  // will have duplicate copy for not localized files but do not care about...
	
	$copyFileText:=$folder.file("4D/scripts/CF_common.json").getText()
	
	$copyFileText:=Replace string:C233($copyFileText; "${BRANCH_ROOT}/"; $folder.path)
	$copyFileText:=Replace string:C233($copyFileText; "${THIRD_PARTY}"; $folder.path+"ThirdParty")
	$copyFileText:=Replace string:C233($copyFileText; "${TARGET_CONTENTS}/Components/4D ViewPro.4dbase/Resources/"; Folder:C1567(fk resources folder:K87:11).path)
	$copyFileText:=Replace string:C233($copyFileText; "${TARGET_CONTENTS}/Components/4D ViewPro.4dbase/Contents/Resources/"; Folder:C1567(fk resources folder:K87:11).path)
	
	$copyFileText:=Replace string:C233($copyFileText; "${LibLangueLproj}"; $lang+".lproj")
	$copyFileText:=Replace string:C233($copyFileText; "${Lib2Langue}"; $lang)
	$copyFileText:=Replace string:C233($copyFileText; "${Lib2LangueMAJ}"; Uppercase:C13($lang))
	
	var $copyFileData : Collection
	$copyFileData:=JSON Parse:C1218($copyFileText)["4DViewPro"]
	
	var $operations : Object
	var $dest : 4D:C1709.Folder
	var $fromPath : Text
	var $destFile; $file : 4D:C1709.File
	For each ($operations; $copyFileData)
		
		$dest:=Folder:C1567($operations.to; fk posix path:K87:1)
		If (Not:C34($dest.exists))
			$dest.create()
		End if 
		
		For each ($fromPath; $operations.from)
			
			$file:=File:C1566($fromPath; fk posix path:K87:1)
			If ($reverse)
				$destFile:=$dest.file($file.fullName)
				$destFile.copyTo($file.parent; fk overwrite:K87:5)
			Else 
				$destFile:=$file.copyTo($dest; fk overwrite:K87:5)
			End if 
			
			// copy not min
			If ((Position:C15(".min"; $fromPath)>0) && (File:C1566(Replace string:C233($fromPath; ".min"; ""); fk posix path:K87:1).exists))
				
				$file:=File:C1566(Replace string:C233($fromPath; ".min"; ""); fk posix path:K87:1)
				If ($reverse)
					$destFile:=$dest.file($file.fullName)
					$destFile.copyTo($file.parent; fk overwrite:K87:5)
				Else 
					$destFile:=$file.copyTo($dest; fk overwrite:K87:5)
				End if 
				
			End if 
			
		End for each 
		
	End for each 
	
End for each 