//%attributes = {"invisible":true}
#DECLARE($value : Object; $options : Object) : Text

var $formatTxt : Text
var $date : Date
var $isDate : Boolean
var $formatNum : Integer
var $time : Time

If (Count parameters:C259=0)
	
	return 
	
End if 

var $BASE_DATE : Date:=Storage:C1525.ViewPro.BASE_DATE
var $valueType : Integer:=Value type:C1509($value.value)

// Mark:-value + format
If (Count parameters:C259>=2)
	
	var $formatType : Integer:=Value type:C1509($options.value)
	
	Case of 
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		: ($formatType=Is text:K8:3)
			
			return String:C10($value.value; $options.value)
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		: ($formatType=Is real:K8:4)
			
			$formatNum:=$options.value
			
			If (($formatNum>=19)\
				 & ($formatNum<=39))
				
				Case of 
						
						//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
					: ($valueType=Is real:K8:4)\
						 | ($valueType=Is longint:K8:6)
						
						$date:=Add to date:C393($BASE_DATE; 0; 0; Int:C8($value.value))
						$time:=Time:C179(86400*Dec:C9($value.value))
						$isDate:=True:C214
						
						//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
					: ($valueType=Is date:K8:7)
						
						$date:=$value.value
						$time:=$value.time
						$isDate:=True:C214
						
						//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
				End case 
			End if 
			
			Case of 
					
					//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
				: ($isDate)
					
					Case of 
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: (($formatNum>=19)\
							 & ($formatNum<=24))
							
							return String:C10($date; $formatNum-18)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=25)
							
							return Get localized string:C991("WeekDay"+String:C10(Day number:C114($date)))
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=26)
							
							return String:C10(Day of:C23($date))
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=27)
							
							return Get localized string:C991("Month"+String:C10(Month of:C24($date)))
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=28)
							
							return String:C10(Month of:C24($date))
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=29)
							
							return String:C10(Year of:C25($date))
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=30)
							
							return String:C10($date; System date long:K1:3)\
								+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_1")\
								+String:C10($time; HH MM AM PM:K7:5)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=31)
							
							return String:C10($date; System date abbreviated:K1:2)\
								+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_2")\
								+String:C10($time; HH MM AM PM:K7:5)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=32)
							
							return String:C10($date; System date short:K1:1)\
								+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_3")\
								+String:C10($time; HH MM SS:K7:1)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=33)
							
							return String:C10($date; Internal date long:K1:5)\
								+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_4")\
								+String:C10($time; HH MM AM PM:K7:5)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=34)
							
							return String:C10($date; Internal date short special:K1:4)\
								+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_5")\
								+String:C10($time; Hour min sec:K7:3)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=35)
							
							return String:C10($time; HH MM SS:K7:1)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=36)
							
							return String:C10($time; HH MM:K7:2)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=37)
							
							return String:C10($time; Hour min sec:K7:3)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=38)
							
							return String:C10($time; Hour min:K7:4)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						: ($formatNum=39)
							
							return String:C10($time; HH MM AM PM:K7:5)
							
							//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
					End case 
					
					//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
				: ($valueType=Is real:K8:4)\
					 | ($valueType=Is longint:K8:6)
					
					If (($formatNum>=1)\
						 & ($formatNum<=18))
						
						$formatTxt:=Get localized string:C991("FORMAT_4DVIEW_NUMERIC_"+String:C10($formatNum))
						return String:C10($value.value; $formatTxt)
						
					Else 
						
						return String:C10($value.value)
						
					End if 
					
					//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
				Else 
					
					return String:C10($value.value)
					
					//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
			End case 
			
			//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	End case 
End if 

// Mark:-Default format
Case of 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($valueType=Is date:K8:7)
		
		If ($value.value=$BASE_DATE)
			
			$time:=$value.time
			return String:C10($time)
			
		Else 
			
			return String:C10($value.value; Internal date short special:K1:4)
			
		End if 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: ($valueType=Is object:K8:27)
		
		return JSON Stringify:C1217($value.value)
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	Else 
		
		return String:C10($value.value)
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
End case 