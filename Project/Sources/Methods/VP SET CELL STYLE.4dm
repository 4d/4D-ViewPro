//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET DEFAULT STYLE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #16-10-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the style for a specified range
// ----------------------------------------------------
//----- Declarations

C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

C_OBJECT:C1216($cell)
C_OBJECT:C1216($Obj_style)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($area)

If (False:C215)
	C_OBJECT:C1216(VP SET CELL STYLE; $1)
	C_OBJECT:C1216(VP SET CELL STYLE; $2)
End if 

// ----------------------------------------------------

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$cell:=$1
		$area:=$cell.area
		
		If (vp_isReady($area; Current method name:C684))
			
			$Obj_style:=vp_convert_to_stylesheet($2)
			
			If (Value type:C1509($cell.ranges)=Is collection:K8:32)
				C_OBJECT:C1216($params)
				$params:=New object:C1471()
				$params.ranges:=$cell.ranges
				$params.style:=$Obj_style
				vp_runCommand($area; "set-cell-style"; $params)
				
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 