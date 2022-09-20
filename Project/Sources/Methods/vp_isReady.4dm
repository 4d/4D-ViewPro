//%attributes = {"invisible":true}
/*
OK := ***vp_isReady*** ( vpAreaName ; command )
 -> vpAreaName (Text)
 -> command (Text)
 <- OK (Boolean)
________________________________________________________
*/

C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($nbParameters)
C_TEXT:C284($commandName; $area)

// ----------------------------------------------------
// Initialisations
$nbParameters:=Count parameters:C259

If (Asserted:C1132($nbParameters>=2; "Missing parameter"))
	
	//Required parameters
	$area:=$1
	$commandName:=$2
	
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

C_OBJECT:C1216($obj)
$obj:=vp_getAreaVariable($area)

If ($obj=Null:C1517)
	
	$0:=False:C215
	
	_4D THROW ERROR:C1520(New object:C1471(\
		"component"; "4DEV"; \
		"code"; 5; \
		"object"; $area; \
		"deffered"; True:C214))
	
Else 
	
	$0:=$obj.inited
	
	If (Not:C34($0))
		
		THROW(New object:C1471(\
			"code"; 5; \
			"object"; $area; \
			"command"; $commandName))
		
	End if 
End if 