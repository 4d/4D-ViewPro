//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP Get selection
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A125]
  // Created #03-06-2019 by Francois Marchal
  // ----------------------------------------------------
  // Description: 
  // ----------------------------------------------------
  // ----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($0)

C_TEXT:C284($area)
C_LONGINT:C283($nbParameters)
C_LONGINT:C283($sheet)

If (False:C215)
	C_TEXT:C284(VP Get selection ;$1)
	C_LONGINT:C283(VP Get selection ;$2)
	C_OBJECT:C1216(VP Get selection ;$0)
End if 

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (1;$nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			$sheet:=$2
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($ret;$params)
			$params:=New object:C1471("sheetIndex";$sheet)
			$ret:=vp_runFunction ($area;"get-selection";$params)
			
			If (Value type:C1509($ret.ranges)=Is collection:K8:32)
				$ret.area:=$area
				$0:=$ret
			End if 
			
		End if 
	End if 
	
	FINALLY 
	
End if 