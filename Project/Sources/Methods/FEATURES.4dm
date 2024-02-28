//%attributes = {"invisible":true}

/*========================================================================

SEE THE COMPONENT README FOR THE DESCRIPTION OF THE FEATURES

========================================================================*/

var Feature : cs:C1710._feature

If (Feature=Null:C1517)
	
	var $version : Integer
	$version:=2050  // 20R5
	
	If ($version>Num:C11(Application version:C493()))
		
		ALERT:C41("The current 4D version ("+Application version:C493+") is lower than the internal version ("+String:C10($version)+").\r\rYou need to fix this!")
		METHOD OPEN PATH:C1213(Current method name:C684; 14; *)
		ABORT:C156
		
	End if 
	
	Feature:=cs:C1710._feature.new($version)
	
	// MARK:-2️⃣0️⃣
	// FIXME:R5
	Feature.unstable("GET_OBJECTS")  // github:4255
	Feature.unstable("SET_OBJECTS")
	
	// MARK:-🚧 Main only
	Feature.main("OBJECT_API")
	
End if 