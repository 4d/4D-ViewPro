//%attributes = {"invisible":true}
#DECLARE($cell : Object; $newValue : Variant; $format : Text)

var $value:=New object:C1471

Case of 
	: ((Value type:C1509($newValue)=Is text:K8:3)\
		 || (Value type:C1509($newValue)=Is longint:K8:6)\
		 || (Value type:C1509($newValue)=Is real:K8:4)\
		 || (Value type:C1509($newValue)=Is boolean:K8:9)\
		 || (Value type:C1509($newValue)=Is date:K8:7))
		$value.value:=$newValue
	: (Value type:C1509($newValue)=Is object:K8:27)
		$value:=$newValue
	: (Value type:C1509($newValue)=Is time:K8:8)
		$value.time:=Num:C11($newValue)
End case 

If ((Count parameters:C259>2) & ($format#""))
	$value.format:=$format
End if 

VP SET VALUE($cell; $value)
