//%attributes = {"invisible":true}
// Check that the minimal amount of parameters required for the method has been sent

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_expected; $nbParameters; $Lon_received)

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If ($nbParameters>0)
	
	$Lon_expected:=$1
	
	If ($nbParameters>1)
		
		$Lon_received:=$2
		
		$Boo_OK:=($Lon_received>=$Lon_expected)
		
		If (Not:C34($Boo_OK))
			
			// Misssing parameter (received {received}, expected {expected})
			_4D THROW ERROR:C1520(New object:C1471(\
				"component"; "4DEV"; \
				"code"; 3; \
				"received"; $Lon_received; \
				"expected"; $Lon_expected; \
				"deffered"; True:C214))
			
		End if 
	End if 
	
Else 
	
	// Misssing parameter (expected {expected})
	_4D THROW ERROR:C1520(New object:C1471(\
		"component"; "4DEV"; \
		"code"; 1; \
		"expected"; $Lon_expected; \
		"deffered"; True:C214))
	
End if 

// ----------------------------------------------------

$0:=$Boo_OK