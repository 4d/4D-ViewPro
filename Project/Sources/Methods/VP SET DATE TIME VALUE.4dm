//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP SET DATE TIME VALUE
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A124]
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Set a date + time value of a range
  // ----------------------------------------------------
  // ----- Declarations

C_OBJECT:C1216($1)
C_DATE:C307($2)
C_TIME:C306($3)

C_LONGINT:C283($nbParameters)

If (False:C215)
	C_OBJECT:C1216(VP SET DATE TIME VALUE ;$1)
	C_DATE:C307(VP SET DATE TIME VALUE ;$2)
	C_TIME:C306(VP SET DATE TIME VALUE ;$3)
	C_TEXT:C284(VP SET DATE TIME VALUE ;$4)
End if 

$nbParameters:=Count parameters:C259

TRY 

If (Check_parameters_count (3;$nbParameters))
	
	C_OBJECT:C1216($obj)
	$obj:=New object:C1471("value";$2;"time";$3)
	
	If ($nbParameters>3)
		$obj.format:=$4
	Else 
		$obj.format:="_fullDateTimePattern_"
	End if 
	
	VP SET VALUE ($1;$obj)
	
End if 

FINALLY 
