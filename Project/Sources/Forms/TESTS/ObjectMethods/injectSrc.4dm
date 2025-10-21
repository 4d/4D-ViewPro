
// simulate copy files of resources

var $platformPath : Text
$platformPath:=Folder:C1567(fk home folder:K87:24).folder("git").folder("SpreadJS").platformPath
$platformPath:=Select folder:C670("Select root"; $platformPath)

If (Length:C16($platformPath)=0)
	return   // cancel 
End if 

var $database:=Folder:C1567(Folder:C1567(fk database folder:K87:14).platformPath; fk platform path:K87:2)

var $reverse:=Shift down:C543

var $folder : 4D:C1709.Folder
$folder:=Folder:C1567($platformPath; fk platform path:K87:2)

If (Not:C34($folder.file("bundler.py").exists))
	return 
End if 
var $mode:="debug"

var $cmd:=$folder.file("bundler.py").path
$cmd+=" --mode "+$mode+" \""+$database.path+"\""

var $worker:=4D:C1709.SystemWorker.new($cmd).wait()

ALERT:C41($worker.response)
