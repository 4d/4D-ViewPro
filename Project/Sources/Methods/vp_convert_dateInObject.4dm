//%attributes = {"invisible":true}
#DECLARE($object : Object; $inValue : Boolean)

var $data : Object
$data:=Bool:C1537($inValue) ? $object.value : $object
// convert if date

If (Bool:C1537($data.$4d_convertValueToDate))
	
	$object.time:=$data.time
	$object.value:=Add to date:C393(!00-00-00!; $data.date.year; $data.date.month; $data.date.day)
	If (Not:C34(Bool:C1537($inValue)))
		OB REMOVE:C1226($object; "date")
		OB REMOVE:C1226($object; "$4d_convertValueToDate")
	End if 
	
Else 
	
	// else look recursively for date inside
	var $key : Text
	For each ($key; $object)
		
		If (Value type:C1509($object[$key])=Is object:K8:27)
			
			vp_convert_dateInObject($object[$key])
			
			If ((Value type:C1509($object[$key].time)=Is real:K8:4)\
				 && ($object[$key].time=0)\
				 && (Value type:C1509($object[$key].value)=Is date:K8:7))  // opti done: no date test if no time real as 0
				$object[$key]:=$object[$key].value  // has converted a date only, use it without object
			End if 
			
		End if 
		
	End for each 
	
End if 