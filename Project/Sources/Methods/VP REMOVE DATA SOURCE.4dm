//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $name : Text)

If (vp_initStorage)

	var $nbParameters:=Count parameters:C259

	err_TRY

	If (Check_parameters_count(2; $nbParameters))

		If (vp_isReady($area; Current method name:C684))

			vp_runCommand($area; "remove-data-source"; {name: $name})

		End if
	End if

	err_FINALLY

End if
