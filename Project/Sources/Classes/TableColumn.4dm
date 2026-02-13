// The table column's property name in the data context.
property dataField : Text
// The table column's formatter.
property formatter : Text
// The table column's name (mandatory).
property name : Text

Class constructor( ...  : Variant)
	var $nbParameters : Integer
	$nbParameters:=Count parameters:C259
	
	var $key : Text
	Case of 
		: ($nbParameters=0)
			// nothing
			
		: ($nbParameters=1)
			
			var $objectParameters : Variant
			$objectParameters:=Copy parameters:C1790().first()
			If (Value type:C1509($objectParameters)=Is object:K8:27)
				For each ($key; $objectParameters)
					This:C1470[$key]:=$objectParameters[$key]
				End for each 
				
			End if 
			
		Else 
			// expect key value like New object
			var $parameters : Collection
			$parameters:=Copy parameters:C1790()
			var $index : Integer
			For ($index; 0; $parameters.length-1)
				If ((($index%2)=0) && (Value type:C1509($parameters[$index])=Is text:K8:3) && (($index+1)<$parameters.length))
					This:C1470[$parameters[$index]]:=$parameters[$index+1]
				End if 
			End for 
			
	End case 
	