Class extends __range

Class constructor($area : Text; $column : Integer; $row : Integer; $sheet : Integer)
	
	var $range : Object
	
	$sheet:=Count parameters:C259<4 ? -1 : $sheet  // Default is -1
	
	$range:={\
		column: $column; \
		row: $row\
		}
	
	If ($sheet#-1)
		
		$range.sheet:=$sheet
		
	End if 
	
	Super:C1705($area; $range)
	
	This:C1470.column:=$column
	This:C1470.row:=$row
	This:C1470.sheet:=$sheet
	
	This:C1470.range:=$range
	
/*
// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
// Avoid getter and setter which are not well handled by WA EXECUTE JAVASCRIPT FUNCTION
Function get reference() : Text
	
return This.getReference()
*/
	
	// === === === === === === === === === === === === === === === === === === === === === === === === ===
Function getReference($options : Object) : Text
	
	var $column; $type; $row : Text
	
	$column:=This:C1470._indexToLetters(This:C1470.range.column+1)
	$row:=String:C10(This:C1470.range.row+1)
	
	If (String:C10($options.mode)="R1C1")
		
		// TODO:Get setting
		$column:="C"+$column
		$row:="R"+$row
		
	Else 
		
		$type:=String:C10($options.type)
		
		Case of 
				
				//______________________________________________________
			: ($type="relative")
				
				// <NOTHING MORE TO DO>
				//______________________________________________________
			: ($type="absolute")
				
				$column:="$"+$column
				$row:="$"+$row
				
				//______________________________________________________
			: ($type="absoluteColumn")
				
				$column:="$"+$column
				
				//______________________________________________________
			: ($type="absoluteRow")
				
				$row:="$"+$row
				
				//______________________________________________________
		End case 
	End if 
	
	If (Bool:C1537($options.sheet))
		
		return VP Get sheet name(This:C1470.area; This:C1470.range.sheet)+"!"+$column+$row
		
	Else 
		
		return $column+$row
		
	End if 
	