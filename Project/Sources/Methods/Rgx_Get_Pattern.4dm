//%attributes = {"invisible":true}
/*
Buffer := ***Rgx_Get_Pattern*** ( Pattern_Name ; Path ; Param_3 )
 -> Pattern_Name (Text)
 -> Path (Text)
 -> Param_3 (Pointer)
 <- Buffer (Text)
-
*/

var $0 : Text
var $1 : Text
var $2 : Text
var $3 : Pointer
var $Lon_Error : Integer

var $nbParameters : Integer
var $Txt_Buffer : Text
var $Txt_Element_Name : Text
var $Txt_Path : Text
var $Txt_Pattern_Name : Text
var $a16_Pattern : Text
var $a16_Patterns : Text
var $a16_Root : Text
$nbParameters:=Count parameters:C259

If ($nbParameters>0)
	
	$Txt_Pattern_Name:=$1
	
	If ($nbParameters>=2)
		$Txt_Path:=$2
	End if 
	
	If (Length:C16($Txt_Path)=0)
		$Txt_Path:=Get 4D folder:C485(_o_Extras folder:K5:12)+"regex.xml"
	End if 
	
	OK:=Num:C11(Test path name:C476($Txt_Path)=Is a document:K24:1)
	
	If (OK=1)
		$a16_Root:=DOM Parse XML source:C719($Txt_Path; False:C215)
		If (OK=1)
			$a16_Patterns:=DOM Find XML element:C864($a16_Root; "/REGEX/patterns/")
			If (OK=1)
				$a16_Pattern:=DOM Get first child XML element:C723($a16_Patterns)
				If (OK=1)
					Repeat 
						DOM GET XML ATTRIBUTE BY NAME:C728($a16_Pattern; "name"; $Txt_Element_Name)
						If ($Txt_Pattern_Name=$Txt_Element_Name)
							DOM GET XML ELEMENT VALUE:C731($a16_Pattern; $Txt_Buffer; $Txt_Buffer)
							If (Count parameters:C259>=3)
								DOM GET XML ATTRIBUTE BY NAME:C728($a16_Pattern; "groupsToExtract"; $3->)
							End if 
						Else 
							$a16_Pattern:=DOM Get next sibling XML element:C724($a16_Pattern)
						End if 
					Until ($Txt_Pattern_Name=$Txt_Element_Name) | (OK=0)
				End if 
			End if 
			DOM CLOSE XML:C722($a16_Root)
		End if 
		
		//Deleting Spaces & Comments
		$Lon_Error:=Rgx_SubstituteText("\\s*\\(\\?#[^)]*\\)|\\s"; ""; ->$Txt_Buffer)
	End if 
End if 

$0:=$Txt_Buffer