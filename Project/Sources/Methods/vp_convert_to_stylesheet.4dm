//%attributes = {"invisible":true}
#DECLARE($in : Object) : Object

If ($in=Null:C1517)
	
	return New object:C1471(\
		"name"; Null:C1517; \
		"backColor"; Null:C1517; \
		"backgroundImage"; Null:C1517; \
		"backgroundImageLayout"; Null:C1517; \
		"borderBottom"; Null:C1517; \
		"borderLeft"; Null:C1517; \
		"borderRight"; Null:C1517; \
		"borderTop"; Null:C1517; \
		"cellPadding"; Null:C1517; \
		"diagonalDown"; Null:C1517; \
		"diagonalUp"; Null:C1517; \
		"font"; Null:C1517; \
		"foreColor"; Null:C1517; \
		"formatter"; Null:C1517; \
		"hAlign"; Null:C1517; \
		"isVerticalText"; Null:C1517; \
		"labelOptions\t"; Null:C1517; \
		"locked"; Null:C1517; \
		"shrinkToFit"; Null:C1517; \
		"tabStop"; Null:C1517; \
		"textDecoration"; Null:C1517; \
		"textIndent"; Null:C1517; \
		"vAlign"; Null:C1517; \
		"watermark"; Null:C1517; \
		"wordWrap"; Null:C1517; \
		"textOrientation"; Null:C1517\
		)
Else 
	
	var $stylesheet:=OB Copy:C1225($in)
	vp_make_picture($stylesheet; "backgroundImage")
	return $stylesheet
	
End if 
