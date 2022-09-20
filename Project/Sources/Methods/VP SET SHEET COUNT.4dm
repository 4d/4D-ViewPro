//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP SET SHEET COUNT
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B96DB1D501A124]
  // Created #18-10-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Set the number of sheets
  // ----------------------------------------------------
  //----- Declarations

C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($area)
C_LONGINT:C283($count)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP SET SHEET COUNT ;$1)
	C_LONGINT:C283(VP SET SHEET COUNT ;$2)
End if 

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (2;$nbParameters))
		
		$area:=$1
		$count:=$2
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("count";$count)
			
			vp_runCommand ($area;"set-sheet-count";$params)
			
		End if 
	End if 
	
	FINALLY 
	
End if 