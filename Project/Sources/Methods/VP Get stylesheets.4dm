//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get stylesheets
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: get list of stylesheets for a specified sheet or for the whole workbook
// ----------------------------------------------------
//----- Declarations

C_COLLECTION:C1488($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($area)
C_LONGINT:C283($sheet)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_COLLECTION:C1488(VP Get stylesheets; $0)
	C_TEXT:C284(VP Get stylesheets; $1)
	C_LONGINT:C283(VP Get stylesheets; $2)
End if 

// ----------------------------------------------------

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			$sheet:=$2
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			$params.sheetIndex:=$sheet
			
			C_OBJECT:C1216($Obj_result)
			$Obj_result:=vp_runFunction($area; "get-stylesheets"; $params)
			
			C_COLLECTION:C1488($result)
			$result:=$Obj_result.collection
			
			C_OBJECT:C1216($stylesheet)
			
			$0:=New collection:C1472()
			
			For each ($stylesheet; $result)
				$0.push(vp_convert_from_stylesheet($stylesheet))
			End for each 
			
		End if 
	End if 
	
	err_FINALLY
	
End if 