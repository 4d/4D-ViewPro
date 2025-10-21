//%attributes = {"invisible":true}
#DECLARE($in : Variant) : Variant

var $out : Variant

Case of 
	: (Value type:C1509($in)=Is collection:K8:32)
		
		$out:=vp_parse_collection_get($in)
		
	: (Value type:C1509($in)=Is object:K8:27)
		
		var $handled:=False:C215
		
		If (OB Get type:C1230($in; "type")=Is text:K8:3)
			Case of 
				: ($in.type="__date__")
					$out:=Add to date:C393(!00-00-00!; $in.year; $in.month; $in.day)
					$handled:=True:C214
					
				: ($in.type="__dateTime__")
					$out:=New object:C1471("value"; Add to date:C393(!00-00-00!; $in.year; $in.month; $in.day); "time"; $in.time)
					$handled:=True:C214
					
				: ($in.type="__picture__")
					
					var $ob:=New object:C1471("value"; $in.value)
					vp_get_picture($ob; "value")
					$out:=$ob.value
					$handled:=True:C214
					
			End case 
		End if 
		
		If (Not:C34($handled))
			$out:=vp_parse_object_get($in)
		End if 
	Else 
		$out:=$in
End case 

return $out