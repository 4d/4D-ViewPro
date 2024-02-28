//%attributes = {}
#DECLARE($msg : Text; $date : Date; $time : Variant; $col : Collection; $obj : Object) : Text

If (Value type:C1509($date)#Is date:K8:7)
	return "no date"
End if 

If (Value type:C1509($time)#Is time:K8:8)
	return "no time"
End if 


return _dev_myObject($obj)