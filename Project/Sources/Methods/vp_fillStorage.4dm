//%attributes = {"invisible":true}
#DECLARE($o : Object)

$o.version:=1
$o.extension:=".4vp"
$o.spreadJSVersion:="18.2.0"
$o.options:=New shared object:C1526

Use ($o.options)
	
	$o.options.prettyPrint:=Not:C34(Is compiled mode:C492)
	
End use 

