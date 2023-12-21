Class extends __range

Class constructor($area : Text; $column : Integer; $columnCount : Integer; $sheet : Integer)
	
	var $range : Object
	
	$columnCount+=Num:C11($columnCount=0)  // Default is 1 
	$sheet:=Count parameters:C259<4 ? -1 : $sheet  // Default is -1 
	
	$range:={\
		column: $column; \
		columnCount: $columnCount\
		}
	
	If ($sheet#-1)
		
		$range.sheet:=$sheet
		
	End if 
	
	Super:C1705($area; $range)
	
	This:C1470.column:=$column
	This:C1470.columnCount:=$columnCount
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
	
	var $column; $type : Text
	
	$column:=This:C1470._indexToLetters(This:C1470.ranges[0].column+1)
	
	var $o : cs:C1710.workbookOptions
	$o:=VP Get workbook options(This:C1470.area)
	
	If (Bool:C1537($o.referenceStyle))\
		 | (String:C10($options.mode)="R1C1")
		
		$column:="C"+$column
		
	Else 
		
		$type:=String:C10($options.type)
		
		Case of 
				
				//______________________________________________________
			: ($type="relative")
				
				// <NOTHING MORE TO DO>
				//______________________________________________________
			: ($type="absolute")
				
				$column:="$"+$column
				
				//______________________________________________________
		End case 
		
		$column+=":"+$column
		
	End if 
	
	If (Bool:C1537($options.sheet))
		
		$column:=VP Get sheet name(This:C1470.area; This:C1470.ranges[0].sheet)+"!"+$column
		
	End if 
	
	return $column