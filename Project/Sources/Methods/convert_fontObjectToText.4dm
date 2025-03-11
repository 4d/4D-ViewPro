//%attributes = {"invisible":true}
/*
font := ***convert_fontObjectToText*** ( in )
 -> in (Object)
 <- font (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_fontObjectToText
// Database: Convert4DView
// ID[988F7F61282F4E0FBB77527E7D51DE4C]
// Created #6-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Convert an object font (ie. {fontName:{isDefined:bool,value:text},fontSize:{isDefined:bool,value:text}})
// To a font string: "{bold }{italic }{fontSize }{fontName}"
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_OBJECT:C1216($1)

var $Txt_buffer; $Txt_font : Text
var $Obj_in : Object
var $hasSpace : Boolean

If (False:C215)
	C_TEXT:C284(convert_fontObjectToText; $0)
	C_OBJECT:C1216(convert_fontObjectToText; $1)
End if 

// ----------------------------------------------------
// Initialisations

// Required parameters
$Obj_in:=$1
$hasSpace:=False:C215

// ----------------------------------------------------

If ($Obj_in._font#Null:C1517)
	
	// ===========================================
	// 4D View works with font names (QuickDraw) 
	// SJS is working with font families names
	// So we need to translate the font names
	// ===========================================
	If (OB Get type:C1230($Obj_in; "_font")=Is text:K8:3)
		$Txt_buffer:=$Obj_in._font
		$hasSpace:=(Position:C15(" "; $Txt_buffer)>0)
		If ($hasSpace || (Position:C15("-"; $Txt_buffer)>0))
			// Remove 'Roman' for fonts other than 'Times New Roman'
			$Txt_buffer:=Replace string:C233($Txt_buffer; " New Roman"; " New_Roman")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Roman"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " New_Roman"; " New Roman")
			
			$Txt_buffer:=Replace string:C233($Txt_buffer; " ExtraBlack"; " _ExtraBlack")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Extra"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " _ExtraBlack"; " ExtraBlack")
			
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Regular"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " CE"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " CY"; "")
			
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Condensed"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Light"; "")
			
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Caption"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Display"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " SmText"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Subhead"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; "-Book"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; "-Std"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Cond"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Smbd"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Std"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Ultralight"; "")
			$Txt_buffer:=Replace string:C233($Txt_buffer; " Slanted"; "")
			
			$Txt_buffer:=Replace string:C233($Txt_buffer; "AR DESTINE"; "Arial")
			$Txt_buffer:=Replace string:C233($Txt_buffer; "AR BERKLEY"; "Arial")
			
			If (Position:C15(" bold"; $Txt_buffer)>0)\
				 | (Position:C15("-Bold"; $Txt_buffer)>0)\
				 | (Position:C15(" black"; $Txt_buffer)>0)\
				 | (Position:C15(" ExtraBlack"; $Txt_buffer)>0)
				
				$Obj_in._bold:=True:C214
				
				$Txt_buffer:=Replace string:C233($Txt_buffer; " bold"; "")
				$Txt_buffer:=Replace string:C233($Txt_buffer; "-Bold"; "")
				$Txt_buffer:=Replace string:C233($Txt_buffer; " ExtraBlack"; "")
				$Txt_buffer:=Replace string:C233($Txt_buffer; " black"; "")
				
			End if 
			
			If (Position:C15(" italic"; $Txt_buffer)>0)\
				 | (Position:C15(" Ital"; $Txt_buffer)>0)\
				 | (Position:C15("-BookIta"; $Txt_buffer)>0)
				
				$Obj_in._italic:=True:C214
				
				$Txt_buffer:=Replace string:C233($Txt_buffer; "-BookIta"; "")
				$Txt_buffer:=Replace string:C233($Txt_buffer; " italic"; "")
				$Txt_buffer:=Replace string:C233($Txt_buffer; " Ital"; "")
				
			End if 
			
			$hasSpace:=(Position:C15(" "; $Txt_buffer)>0)
			$Obj_in._font:=$Txt_buffer
			
		End if 
		
	End if 
End if 

If ($Obj_in._italic#Null:C1517)
	
	$Txt_font:="italic"
	
End if 

If ($Obj_in._bold#Null:C1517)
	
	If (Length:C16($Txt_font)>0)
		
		$Txt_font+=Char:C90(Space:K15:42)
		
	End if 
	
	$Txt_font+="bold"
	
End if 

If ($Obj_in._size#Null:C1517)
	
	If (Length:C16($Txt_font)>0)
		
		$Txt_font+=Char:C90(Space:K15:42)
		
	End if 
	
	$Txt_font+=$Obj_in._size
	
End if 

If ($Obj_in._font#Null:C1517)
	
	If (OB Get type:C1230($Obj_in; "_font")=Is text:K8:3)
		
		If (Length:C16($Txt_font)>0)
			
			$Txt_font+=Char:C90(Space:K15:42)
			
		End if 
		
		// Font names with a space must be quoted
		$Txt_font+=$hasSpace ? ("'"+$Obj_in._font+"'") : $Obj_in._font
		
		If ($Obj_in._font#"Arial")
			$Txt_font+=",Arial"
		End if 
		
	End if 
	
End if 

// ----------------------------------------------------
// Return
$0:=$Txt_font

// ----------------------------------------------------
// End