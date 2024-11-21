//%attributes = {"invisible":true,"shared":true}
// register the given font collection so they will be available for PDF export
#DECLARE($area : Text; $fonts : Collection)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If (vp_isReady($area; Current method name:C684))
			
			var $params:=New object:C1471("fonts"; New collection:C1472)
			
			ARRAY TEXT:C222($ar; 0)
			APPEND TO ARRAY:C911($ar; "normal")
			APPEND TO ARRAY:C911($ar; "italic")
			APPEND TO ARRAY:C911($ar; "bold")
			APPEND TO ARRAY:C911($ar; "bolditalic")
			
			var $element : Object
			For each ($element; $fonts)
				
				var $font:=New object:C1471("name"; $element.font; "font"; Null:C1517)
				
				var $i : Integer
				For ($i; 1; Size of array:C274($ar))
					// convert paths to font file to base64 text
					If (Value type:C1509($element[$ar{$i}])=Is text:K8:3)
						var $blob : Blob
						DOCUMENT TO BLOB:C525($element[$ar{$i}]; $blob)
						If (ok=1)
							var $txt : Text
							BASE64 ENCODE:C895($blob; $txt)
							If ($font.font=Null:C1517)
								$font.font:=New object:C1471
							End if 
							$font.font[$ar{$i}]:=$txt
						End if 
					End if 
				End for 
				
				$params.fonts.push($font)
				
			End for each 
			
			
			vp_runCommand($area; "register-pdf-fonts"; $params)
			
		End if 
	End if 
	
	err_FINALLY
	
End if 