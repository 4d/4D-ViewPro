//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get style sheet
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get a style sheet for a specified sheet or for the whole workbook
// ----------------------------------------------------
//----- Declarations

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_TEXT:C284($name)
C_LONGINT:C283($sheet)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_OBJECT:C1216(VP Get stylesheet; $0)
	C_TEXT:C284(VP Get stylesheet; $1)
	C_TEXT:C284(VP Get stylesheet; $2)
	C_LONGINT:C283(VP Get stylesheet; $3)
End if 

// ----------------------------------------------------

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$name:=$2
		
		If ($nbParameters>2)
			$sheet:=$3
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params; $stylesheet)
			$params:=New object:C1471()
			$params.name:=$name
			$params.sheetIndex:=$sheet
			
			$stylesheet:=vp_runFunction($area; "get-stylesheet"; $params)
			
			$0:=vp_convert_from_stylesheet($stylesheet)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 