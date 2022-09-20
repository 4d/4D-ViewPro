Class constructor()
	This:C1470._width:=850
	This:C1470._height:=1100
	This:C1470._kind:="custom"
	
	// getter
Function get width : Integer
	return This:C1470._width
	
Function get height : Integer
	return This:C1470._height
	
Function get kind : Text
	return This:C1470._kind
	
	// setter
Function set width($param1 : Integer)
	This:C1470._width:=$param1
	
Function set height($param1 : Integer)
	This:C1470._height:=$param1
	
Function set kind($param1 : Text)
	This:C1470._kind:=$param1
	