//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP SET DEFAULT STYLE
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A125]
  // Created #16-10-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Set the default style for a specified sheet
  // ----------------------------------------------------
  //----- Declarations

C_TEXT:C284($1)
C_OBJECT:C1216($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_OBJECT:C1216($Obj_stylesheet)
C_LONGINT:C283($sheet)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP SET DEFAULT STYLE ;$1)
	C_OBJECT:C1216(VP SET DEFAULT STYLE ;$2)
	C_LONGINT:C283(VP SET DEFAULT STYLE ;$3)
End if 

  // ----------------------------------------------------

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (2;$nbParameters))
		
		$area:=$1
		$Obj_stylesheet:=$2
		
		If ($nbParameters>2)
			$sheet:=$3
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			$params.stylesheet:=vp_convert_to_stylesheet ($Obj_stylesheet)
			$params.sheetIndex:=$sheet
			
			vp_runCommand ($area;"set-default-style";$params)
			
		End if 
	End if 
	
	FINALLY 
	
End if 