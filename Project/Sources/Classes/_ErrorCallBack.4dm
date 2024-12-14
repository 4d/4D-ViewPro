property _previousMethodCalledOnError : Text
property result : Object

singleton Class constructor
	This:C1470.result:={}
	
Function try()
	This:C1470._previousMethodCalledOnError:=Method called on error:C704
	This:C1470.result:={}
	ON ERR CALL:C155("CATCH_CALLBACK")
	
Function catch()
	// TODO: replace by Last errors? (but not same fields code => errCode), and maybe use just Try block in code instead of this class
	ARRAY LONGINT:C221($codeArray; 0)
	ARRAY TEXT:C222($intCompArray; 0)
	ARRAY TEXT:C222($txtArray; 0)
	
	_O_GET LAST ERROR STACK:C1015($codeArray; $intCompArray; $txtArray)
	
	If (This:C1470.result.errors=Null:C1517)
		This:C1470.result.errors:=[]
	End if 
	
	var $index : Integer
	For ($index; 1; Size of array:C274($codeArray))
		This:C1470.result.errors.push({code: $codeArray{$index}; message: $txtArray{$index}})
	End for 
	
Function finally()
	ON ERR CALL:C155(This:C1470._previousMethodCalledOnError)
	
Function throw($errorCode : Integer; $errorMessage : Text)
	If (This:C1470.result.errors=Null:C1517)
		This:C1470.result.errors:=[]  // just to be sure it will be taken into account if code change
	End if 
	// This.result.errors.insert(0; {code: $errorCode; message: $errorMessage})
	
	This:C1470.result.errorCode:=$errorCode
	This:C1470.result.errorMessage:=$errorMessage
	
Function hasErrors() : Boolean
	return (This:C1470.result.errors#Null:C1517) && (This:C1470.result.errors.length>0)