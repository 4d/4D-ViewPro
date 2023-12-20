//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP get values
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Get the values of a range
// ----------------------------------------------------
#DECLARE($tgt : Object) : Collection

If (False:C215)
	C_OBJECT:C1216(VP Get values; $1)
	C_COLLECTION:C1488(VP Get values; $0)
End if 

var $col; $row : Integer
var $v
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
	: (Not:C34(vp_isReady($tgt.area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Value type:C1509($tgt.ranges)#Is collection:K8:32)
		
		//ERROR
		//______________________________________________________
	Else 
		
		$js:=vp_runFunction($tgt.area; "get-values"; {ranges: $tgt.ranges})
		
		If ($js#Null:C1517)\
			 && (Value type:C1509($js.value)=Is collection:K8:32)
			
			For ($row; 0; $js.value.length-1; 1)
				
				If (Value type:C1509($js.value[$row])#Is collection:K8:32)
					
					continue
					
				End if 
				
				For ($col; 0; $js.value[$row].length-1; 1)
					
					$v:=$js.value[$row][$col]
					
					If (Value type:C1509($v)=Is object:K8:27)\
						 && ($v.date#Null:C1517)
						
						$js.value[$row][$col].value:=Add to date:C393(!00-00-00!; $v.date.year; $v.date.month; $v.date.day)
						OB REMOVE:C1226($v; "date")
						
					End if 
				End for 
			End for 
			
		End if 
		
		//______________________________________________________
End case 

err_FINALLY

return $js.value