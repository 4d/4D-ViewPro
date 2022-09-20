Class constructor()
	This:C1470._height:=0
	This:C1470._width:=0
	This:C1470._imageSrc:=""
	This:C1470._page:=""
	This:C1470._x:=0
	This:C1470._y:=0
	
	// getter
Function get height : Integer
	return This:C1470._height
	
Function get width : Integer
	return This:C1470._width
	
Function get imageSrc : Text
	return This:C1470._imageSrc
	
Function get page : Text
	return This:C1470._page
	
Function get x : Integer
	return This:C1470._x
	
Function get y : Integer
	return This:C1470._y
	
		// setter
Function set height($param1 : Integer)
	This:C1470._height:=$param1

Function set width($param1 : Integer)
	This:C1470._width:=$param1

Function set imageSrc($param1 : Text)
	This:C1470._imageSrc:=$param1

Function set page($param1 : Text)
	This:C1470._page:=$param1

Function set x($param1 : Integer)
	This:C1470._x:=$param1

Function set y($param1 : Integer)
	This:C1470._y:=$param1
