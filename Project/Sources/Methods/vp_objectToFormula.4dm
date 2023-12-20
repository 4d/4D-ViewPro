//%attributes = {"invisible":true}
#DECLARE($value : Object) : Text

If (False:C215)
	C_OBJECT:C1216(vp_objectToFormula; $1)
	C_TEXT:C284(vp_objectToFormula; $0)
End if 

var $key : Text
var $type : Integer
var $c : Collection

$c:=[]

For each ($key; $value)
	
	$type:=Value type:C1509($value[$key])
	$c.push("\""+$key+"\"")
	
	Case of 
			
			//……………………………………………………………………………………………
		: ($type=Is text:K8:3)
			
			$c.push("\""+$value[$key]+"\"")
			
			//……………………………………………………………………………………………
		: ($type=Is object:K8:27)
			
			$c.push(vp_objectToFormula($value[$key]))  // <== RECURSIVE
			
			//……………………………………………………………………………………………
		Else 
			
			$c.push(String:C10($value[$key]))
			
			//……………………………………………………………………………………………
	End case 
End for each 

return "OBJECT("+$c.join(",")+")"