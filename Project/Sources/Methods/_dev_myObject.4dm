//%attributes = {}
#DECLARE($obj : Object) : Text

Case of 
	: ($obj=Null:C1517)
		return "❌ Null object"
	: (OB Is empty:C1297($obj))
		return "⚠️ object empty"
	Else 
		
		// =OBJECT("text";"hello world";"textV";B1;"integer";12;"integerV";B2;"real";PI();"realV";B3;"date";AUJOURDHUI();"dateV";B4;"time";MAINTENANT();"timeV";B5;"object";OBJECT("key";"value"))
		
		var $data : Object
		$data:=$obj  // .value  // (if we have "value,  easy to change here)
		
		Case of 
			: (Value type:C1509($data.object)#Is object:K8:27)
				return "❌ no sub object"
			: (Value type:C1509($data.text)#Is text:K8:3)
				return "❌ no text"
			: (Value type:C1509($data.textV)#Is text:K8:3)
				return "❌ no text from cell"
			: (Value type:C1509($data.integer)#Is real:K8:4)
				return "❌ no real integer"
			: (Value type:C1509($data.integerV)#Is real:K8:4)
				return "❌ no real integer from cell"
			: (Value type:C1509($data.time)#Is object:K8:27)
				return "❌ no time object"
			: (Value type:C1509($data.time.time)#Is real:K8:4)
				return "❌ no time attr in time object"
			: (Value type:C1509($data.time.value)#Is date:K8:7)
				return "❌ no value attr for date in time object"
			: ($data.time.date#Null:C1517)
				return "❌ extraneous date attr in time object"
			: (Value type:C1509($data.timeV)#Is object:K8:27)
				return "❌ no time object from cell"
			: (Value type:C1509($data.timeV.time)#Is real:K8:4)
				return "❌ no time attr in time object from cell"
			: (Value type:C1509($data.timeV.value)#Is date:K8:7)
				return "❌ no value attr for date in time object from cell"
			: ($data.timeV.date#Null:C1517)
				return "❌ extraneous date attr in time object from cell"
			: (Value type:C1509($data.date)#Is date:K8:7)  // TODO: maybe object with data as value (Date could be Date or DateTime)
				return "❌ no date"
			: (Value type:C1509($data.dateV)#Is date:K8:7)
				return "❌ no date from cell"
		End case 
		
End case 

return "✅"