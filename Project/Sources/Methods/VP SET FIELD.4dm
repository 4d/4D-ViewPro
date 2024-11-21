//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET FIELD
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the formula of a range
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)
C_POINTER:C301($2)
C_TEXT:C284($3)



If (False:C215)
	C_OBJECT:C1216(VP SET FIELD; $1)
	C_POINTER:C301(VP SET FIELD; $2)
	C_TEXT:C284(VP SET FIELD; $3)
End if 

var $nbParameters:=Count parameters:C259

err_TRY

If (Check_parameters_count(2; $nbParameters))
	
	C_TEXT:C284($txt_nomVar)
	C_LONGINT:C283($Lon_table; $Lon_field)
	RESOLVE POINTER:C394($2; $txt_nomVar; $Lon_table; $Lon_field)
	
	If (($Lon_table>0) & ($Lon_field>0))
		ARRAY TEXT:C222($array_tablesTitles; 0)
		ARRAY LONGINT:C221($array_tablesNums; 0)
		GET TABLE TITLES:C803($array_tablesTitles; $array_tablesNums)
		
		C_LONGINT:C283($Lon_tableIndex)
		$Lon_tableIndex:=Find in array:C230($array_tablesNums; $Lon_table)
		
		If ($Lon_tableIndex#-1)
			
			ARRAY TEXT:C222($array_fieldsTitles; 0)
			ARRAY LONGINT:C221($array_fieldsNums; 0)
			GET FIELD TITLES:C804(Table:C252($Lon_table)->; $array_fieldsTitles; $array_fieldsNums)
			
			C_LONGINT:C283($Lon_fieldIndex)
			$Lon_fieldIndex:=Find in array:C230($array_fieldsNums; $Lon_field)
			
			If ($Lon_fieldIndex#-1)
				C_TEXT:C284($Txt_formula)
				$Txt_formula:=$array_tablesTitles{$Lon_tableIndex}\
					+"_"\
					+$array_fieldsTitles{$Lon_fieldIndex}\
					+"()"
				
				If ($nbParameters>2)
					VP SET FORMULA($1; $Txt_formula; $3)
				Else 
					VP SET FORMULA($1; $Txt_formula)
				End if 
			End if 
			
		End if 
	End if 
End if 

err_FINALLY


