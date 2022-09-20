//%attributes = {"invisible":true,"shared":true}
// register the given font collection so they will be available for PDF export

C_TEXT:C284($1)
C_COLLECTION:C1488($2)

C_TEXT:C284($area)
C_LONGINT:C283($nbParameters)
C_COLLECTION:C1488($fonts)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$area:=$1
		$fonts:=$2
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($font; $element; $params)
			C_BLOB:C604($blob)
			C_TEXT:C284($txt)
			C_LONGINT:C283($i)
			
			$params:=New object:C1471("fonts"; New collection:C1472)
			
			ARRAY TEXT:C222($ar; 0)
			APPEND TO ARRAY:C911($ar; "normal")
			APPEND TO ARRAY:C911($ar; "italic")
			APPEND TO ARRAY:C911($ar; "bold")
			APPEND TO ARRAY:C911($ar; "bolditalic")
			
			For each ($element; $fonts)
				
				$font:=New object:C1471("name"; $element.font; "font"; Null:C1517)
				
				For ($i; 1; Size of array:C274($ar))
					// convert paths to font file to base64 text
					If (Value type:C1509($element[$ar{$i}])=Is text:K8:3)
						DOCUMENT TO BLOB:C525($element[$ar{$i}]; $blob)
						If (ok=1)
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
	
	FINALLY
	
End if 