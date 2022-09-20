//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP Get active cell
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A125]
  // Created #03-06-2019 by Francois Marchal
  // ----------------------------------------------------
  // Description: 
  // ----------------------------------------------------
  // ----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($0)
C_LONGINT:C283($2)

C_TEXT:C284($area)
C_LONGINT:C283($nbParameters)
C_LONGINT:C283($sheet)

If (False:C215)
	C_TEXT:C284(VP Get active cell ;$1)
	C_LONGINT:C283(VP Get active cell ;$2)
	C_OBJECT:C1216(VP Get active cell ;$0)
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
			$ret:=vp_runFunction ($area;"get-active-cell";$params)
			
			If (Value type:C1509($ret.column)=Is real:K8:4)
				$0:=VP Cell ($area;$ret.column;$ret.row;$ret.sheetIndex)
			End if 
			
		End if 
	End if 
	
	FINALLY 
	
End if 