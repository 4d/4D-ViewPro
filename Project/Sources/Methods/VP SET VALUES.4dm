//%attributes = {"invisible":true,"shared":true}
  // ----------------------------------------------------
  // Project method : VP SET VALUES
  // Database: 4D ViewPro
  // ID[5101BAB9EE102650B8B95DB1D501A124]
  // Created #12-7-2018 by Francois Marchal
  // ----------------------------------------------------
  // Description: Set the values of a range
  // ----------------------------------------------------
  // ----- Declarations

C_OBJECT:C1216($1)
C_COLLECTION:C1488($2)

If (False:C215)
	C_OBJECT:C1216(VP SET VALUES ;$1)
	C_COLLECTION:C1488(VP SET VALUES ;$2)
End if 

C_LONGINT:C283($nbParameters)
C_OBJECT:C1216($ranges)
C_COLLECTION:C1488($Obj_values)
C_TEXT:C284($area)

If (vp_initStorage )
	
	$nbParameters:=Count parameters:C259
	
	TRY 
	
	If (Check_parameters_count (2;$nbParameters))
		
		$ranges:=$1
		$Obj_values:=$2
		
		$area:=$ranges.area
		
		If (vp_isReady ($area;Current method name:C684))
			
			C_OBJECT:C1216($params)
			$params:=New object:C1471()
			
			If (Value type:C1509($Obj_values)=Is collection:K8:32)
				
				$params.value:=New collection:C1472
				C_LONGINT:C283($row;$col)
				
				For ($row;0;$Obj_values.length-1)
					
					If (Value type:C1509($Obj_values[$row])=Is collection:K8:32)
						
						C_COLLECTION:C1488($colCollection)
						$colCollection:=New collection:C1472
						
						For ($col;0;$Obj_values[$row].length-1)
							
							C_LONGINT:C283($Lon_type)
							$Lon_type:=Value type:C1509($Obj_values[$row][$col])
							C_OBJECT:C1216($val)
							$val:=New object:C1471("value";Null:C1517)
							
							Case of 
								: (($Lon_type=Is boolean:K8:9) | ($Lon_type=Is text:K8:3) | ($Lon_type=Is real:K8:4))
									$val.value:=$Obj_values[$row][$col]
								: ($Lon_type=Is date:K8:7)
									$val.value:=New object:C1471()
									C_DATE:C307($date)
									$date:=Date:C102($Obj_values[$row][$col])
									$val.value.day:=Day of:C23($date)
									$val.value.month:=Month of:C24($date)
									$val.value.year:=Year of:C25($date)
								: ($Lon_type=Is object:K8:27)
									
									$Lon_type:=Value type:C1509($Obj_values[$row][$col].value)
									Case of 
										: (($Lon_type=Is boolean:K8:9) | ($Lon_type=Is text:K8:3) | ($Lon_type=Is real:K8:4))
											$val.value:=$Obj_values[$row][$col].value
										: ($Lon_type=Is date:K8:7)
											$val.value:=New object:C1471()
											C_DATE:C307($date)
											$date:=Date:C102($Obj_values[$row][$col].value)
											$val.value.day:=Day of:C23($date)
											$val.value.month:=Month of:C24($date)
											$val.value.year:=Year of:C25($date)
									End case 
									
									If (Value type:C1509($Obj_values[$row][$col].time)=Is real:K8:4)
										
										If ($val.value=Null:C1517)
											$val.value:=New object:C1471()
										End if 
										
										If (Value type:C1509($val.value)=Is object:K8:27)
											C_TIME:C306($time)
											$time:=Time:C179($Obj_values[$row][$col].time)
											$val.value.hours:=$time\3600
											$val.value.minutes:=($time%3600)\60
											$val.value.seconds:=$time%60
										End if 
									End if 
							End case 
							
							$colCollection.push($val.value)
							
						End for 
						
						$params.value.push($colCollection)
					Else 
						$params.value.push(Null:C1517)
					End if 
				End for 
				
				If (OB Is defined:C1231($params;"value"))
					
					If (Value type:C1509($ranges.ranges)=Is collection:K8:32)
						$params.ranges:=$ranges.ranges
						
						vp_runCommand ($area;"set-values";$params)
						
					End if 
				End if 
			End if 
		End if 
	End if 
	
	FINALLY 
	
End if 