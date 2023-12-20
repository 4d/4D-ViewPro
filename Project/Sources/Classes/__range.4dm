property area : Text
property sheet : Integer
property ranges : Collection

Class constructor($area : Text; $target)
	
	This:C1470.area:=$area
	This:C1470.sheet:=-1
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($target)=Is object:K8:27)
			
			This:C1470.ranges:=New collection:C1472($target)
			
			//______________________________________________________
		: (Value type:C1509($target)=Is collection:K8:32)
			
			This:C1470.ranges:=$target
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "'range' must be an object or a collection")
			
			//______________________________________________________
	End case 
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getValue() : Object
	
	return VP Get value(This:C1470)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getValues() : Collection
	
	return VP Get values(This:C1470)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setValue($value; $format : Text)
	
	var $o : Object
	var $type : Integer
	
	$o:={}
	$type:=Value type:C1509($value)
	
	Case of 
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		: ($type=Is text:K8:3)\
			 || ($type=Is longint:K8:6)\
			 || ($type=Is real:K8:4)\
			 || ($type=Is boolean:K8:9)\
			 || ($type=Is date:K8:7)
			
			$o.value:=$value
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		: ($type=Is object:K8:27)
			
			$o:=$value
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		: ($type=Is time:K8:8)
			
			$o.time:=Num:C11($value)
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		Else 
			
			ASSERT:C1129(False:C215; "unmanaged value type")
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	End case 
	
	If (Length:C16($format)>0)
		
		$o.format:=$format
		
	End if 
	
	VP SET VALUE(This:C1470; $o)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setNumValue($value : Real; $format : Text)
	
	var $o : Object
	
	$o:={value: $value}
	
	If (Length:C16($format)>0)
		
		$o.format:=$format
		
	End if 
	
	VP SET VALUE(This:C1470; $o)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setTextValue($value : Text; $format : Text)
	
	var $o : Object
	
	$o:={value: $value}
	
	If (Length:C16($format)>0)
		
		$o.format:=$format
		
	End if 
	
	VP SET VALUE(This:C1470; $o)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setDateValue($value : Date; $format : Text)
	
	var $o : Object
	
	$o:={\
		value: $value; \
		format: Length:C16($format)>0 ? $format : "_shortDatePattern_"\
		}
	
	VP SET VALUE(This:C1470; $o)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setDateTimeValue($date : Date; $time : Time; $format : Text)
	
	var $o : Object
	
	$o:={\
		value: $date; \
		time: $time; \
		format: Length:C16($format)>0 ? $format : "_fullDateTimePattern_"\
		}
	
	VP SET VALUE(This:C1470; $o)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setTimeValue($time : Time; $format : Text)
	
	var $o : Object
	
	$o:={\
		time: $time; \
		format: Length:C16($format)>0 ? $format : "_longTimePattern_"\
		}
	
	VP SET VALUE(This:C1470; $o)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setFormula($formula : Text; $format : Text)
	
	VP SET FORMULA(This:C1470; $formula; $format)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setStyle($style : Object)
	
	VP SET CELL STYLE(This:C1470; $style)
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function setBackColor($color : Text)
	
	VP SET CELL STYLE(This:C1470; {backColor: $color})
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getBackColor() : Text
	
	return VP Get cell style(This:C1470).backColor
	
	// *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
Function _indexToLetters($index : Integer) : Text
	
	var $letters : Text
	var $n : Integer
	
	Repeat 
		
		$n:=($index-1)%26
		$index:=($index-1)\26
		$letters:="ABCDEFGHIJKLMNOPQRSTUVWXYZ"[[$n+1]]+$letters
		
	Until ($index<=0)
	
	return $letters