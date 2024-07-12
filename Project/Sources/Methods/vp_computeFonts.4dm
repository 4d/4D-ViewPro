//%attributes = {"invisible":true}
// called from js via C++ when a pdf is exported.
#DECLARE($params : Object) : Object

var $fonts:={}

var $shorthand : Text
For each ($shorthand; $params)
	vp_makeFont($fonts; $shorthand)
End for each 

return $fonts