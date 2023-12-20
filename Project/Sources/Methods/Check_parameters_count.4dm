//%attributes = {"invisible":true}
// Check that the minimal amount of parameters required for the method has been sent
#DECLARE($expected : Integer; $received : Integer) : Boolean

If (False:C215)
	C_LONGINT:C283(Check_parameters_count; $1)
	C_LONGINT:C283(Check_parameters_count; $2)
	C_BOOLEAN:C305(Check_parameters_count; $0)
End if 

var $params : Integer

$params:=Count parameters:C259

If ($params=0)
	
	// Misssing parameter (expected {expected})
	_4D THROW ERROR:C1520({\
		component: "4DEV"; \
		code: 1; \
		expected: $expected; \
		deferred: True:C214\
		})
	
	return 
	
End if 

If ($params>1)
	
	If ($received>=$expected)
		
		return True:C214
		
	End if 
	
	// Misssing parameter (received {received}, expected {expected})
	_4D THROW ERROR:C1520({\
		component: "4DEV"; \
		code: 3; \
		received: $received; \
		expected: $expected; \
		deferred: True:C214\
		})
	
End if 