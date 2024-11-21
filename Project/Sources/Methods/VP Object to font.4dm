//%attributes = {"invisible":true,"shared":true}
#DECLARE($obj : Object)->$Txt_font : Text

If ((Value type:C1509($obj.family)=Is text:K8:3)\
 & (Value type:C1509($obj.size)=Is text:K8:3))
	
	If (Value type:C1509($obj.weight)=Is text:K8:3)
		If (($obj.weight="lighter") | \
			($obj.weight="bold") | \
			($obj.weight="bolder") | \
			($obj.weight="100") | \
			($obj.weight="200") | \
			($obj.weight="300") | \
			($obj.weight="400") | \
			($obj.weight="500") | \
			($obj.weight="600") | \
			($obj.weight="700") | \
			($obj.weight="800") | \
			($obj.weight="900"))
			$Txt_font:=$obj.weight+" "
		End if 
	End if 
	
	If (Value type:C1509($obj.style)=Is text:K8:3)
		If (($obj.style="italic") | ($obj.style="oblique"))
			$Txt_font:=$Txt_font+$obj.style+" "
		End if 
	End if 
	
	If (Value type:C1509($obj.variant)=Is text:K8:3)
		If ($obj.variant="small-caps")
			$Txt_font:=$Txt_font+$obj.variant+" "
		End if 
	End if 
	
	If (Value type:C1509($obj.size)=Is text:K8:3)
		$Txt_font:=$Txt_font+$obj.size+" "
	End if 
	
	If (Position:C15(" "; $obj.family)>0)
		$Txt_font:=$Txt_font+"\""+$obj.family+"\""
	Else 
		$Txt_font:=$Txt_font+$obj.family
	End if 
	
End if 
