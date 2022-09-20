//%attributes = {"invisible":true}
C_OBJECT:C1216($1)
C_VARIANT:C1683($2)
C_TEXT:C284($3)
C_OBJECT:C1216($value)
$value:=New object:C1471

Case of 
	: ((Value type:C1509($2)=Is text:K8:3)\
		 | (Value type:C1509($2)=Is longint:K8:6)\
		 | (Value type:C1509($2)=Is real:K8:4)\
		 | (Value type:C1509($2)=Is boolean:K8:9)\
		 | (Value type:C1509($2)=Is date:K8:7))
		$value.value:=$2
	: (Value type:C1509($2)=Is object:K8:27)
		$value:=$2
	: (Value type:C1509($2)=Is time:K8:8)
		$value.time:=Num:C11($2)
End case 

If ((Count parameters:C259>2) & ($3#""))
	$value.format:=$3
End if 

VP SET VALUE ($1;$value)
