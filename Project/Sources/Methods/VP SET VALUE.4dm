//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET VALUE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Sets the value of a cell
// ----------------------------------------------------
#DECLARE($cell : Object; $value : Object)

var $key : Text
var $date : Date
var $type : Integer
var $time : Time
var $o : Object
var $c : Collection

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(2; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Not:C34(vp_isReady($cell.area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	Else 
		
		$o:={}
		
		$type:=Value type:C1509($value.value)
		
		Case of 
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			: (($type=Is boolean:K8:9)\
				 | ($type=Is text:K8:3)\
				 | ($type=Is real:K8:4))
				
				$o.value:=$value.value
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			: ($type=Is date:K8:7)
				
				$date:=Date:C102($value.value)
				
				$o.value:={\
					day: Day of:C23($date); \
					month: Month of:C24($date); \
					year: Year of:C25($date)\
					}
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			: ($type=Is null:K8:31)
				
				$o.value:=Null:C1517
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		End case 
		
		If (Value type:C1509($value.time)=Is real:K8:4)
			
			$o.value:=$o.value || {}
			
			If (Value type:C1509($o.value)=Is object:K8:27)
				
				$time:=Time:C179($value.time)
				
				$o.value.hours:=$time\3600
				$o.value.minutes:=($time%3600)\60
				$o.value.seconds:=$time%60
				
			End if 
		End if 
		
		Case of 
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			: (Value type:C1509($cell.ranges)#Is collection:K8:32)
				
				// <NOTHING MORE TO DO>
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				//: (Feature.with("SET_OBJECTS"))\
					&& ($type=Is undefined)  // Object
				//VP SET FORMULA($cell; "="+vp_objectToFormula($value))
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			Else 
				
				$o.ranges:=$cell.ranges
				
				// Optional format
				If ($value.format#Null:C1517)\
					 && (Value type:C1509($value.format)=Is text:K8:3)
					
					$o.format:=$value.format
					
				End if 
				
				vp_runCommand($cell.area; "set-ranges-value"; $o)
				
				//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
		End case 
		
		//______________________________________________________
End case 

err_FINALLY