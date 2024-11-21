//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SHOW CELL
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #03-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)
C_LONGINT:C283($2; $3)

C_OBJECT:C1216($ranges)


C_OBJECT:C1216($params)
C_LONGINT:C283($Lon_hPos; $Lon_vPos)

If (False:C215)
	C_OBJECT:C1216(VP SHOW CELL; $1)
	C_LONGINT:C283(VP SHOW CELL; $2)
	C_LONGINT:C283(VP SHOW CELL; $3)
End if 

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		$ranges:=$1
		var $area : Text:=$ranges.area
		$Lon_vPos:=$2
		$Lon_hPos:=$3
		
		If (vp_isReady($area; Current method name:C684))
			
			If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
				$params:=New object:C1471
				$params.ranges:=$ranges.ranges
				$params.verticalPosition:=$Lon_vPos
				$params.horizontalPosition:=$Lon_hPos
				
				vp_runCommand($area; "show-cell"; $params)
			End if 
		End if 
	End if 
	err_FINALLY
End if 