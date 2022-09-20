//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP ADD STYLE SHEET
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A125]
  // Created #16-10-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Add a style sheet for a specified sheet or for the whole workbook
  // ----------------------------------------------------
  //----- Declarations

C_TEXT:C284($1)
C_TEXT:C284($2)
C_OBJECT:C1216($3)
C_LONGINT:C283($4)

C_TEXT:C284($area)
C_TEXT:C284($name)
C_OBJECT:C1216($Obj_stylesheet)
C_LONGINT:C283($sheet)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP ADD STYLESHEET ;$1)
	C_TEXT:C284(VP ADD STYLESHEET ;$2)
	C_OBJECT:C1216(VP ADD STYLESHEET ;$3)
	C_LONGINT:C283(VP ADD STYLESHEET ;$4)
End if 

  // ----------------------------------------------------

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (3;$nbParameters))
		
		$area:=$1
		$name:=$2
		$Obj_stylesheet:=$3
		
		If ($nbParameters>3)
			$sheet:=$4
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			$params.name:=$name
			$params.stylesheet:=vp_convert_to_stylesheet ($Obj_stylesheet)
			$params.sheetIndex:=$sheet
			
			vp_runCommand ($area;"add-stylesheet";$params)
			
		End if 
	End if 
	
	FINALLY 
	
End if 