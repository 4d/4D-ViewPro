//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP SET FROZEN PANES
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A124]
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: set frozen panes
  // ----------------------------------------------------
  // ----- Declarations

C_TEXT:C284($1)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_LONGINT:C283($sheet)
C_OBJECT:C1216($panes)

If (False:C215)
	C_TEXT:C284(VP SET FROZEN PANES ;$1)
	C_OBJECT:C1216(VP SET FROZEN PANES ;$2)
	C_LONGINT:C283(VP SET FROZEN PANES ;$3)
End if 

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (2;$nbParameters))
		$area:=$1
		$panes:=$2
		
		If ($nbParameters>2)
			$sheet:=$3
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady ($area;Current method name:C684))
			C_OBJECT:C1216($params)
			$params:=New object:C1471("sheetIndex";$sheet;"panes";$panes)
			
			vp_runCommand ($area;"set-frozen-panes";$params)
		End if 
	End if 
	
	FINALLY 
	
End if 