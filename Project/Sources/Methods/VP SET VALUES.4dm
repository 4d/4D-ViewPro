//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET VALUES
// Database: 4D ViewPro
// ID[5101BAB9EE102650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the values of a range
// ----------------------------------------------------
#DECLARE($ranges : Object; $values : Collection)

If (False:C215)
	C_OBJECT:C1216(VP SET VALUES; $1)
	C_COLLECTION:C1488(VP SET VALUES; $2)
End if 

var $date : Date
var $column; $row; $type : Integer
var $time : Time
var $v
var $params : Object
var $c : Collection

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

Case of 
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: (Not:C34(Check_parameters_count(2; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: (Value type:C1509($ranges.area)#Is text:K8:3)
		
		// FIXME:ERROR
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: (Not:C34(vp_isReady($ranges.area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	: (Value type:C1509($ranges.ranges)#Is collection:K8:32)
		
		// FIXME:ERROR
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
	Else 
		
		$params:={\
			ranges: $ranges.ranges; \
			value: []\
			}
		
		$params.value.resize($values.length)
		
		For ($row; 0; $values.length-1; 1)
			
			If (Value type:C1509($values[$row])#Is collection:K8:32)
				
				continue
				
			End if 
			
			$c:=[]
			
			For ($column; 0; $values[$row].length-1; 1)
				
				$v:=Null:C1517
				$type:=Value type:C1509($values[$row][$column])
				
				Case of 
						
						//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
					: (($type=Is boolean:K8:9)\
						 | ($type=Is text:K8:3)\
						 | ($type=Is real:K8:4))
						
						$v:=$values[$row][$column]
						
						//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
					: ($type=Is date:K8:7)
						
						$date:=Date:C102($values[$row][$column])
						
						$v:={\
							day: Day of:C23($date); \
							month: Month of:C24($date); \
							year: Year of:C25($date)\
							}
						
						//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
					: ($type=Is object:K8:27)
						
						$type:=Value type:C1509($values[$row][$column].value)
						
						Case of 
								
								//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
							: (($type=Is boolean:K8:9)\
								 | ($type=Is text:K8:3)\
								 | ($type=Is real:K8:4))
								
								$v:=$values[$row][$column].value
								
								//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
							: ($type=Is date:K8:7)
								
								$date:=Date:C102($values[$row][$column].value)
								
								$v:={\
									day: Day of:C23($date); \
									month: Month of:C24($date); \
									year: Year of:C25($date)\
									}
								
								//╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌
						End case 
						
						If (Value type:C1509($values[$row][$column].time)=Is real:K8:4)
							
							$v:=$v || {}
							
							If (Value type:C1509($v)=Is object:K8:27)
								
								$time:=Time:C179($values[$row][$column].time)
								
								$v.hours:=$time\3600
								$v.minutes:=($time%3600)\60
								$v.seconds:=$time%60
								
							End if 
						End if 
						
						//╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍╍
				End case 
				
				// FIXME:Et le format ?
				
				$c.push($v)
				
			End for 
			
			$params.value[$row]:=$c
			
		End for 
		
		vp_runCommand($ranges.area; "set-values"; $params)
		
		//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
End case 

err_FINALLY