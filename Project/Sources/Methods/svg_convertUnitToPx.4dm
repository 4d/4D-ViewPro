//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$val)
C_TEXT:C284($0;$converted)

$val:=$1

Case of 
	: (Position:C15("ex";$val)>0)
	: (Position:C15("%";$val)>0)
		$converted:=String:C10(Num:C11($val;".")/100*10;"&xml;")+"px"
	: (Position:C15("px";$val)>0)
		$converted:=String:C10(Num:C11($val;".");"&xml")+"px"
	: (Position:C15("cm";$val)>0)
		$converted:=String:C10(Num:C11($val;".")/2.54*72*(4/3);"&xml;")+"px"
	: (Position:C15("mm";$val)>0)
		$converted:=String:C10(Num:C11($val;".")/10/2.54*72*(4/3);"&xml;")+"px"
	: (Position:C15("in";$val)>0)
		$converted:=String:C10(Num:C11($val;".")*72*(4/3);"&xml;")+"px"
	: (Position:C15("pt";$val)>0)
		$converted:=String:C10(Num:C11($val;".")*(4/3);"&xml;")+"px"
	: (Position:C15("pc";$val)>0)
		$converted:=String:C10(Num:C11($val;".")*12*(4/3);"&xml;")+"px"
	: (Position:C15("ch";$val)>0)
	: (Position:C15("rem";$val)>0)
		$converted:="small"
	: (Position:C15("em";$val)>0)
	: (Position:C15("vh";$val)>0)
	: (Position:C15("vw";$val)>0)
	: (Position:C15("vmin";$val)>0)
	: (Position:C15("vmax";$val)>0)
End case 

$0:=$converted