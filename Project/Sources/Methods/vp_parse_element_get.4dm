//%attributes = {"invisible":true}
C_VARIANT:C1683($0; $1)

Case of 
	: (Value type:C1509($1)=Is collection:K8:32)
		$0:=vp_parse_collection_get($1)
		
	: (Value type:C1509($1)=Is object:K8:27)
		C_BOOLEAN:C305($handled)
		$handled:=False:C215
		
		If (OB Get type:C1230($1; "type")=Is text:K8:3)
			Case of 
				: ($1.type="__date__")
					$0:=Add to date:C393(!00-00-00!; $1.year; $1.month; $1.day)
					$handled:=True:C214
					
				: ($1.type="__dateTime__")
					$0:=New object:C1471("value"; Add to date:C393(!00-00-00!; $1.year; $1.month; $1.day); "time"; $1.time)
					$handled:=True:C214
					
				: ($1.type="__picture__")
					C_OBJECT:C1216($ob)
					$ob:=New object:C1471("value"; $1.value)
					vp_get_picture($ob; "value")
					$0:=$ob.value
					$handled:=True:C214
					
			End case 
		End if 
		
		If (Not:C34($handled))
			$0:=vp_parse_object_get($1)
		End if 
	Else 
		$0:=$1
End case 
