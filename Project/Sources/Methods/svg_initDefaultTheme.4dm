//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($themeName;$1)

$themeName:=$1

Case of 
	: ($themeName="Office")
		
		theme:=New object:C1471
		theme.themeColor:=New object:C1471
		
		theme.name:="Office"
		theme.themeColor["text1"]:=New object:C1471("r";0;"g";0;"b";0)
		theme.themeColor["text2"]:=New object:C1471("r";68;"g";84;"b";106)
		theme.themeColor["background1"]:=New object:C1471("r";255;"g";255;"b";255)
		theme.themeColor["background2"]:=New object:C1471("r";231;"g";230;"b";230)
		theme.themeColor["accent1"]:=New object:C1471("r";91;"g";155;"b";213)
		theme.themeColor["accent2"]:=New object:C1471("r";237;"g";125;"b";49)
		theme.themeColor["accent3"]:=New object:C1471("r";165;"g";165;"b";165)
		theme.themeColor["accent4"]:=New object:C1471("r";255;"g";192;"b";0)
		theme.themeColor["accent5"]:=New object:C1471("r";68;"g";114;"b";196)
		theme.themeColor["accent6"]:=New object:C1471("r";112;"g";173;"b";71)
		theme.themeColor["ayperlink"]:=New object:C1471("r";5;"g";99;"b";193)
		theme.themeColor["followedHyperlink"]:=New object:C1471("r";149;"g";79;"b";114)
		theme["headingFont"]:="Calibri light"
		theme["bodyFont"]:="Calibri"
		
	: ($themeName="Office2007")
		
		theme:=New object:C1471
		theme.themeColor:=New object:C1471
		
		theme.name:="Office"
		theme.themeColor["text1"]:=New object:C1471("r";0;"g";0;"b";0)
		theme.themeColor["text2"]:=New object:C1471("r";68;"g";84;"b";106)
		theme.themeColor["background1"]:=New object:C1471("r";255;"g";255;"b";255)
		theme.themeColor["background2"]:=New object:C1471("r";231;"g";230;"b";230)
		theme.themeColor["accent1"]:=New object:C1471("r";91;"g";155;"b";213)
		theme.themeColor["accent2"]:=New object:C1471("r";237;"g";125;"b";49)
		theme.themeColor["accent3"]:=New object:C1471("r";165;"g";165;"b";165)
		theme.themeColor["accent4"]:=New object:C1471("r";255;"g";192;"b";0)
		theme.themeColor["accent5"]:=New object:C1471("r";68;"g";114;"b";196)
		theme.themeColor["accent6"]:=New object:C1471("r";112;"g";173;"b";71)
		theme.themeColor["ayperlink"]:=New object:C1471("r";5;"g";99;"b";193)
		theme.themeColor["followedHyperlink"]:=New object:C1471("r";149;"g";79;"b";114)
		theme["headingFont"]:="Calibri light"
		theme["bodyFont"]:="Calibri"
End case 