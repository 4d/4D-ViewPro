//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP RESET SELECTION
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A125]
  // Created #03-06-2019 by Francois Marchal
  // ----------------------------------------------------
  // Description: 
  // ----------------------------------------------------
  // ----- Declarations

C_TEXT:C284($1)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)
C_LONGINT:C283($sheet)


If (False:C215)
	C_TEXT:C284(VP RESET SELECTION ;$1)
	C_LONGINT:C283(VP RESET SELECTION ;$2)
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
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("sheetIndex";$sheet)
			
			vp_runCommand ($area;"reset-selection";$params)
		End if 
	End if 
	
	FINALLY 
	
End if 