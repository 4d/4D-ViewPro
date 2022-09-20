//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP Name
  // Database: 4D ViewPro
  // ID[5101BAB9EE104650B8B95DB1D501A124]
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Create a target for a named range
  // ----------------------------------------------------
  // ----- Declarations

C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)

C_TEXT:C284($area)
C_TEXT:C284($name)
C_LONGINT:C283($sheet)
C_LONGINT:C283($nbParameters)

If (False:C215)
	C_OBJECT:C1216(VP Name ;$0)
	C_TEXT:C284(VP Name ;$1)
	C_TEXT:C284(VP Name ;$2)
	C_LONGINT:C283(VP Name ;$3)
End if 

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (2;$nbParameters))
		
		$area:=$1
		$name:=$2
		
		If (Length:C16($name)=0)
			THROW (New object:C1471("code";18))
		Else 
			
			If ($nbParameters>2)
				
				$sheet:=$3
				
			Else 
				
				$sheet:=-1
				
			End if 
			
			If ($sheet<-2)
				THROW (New object:C1471("code";17))
			Else 
				
				C_OBJECT:C1216($ranges)
				
				$ranges:=New object:C1471()
				
				If ($sheet#-1)
					$ranges.sheet:=$sheet
				End if 
				
				$ranges.name:=$name
				
				$0:=New object:C1471(\
					"area";$area;\
					"ranges";New collection:C1472($ranges))
				
				vp_addRangeFormulas ($0)
				
			End if 
		End if 
	End if 
	
	FINALLY 
	
End if 