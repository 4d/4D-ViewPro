//%attributes = {"invisible":true,"shared":true}
// The VP ADD FORMULA NAME command creates or modifies a named formula in the open document.

C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_OBJECT:C1216($4)

C_TEXT:C284($formula)
C_TEXT:C284($area)
C_TEXT:C284($name)
C_OBJECT:C1216($options)

C_LONGINT:C283($nbParameters)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(3; $nbParameters))
		
		$area:=$1
		$formula:=$2
		$name:=$3
		
		If ($nbParameters>3)
			$options:=$4
		Else 
			$options:=New object:C1471("scope"; -1)
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			$params.formula:=$formula
			$params.name:=$name
			$params.options:=$options
			
			vp_runCommand($area; "add-formula-name"; $params)
			
		End if 
		
	End if 
	
	err_FINALLY
	
End if 