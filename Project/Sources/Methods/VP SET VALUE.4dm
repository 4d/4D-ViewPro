//%attributes = {"invisible":true,"shared":true}
//%attributes = {"invisible":true,"shared":true}
// ----------------------------------------------------
// Project method : VP SET VALUE
// Database: 4D ViewPro
// ID[5101BAB9EE104650B8B95DB1D501A124]
// Created #12-7-2018 by Francois Marchal
// ----------------------------------------------------
// Description: Set the value of a range
// ----------------------------------------------------
// ----- Declarations

C_OBJECT:C1216($1)
C_OBJECT:C1216($2)

If (False:C215)
	C_OBJECT:C1216(VP SET VALUE; $1)
	C_OBJECT:C1216(VP SET VALUE; $2)
End if 

C_LONGINT:C283($nbParameters)

C_OBJECT:C1216($ranges; $Obj_value)
C_TEXT:C284($area)

If (vp_initStorage)
	
	$nbParameters:=Count parameters:C259
	
	err_TRY
	
	If (Check_parameters_count(2; $nbParameters))
		
		$ranges:=$1
		$Obj_value:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady($area; Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471(\
				)
			
			C_LONGINT:C283($Lon_type)
			
			$Lon_type:=Value type:C1509($Obj_value.value)
			
			Case of 
					
				: (($Lon_type=Is boolean:K8:9)\
					 | ($Lon_type=Is text:K8:3)\
					 | ($Lon_type=Is real:K8:4))
					
					$params.value:=$Obj_value.value
					
					//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($Lon_type=Is date:K8:7)
					
					$params.value:=New object:C1471(\
						)
					C_DATE:C307($date)
					$date:=Date:C102($Obj_value.value)
					$params.value.day:=Day of:C23($date)
					$params.value.month:=Month of:C24($date)
					$params.value.year:=Year of:C25($date)
					
					//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
				: ($Lon_type=Is null:K8:31)
					
					$params.value:=Null:C1517
					
					//┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅┅
			End case 
			
			If (Value type:C1509($Obj_value.time)=Is real:K8:4)
				
				If ($params.value=Null:C1517)
					
					$params.value:=New object:C1471(\
						)
					
				End if 
				
				If (Value type:C1509($params.value)=Is object:K8:27)
					
					C_TIME:C306($time)
					$time:=Time:C179($Obj_value.time)
					$params.value.hours:=$time\3600
					$params.value.minutes:=($time%3600)\60
					$params.value.seconds:=$time%60
					
				End if 
			End if 
			
			If (OB Is defined:C1231($params; "value"))
				
				If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
					
					$params.ranges:=$ranges.ranges
					
					// Optional format
					If ($Obj_value.format#Null:C1517)
						
						If (Value type:C1509($Obj_value.format)=Is text:K8:3)
							
							$params.format:=$Obj_value.format
							
						End if 
					End if 
					
					vp_runCommand($area; "set-ranges-value"; $params)
					
				End if 
			End if 
		End if 
	End if 
	
	err_FINALLY
	
End if 