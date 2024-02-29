//%attributes = {"invisible":true}
C_OBJECT:C1216(${1})
C_TEXT:C284($0)

If (Count parameters:C259>=1)
	
	C_LONGINT:C283($format)
	C_TEXT:C284($NumericFormat)
	C_BOOLEAN:C305($is_date)
	C_DATE:C307($date)
	C_TIME:C306($time)
	
	$is_date:=False:C215
	
	If (Count parameters:C259>=2)
		Case of 
			: (Value type:C1509($2.value)=Is text:K8:3)
				$0:=String:C10($1.value; $2.value)
				
			: (Value type:C1509($2.value)=Is real:K8:4)
				$format:=$2.value
				
				If (($format>=19) & ($format<=39))
					Case of 
						: (Value type:C1509($1.value)=Is real:K8:4)
							$date:=Add to date:C393(!1899-12-30!; 0; 0; Int:C8($1.value))
							$time:=Time:C179(86400*Dec:C9($1.value))
							$is_date:=True:C214
						: (Value type:C1509($1.value)=Is date:K8:7)
							$date:=$1.value
							$time:=$1.time
							$is_date:=True:C214
					End case 
				End if 
				
				Case of 
					: ($is_date)
						
						Case of 
							: (($format>=19) & ($format<=24))
								$0:=String:C10($date; $format-18)
								
							: ($format=25)
								$0:=Get localized string:C991("WeekDay"+String:C10(Day number:C114($date)))
								
							: ($format=26)
								$0:=String:C10(Day of:C23($date))
								
							: ($format=27)
								$0:=Get localized string:C991("Month"+String:C10(Month of:C24($date)))
								
							: ($format=28)
								$0:=String:C10(Month of:C24($date))
								
							: ($format=29)
								$0:=String:C10(Year of:C25($date))
								
							: ($format=30)
								$0:=String:C10($date; System date long:K1:3)\
									+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_1")\
									+String:C10($time; HH MM AM PM:K7:5)
								
							: ($format=31)
								$0:=String:C10($date; System date abbreviated:K1:2)\
									+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_2")\
									+String:C10($time; HH MM AM PM:K7:5)
								
							: ($format=32)
								$0:=String:C10($date; System date short:K1:1)\
									+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_3")\
									+String:C10($time; HH MM SS:K7:1)
								
							: ($format=33)
								$0:=String:C10($date; Internal date long:K1:5)\
									+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_4")\
									+String:C10($time; HH MM AM PM:K7:5)
								
							: ($format=34)
								$0:=String:C10($date; Internal date short special:K1:4)\
									+Get localized string:C991("FORMAT_4D_VIEW_CONJONCTION_5")\
									+String:C10($time; Hour min sec:K7:3)
								
							: ($format=35)
								$0:=String:C10($time; HH MM SS:K7:1)
								
							: ($format=36)
								$0:=String:C10($time; HH MM:K7:2)
								
							: ($format=37)
								$0:=String:C10($time; Hour min sec:K7:3)
								
							: ($format=38)
								$0:=String:C10($time; Hour min:K7:4)
								
							: ($format=39)
								$0:=String:C10($time; HH MM AM PM:K7:5)
								
						End case 
						
					: (Value type:C1509($1.value)=Is real:K8:4)
						
						If (($format>=1) & ($format<=18))
							$NumericFormat:=Get localized string:C991("FORMAT_4DVIEW_NUMERIC_"+String:C10($format))
							$0:=String:C10($1.value; $NumericFormat)
						Else 
							$0:=String:C10($1.value)
						End if 
						
					Else 
						
						$0:=String:C10($1.value)
						
				End case 
				
		End case 
	Else 
		Case of 
			: (Value type:C1509($1.value)=Is date:K8:7)
				If ($1.value=!1899-12-30!)
					$time:=$1.time
					$0:=String:C10($time)
				Else 
					$0:=String:C10($1.value; Internal date short special:K1:4)
				End if 
				
			: (Value type:C1509($1.value)=Is object:K8:27)
				
				$0:=JSON Stringify:C1217($1.value)
				
			Else 
				
				$0:=String:C10($1.value)
		End case 
	End if 
End if 