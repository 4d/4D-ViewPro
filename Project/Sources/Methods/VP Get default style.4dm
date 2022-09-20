//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP Get default style
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A125]
  // Created #16-10-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: get the default style for a specified sheet 
  // ----------------------------------------------------
  //----- Declarations

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($area)
C_LONGINT:C283($sheet)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_OBJECT:C1216(VP Get default style ;$0)
	C_TEXT:C284(VP Get default style ;$1)
	C_LONGINT:C283(VP Get default style ;$2)
End if 

  // ----------------------------------------------------

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
			
			C_OBJECT:C1216($params;$stylesheet)
			$params:=New object:C1471()
			$params.sheetIndex:=$sheet
			
			$stylesheet:=vp_runFunction ($area;"get-default-style";$params)
			
			$0:=vp_convert_from_stylesheet ($stylesheet)
			
		End if 
	End if 
	
	FINALLY 
	
End if 