//%attributes = {"invisible":true,"shared":true}
#DECLARE($area : Text; $options : Object)

If (Not:C34(vp_initStorage))
	
	return 
	
End if 

err_TRY

Case of 
		
		//______________________________________________________
	: (Not:C34(Check_parameters_count(2; Count parameters:C259)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	: (Not:C34(vp_isReady($area; Current method name:C684)))
		
		// <NOTHING MORE TO DO>
		//______________________________________________________
	Else 
		
		// We must keep parameters for later use
		// when the asynchronous export will be ending
		
		// Is there a user callback method to execute ?
		If ($options.formula=Null:C1517)
			
			// mark:ACI0105390
			err_THROW({code: 24; parameter: "formula"})
			
		Else 
			
			// Keep the export file destination pathname
			var $callback:=vp_newCallback("export-blob"; $area; $options)
			$callback.sjsOptions:=OB Copy:C1225($options)
			OB REMOVE:C1226($callback.sjsOptions; "formula")
			
			vp_runFunction($area; "export-sjs"; $callback)
			
		End if 
		
		//______________________________________________________
End case 

err_FINALLY