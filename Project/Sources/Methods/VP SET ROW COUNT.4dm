//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP SET ROW COUNT
  // Database: 4D ViewPro
  // ID[5101AAB9EE104650B8B96DB1D581A124]
  // Created #18-10-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: set sheet name
  // ----------------------------------------------------
  //----- Declarations

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_LONGINT:C283($Lon_rowCount)
C_LONGINT:C283($Lon_sheetIndex)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_TEXT:C284(VP SET ROW COUNT ;$1)
	C_LONGINT:C283(VP SET ROW COUNT ;$2)
	C_LONGINT:C283(VP SET ROW COUNT ;$3)
End if 

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (2;$nbParameters))
		
		$area:=$1
		$Lon_rowCount:=$2
		
		If ($nbParameters>2)
			$Lon_sheetIndex:=$3
		Else 
			$Lon_sheetIndex:=-1
		End if 
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471("rowCount";$Lon_rowCount;"sheetIndex";$Lon_sheetIndex)
			
			vp_runCommand ($area;"set-row-count";$params)
			
		End if 
	End if 
	
	FINALLY 
	
End if 