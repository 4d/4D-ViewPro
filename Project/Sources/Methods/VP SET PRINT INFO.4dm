//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET PRINT INFO
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A125]
// Created #05-08-2019 by Francois Marchal
// ----------------------------------------------------
// Description: Sets the information to use when printing a sheet
// ----------------------------------------------------
//----- Declarations
#DECLARE($area : Text; $printInfo : Object; $sheetIndex : Integer)

If (vp_initStorage)
	
	var $nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		If ($nbParameters<3)
			$sheetIndex:=-1
		End if 
		
		If (vp_isReady($area; Current method name:C684))
			
			$printInfo:=OB Copy:C1225($printInfo)
			
			vp_make_picture($printInfo; "footerCenterImage")
			vp_make_picture($printInfo; "footerLeftImage")
			vp_make_picture($printInfo; "footerRightImage")
			vp_make_picture($printInfo; "headerCenterImage")
			vp_make_picture($printInfo; "headerLeftImage")
			vp_make_picture($printInfo; "headerRightImage")
			
			If (Value type:C1509($printInfo.paperSize)=Is object:K8:27)
				If (Value type:C1509($printInfo.paperSize.kind)=Is text:K8:3)
					ARRAY TEXT:C222($arPapers; 0)
					ARRAY LONGINT:C221($arWidth; 0)
					ARRAY LONGINT:C221($arHeight; 0)
					PRINT OPTION VALUES:C785(Paper option:K47:1; $arPapers; $arWidth; $arHeight)
					var $i : Integer
					$i:=Find in array:C230($arPapers; $printInfo.paperSize.kind)
					If ($i>0)
						If (Position:C15($printInfo.paperSize.kind; $arPapers{$i}; *)=1)
							OB REMOVE:C1226($printInfo.paperSize; "kind")
							$printInfo.paperSize.width:=Int:C8($arWidth{$i}/0.72)
							$printInfo.paperSize.height:=Int:C8($arHeight{$i}/0.72)
						End if 
					End if 
				End if 
			End if 
			
			If (Value type:C1509($printInfo.watermark)=Is collection:K8:32)
				
				var $waterMark : Object
				For each ($waterMark; $printInfo.watermark)
					If ($waterMark.imageSrc#Null:C1517)
						vp_make_picture($waterMark; "imageSrc")
					End if 
					If ($waterMark.x=Null:C1517)
						$waterMark.x:=0
					End if 
					
					If ($waterMark.y=Null:C1517)
						$waterMark.y:=0
					End if 
					
					If ($waterMark.page=Null:C1517)
						$waterMark.page:="all"
					End if 
					
				End for each 
				
			End if 
			
			vp_runCommand($area; "set-print-info"; {printInfo: $printInfo; sheetIndex: $sheetIndex})
			
		End if 
	End if 
	
	err_FINALLY
	
End if 