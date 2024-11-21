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
#DECLARE($cell : Object; $fieldPointer : Pointer; $format : Text)

var $nbParameters:=Count parameters:C259

err_TRY

If (Check_parameters_count(2; Count parameters:C259))
	
	var $txt_nomVar : Text
	var $Lon_table; $Lon_field : Integer
	RESOLVE POINTER:C394($fieldPointer; $txt_nomVar; $Lon_table; $Lon_field)
	
	If (($Lon_table>0) & ($Lon_field>0))
		ARRAY TEXT:C222($array_tablesTitles; 0)
		ARRAY LONGINT:C221($array_tablesNums; 0)
		GET TABLE TITLES:C803($array_tablesTitles; $array_tablesNums)
		
		var $Lon_tableIndex:=Find in array:C230($array_tablesNums; $Lon_table)
		
		If ($Lon_tableIndex#-1)
			
			ARRAY TEXT:C222($array_fieldsTitles; 0)
			ARRAY LONGINT:C221($array_fieldsNums; 0)
			GET FIELD TITLES:C804(Table:C252($Lon_table)->; $array_fieldsTitles; $array_fieldsNums)
			
			var $Lon_fieldIndex:=Find in array:C230($array_fieldsNums; $Lon_field)
			
			If ($Lon_fieldIndex#-1)
				var $Txt_formula:=$array_tablesTitles{$Lon_tableIndex}\
					+"_"\
					+$array_fieldsTitles{$Lon_fieldIndex}\
					+"()"
				
				If ($nbParameters>2)
					VP SET FORMULA($cell; $Txt_formula; $format)
				Else 
					VP SET FORMULA($cell; $Txt_formula)
				End if 
			End if 
			
		End if 
	End if 
End if 

err_FINALLY


