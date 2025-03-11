//%attributes = {"invisible":true}
/*
color := ***convert_foreColor*** ( foreColor ; cell )
 -> foreColor (Object)
 -> cell (Object)
 <- color (Text)
________________________________________________________
*/
// ----------------------------------------------------
// Project method : convert_foreColor
// Database: Convert4DView
// ID[8B34CDFEC0D84B358DC30CFDF0A7469C]
// Created #29-9-2017 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Convert minusColorOdd, minusColorEven, zeroColorOdd, zeroColorEven by taking
// into account  the row's value or if it's odd or even row
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

C_TEXT:C284($Txt_color; $Zero_color; $Negative_color)
C_OBJECT:C1216($Obj_cell; $Obj_style; $Obj_foreColor)

If (False:C215)
	C_TEXT:C284(convert_foreColor; $0)
	C_OBJECT:C1216(convert_foreColor; $1)
	C_OBJECT:C1216(convert_foreColor; $2)
	C_OBJECT:C1216(convert_foreColor; $3)
End if 

// ----------------------------------------------------
// Initialisations

$Obj_style:=$1
$Obj_foreColor:=$2
$Obj_cell:=$3
// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (($Obj_cell.valueType=Null:C1517) || (String:C10($Obj_cell.valueType)="real") || (String:C10($Obj_cell.valueType)="hour"))
		
		
		If (Num:C11($Obj_foreColor._zeroColorEven)=Num:C11($Obj_foreColor._zeroColorOdd))\
			 || ((($Obj_cell.row-1)%2)=0)  // Both or even line
			
			$Zero_color:=convert_color(Num:C11($Obj_foreColor._zeroColorOdd); True:C214)
			
		Else 
			
			$Zero_color:=convert_color(Num:C11($Obj_foreColor._zeroColorEven); True:C214)
			
		End if 
		
		
		If (Num:C11($Obj_foreColor._minusColorEven)=Num:C11($Obj_foreColor._minusColorOdd))\
			 || ((($Obj_cell.row-1)%2)=0)  // Both or even line
			
			$Negative_color:=convert_color(Num:C11($Obj_foreColor._minusColorOdd); True:C214)
			
		Else 
			
			$Negative_color:=convert_color(Num:C11($Obj_foreColor._minusColorEven); True:C214)
			
		End if 
		
		//…………………………………………………………………………………………………………
		
		If (Num:C11($Obj_foreColor._normalColorEven)=Num:C11($Obj_foreColor._normalColorOdd))\
			 || ((($Obj_cell.row-1)%2)=0)  // Both or even line
			
			$Txt_color:=convert_color(Num:C11($Obj_foreColor._normalColorOdd); True:C214)
			
		Else 
			
			$Txt_color:=convert_color(Num:C11($Obj_foreColor._normalColorEven); True:C214)
			
		End if 
		
		//…………………………………………………………………………………………………………
		
		//______________________________________________________
	Else 
		
		If (Num:C11($Obj_foreColor._normalColorEven)=Num:C11($Obj_foreColor._normalColorOdd))\
			 || (((Num:C11($Obj_cell.row)-1)%2)=0)  // Both or even line
			
			$Txt_color:=convert_color(Num:C11($Obj_foreColor._normalColorOdd); True:C214)
			
		Else 
			
			$Txt_color:=convert_color(Num:C11($Obj_foreColor._normalColorEven); True:C214)
			
		End if 
		
		//______________________________________________________
End case 

C_TEXT:C284($format; $newFormat)
$format:=$Obj_style.formatter

If (Not:C34((Length:C16($format)=1) & (Character code:C91($format)=64)))
	
	C_BOOLEAN:C305($isHour)
	
	$isHour:=(String:C10($Obj_cell.valueType)="hour") | (($Obj_cell.valueType=Null:C1517) & (Position:C15("[h"; $format)=1))
	
	If ($format="")
		If ($isHour)
			$format:="[h]:mm:ss"
		Else 
			$format:="General"
		End if 
	End if 
	
	C_LONGINT:C283($pos_semicolon; $pos_semicolon2)
	$pos_semicolon:=Position:C15(";"; $format)
	
	If ($pos_semicolon=0)
		If ($isHour)
			If (($Zero_color#"") & ($Zero_color#"black"))
				$newFormat:="[=0]["+$Zero_color+"]"+$format+";"+$format
			End if 
		Else 
			If (($Negative_color#"") & ($Negative_color#"black"))
				$newFormat:=$format+";["+$Negative_color+"]-"+$format
			End if 
			
			If (($Zero_color#"") & ($Zero_color#"black"))
				If ($newFormat="")
					$newFormat:=$format+";-"+$format
				End if 
				$newFormat:=$newFormat+";["+$Zero_color+"]"+$format
			End if 
		End if 
	Else 
		
		C_TEXT:C284($positiveFormat; $negativeFormat; $zeroFormat)
		
		$positiveFormat:=Substring:C12($Format; 1; $pos_semicolon-1)
		
		$pos_semicolon2:=Position:C15(";"; $format; $pos_semicolon+1)
		
		If ($pos_semicolon2=0)
			$negativeFormat:=Substring:C12($format; $pos_semicolon+1)
		Else 
			$negativeFormat:=Substring:C12($format; $pos_semicolon+1; $pos_semicolon2-$pos_semicolon-1)
			$zeroFormat:=Substring:C12($format; $pos_semicolon2+1)
		End if 
		
		If ($isHour)
			If (($Zero_color#"") & ($Zero_color#"black"))
				$newFormat:="[=0]["+$Zero_color+"]"+$zeroFormat+";"+$positiveFormat
			End if 
		Else 
			
			$newFormat:=$positiveFormat+";"
			
			If (($Negative_color#"") & ($Negative_color#"black"))
				$newFormat:=$newFormat+"["+$Negative_color+"]"
			End if 
			
			If ($negativeFormat#"")
				$newFormat:=$newFormat+$negativeFormat
			End if 
			
			If ($pos_semicolon2#0)
				
				$newFormat:=$newFormat+";"
				
				If (($Zero_color#"") & ($Zero_color#"black"))
					$newFormat:=$newFormat+"["+$Zero_color+"]"
				End if 
				
				If ($zeroFormat#"")
					$newFormat:=$newFormat+$zeroFormat
				End if 
			Else 
				If (($zero_color#"") & ($Zero_color#"black"))
					$newFormat:=$newFormat+";["+$Zero_color+"]"+$positiveFormat
				End if 
			End if 
		End if 
	End if 
	
	If ($newFormat#"")
		$Obj_style.formatter:=$newFormat
	End if 
	
End if 
// ----------------------------------------------------
// Return
$0:=$Txt_color

// ----------------------------------------------------
// End