//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get value
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Gets the value of a cell
// ----------------------------------------------------
#DECLARE($cell : cs:C1710._cell) : Object

var $js : Object

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(1; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Not:C34(vp_isReady($cell.area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	Else 
		
		$js:=vp_runFunction($cell.area; "get-value"; {ranges: $cell.ranges})
		
		If (($js#Null:C1517)\
			 && (Value type:C1509($js.value)=Is object:K8:27))
			
			Case of 
				: (Feature.with("GET_OBJECTS"))
					
					vp_convert_dateInObject($js; True:C214)
					
				: ($js.value.date#Null:C1517)
					
					$js.time:=$js.value.time
					$js.value:=Add to date:C393(!00-00-00!; $js.value.date.year; $js.value.date.month; $js.value.date.day)
					
			End case 
			
		End if 
		
		//______________________________________________________
End case 

err_FINALLY

return $js