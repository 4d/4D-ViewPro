//%attributes = {"invisible":true}
C_VARIANT:C1683($0; $1)

Case of 
	: (Value type:C1509($1)=Is collection:K8:32)
		$0:=vp_parse_collection_set($1)
		
	: (Value type:C1509($1)=Is object:K8:27)
		$0:=vp_parse_object_set($1)
		
	: (Value type:C1509($1)=Is date:K8:7)
		$0:=New object:C1471("type"; "__date__"; "day"; Day of:C23($1); "month"; Month of:C24($1); "year"; Year of:C25($1))
		
	: (Value type:C1509($1)=Is picture:K8:10)
		C_OBJECT:C1216($ob)
		$ob:=New object:C1471("type"; "__picture__"; "value"; $1)
		vp_make_picture($ob; "value")
		$0:=$ob.value
		
	Else 
		$0:=$1
End case 
