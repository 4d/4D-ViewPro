//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP get current sheet
  // Database: 4D ViewPro
  // ID[5101BAB9E3104650B8B96DB1D501A124]
  // Created #18-10-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Get the current sheet
  // ----------------------------------------------------
  //----- Declarations

C_LONGINT:C283($0)
C_TEXT:C284($1)

C_TEXT:C284($area)
C_LONGINT:C283($nbParameters)

If (False:C215)
	C_LONGINT:C283(VP get current sheet ;$0)
	C_TEXT:C284(VP get current sheet ;$1)
End if 

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (1;$nbParameters))
		
		$area:=$1
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params;$Obj_result)
			$params:=New object:C1471()
			
			$Obj_result:=vp_runFunction ($area;"get-current-sheet";$params)
			
			$0:=$Obj_result.result
		End if 
		
	End if 
	
	FINALLY 
	
End if 
