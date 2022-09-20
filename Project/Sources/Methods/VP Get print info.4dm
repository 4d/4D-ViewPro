//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP Get print info
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #03-06-2019 by Francois Marchal
// ----------------------------------------------------
// Description: 
// ----------------------------------------------------
// ----- Declarations

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_OBJECT:C1216($0)

C_TEXT:C284($area)
C_LONGINT:C283($nbParameters)
C_LONGINT:C283($sheet)

If (False:C215)
	C_TEXT:C284(VP Get selection; $1)
	C_LONGINT:C283(VP Get selection; $2)
	C_OBJECT:C1216(VP Get selection; $0)
End if 

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	TRY
	
	If (Check_parameters_count(1; $nbParameters))
		
		$area:=$1
		
		If ($nbParameters>1)
			$sheet:=$2
		Else 
			$sheet:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($printInfo; $params)
			$params:=New object:C1471("sheetIndex"; $sheet)
			$printInfo:=vp_runFunction($area; "get-print-info"; $params)
			
			vp_get_picture($printInfo; "footerCenterImage")
			vp_get_picture($printInfo; "footerLeftImage")
			vp_get_picture($printInfo; "footerRightImage")
			vp_get_picture($printInfo; "headerCenterImage")
			vp_get_picture($printInfo; "headerLeftImage")
			vp_get_picture($printInfo; "headerRightImage")
			
			If (Value type:C1509($printInfo.paperSize)=Is object:K8:27)
				If (($printInfo.paperSize.kind="custom")\
					 & vp_isNumeric($printInfo.paperSize.width)\
					 & vp_isNumeric($printInfo.paperSize.height))
					ARRAY TEXT:C222($arPapers; 0)
					ARRAY LONGINT:C221($arWidth; 0)
					ARRAY LONGINT:C221($arHeight; 0)
					PRINT OPTION VALUES:C785(Paper option:K47:1; $arPapers; $arWidth; $arHeight)
					C_LONGINT:C283($i)
					For ($i; 1; Size of array:C274($arPapers))
						If (($printInfo.paperSize.width=Int:C8($arWidth{$i}/0.72))\
							 & ($printInfo.paperSize.height=Int:C8($arHeight{$i}/0.72)))
							$printInfo.paperSize.kind:=$arPapers{$i}
							$i:=Size of array:C274($arPapers)
						End if 
					End for 
				End if 
			End if 
			
			$0:=$printInfo
			
		End if 
	End if 
	
	FINALLY
	
End if 