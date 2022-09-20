//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$colorObj)

C_REAL:C285($maxUnit;$minUnit;$sum;$diff;$partR;$partB;$partG;$tint;$lumDiff;$n1;$n2)

$colorObj:=$1

$maxUnit:=Choose:C955($colorObj.r>$colorObj.g;$colorObj.r;$colorObj.g)
$maxUnit:=Choose:C955($maxUnit>$colorObj.b;$maxUnit;$colorObj.b)

$minUnit:=Choose:C955($colorObj.r<$colorObj.g;$colorObj.r;$colorObj.g)
$minUnit:=Choose:C955($minUnit<$colorObj.b;$minUnit;$colorObj.b)

$sum:=$maxUnit+$minUnit

$colorObj.luminosity:=((($sum*240)+0x00FF)/510)

$diff:=$maxUnit-$minUnit

If ($diff=0)
	$colorObj.saturation:=0
	$colorObj.hue:=160
Else 
	If ($colorObj.luminosity<=120)
		$colorObj.saturation:=((($diff*240)+($sum/2))/$sum)
	Else 
		$colorObj.saturation:=((($diff*240)+((510-$sum)/2))/(510-$sum))
	End if 
	$partR:=((($maxUnit-$colorObj.r)*40)+($diff/2))/$diff
	$partG:=((($maxUnit-$colorObj.g)*40)+($diff/2))/$diff
	$partB:=((($maxUnit-$colorObj.b)*40)+($diff/2))/$diff
	Case of 
		: ($colorObj.r=$maxUnit)
			$colorObj.hue:=($partB-$partG)
		: ($colorObj.g=$maxUnit)
			$colorObj.hue:=((80+$partR)-$partB)
		Else 
			$colorObj.hue:=((160+$partG)-$partR)
	End case 
	
	If ($colorObj.hue<0)
		$colorObj.hue:=$colorObj.hue+240
	End if 
	
	If ($colorObj.hue>240)
		$colorObj.hue:=$colorObj.hue-240
	End if 
End if 

$tint:=$colorObj.factor/100

$lumDiff:=Choose:C955($tint>0;((240-$colorObj.luminosity)*$tint);($colorObj.luminosity*$tint))
$colorObj.luminosity:=$colorObj.luminosity+$lumDiff

If ($colorObj.saturation=0)
	$colorObj.r:=(($colorObj.luminosity*0x00FF)/240)
	$colorObj.g:=$colorObj.r
	$colorObj.b:=$colorObj.r
Else 
	$n2:=Choose:C955(($colorObj.luminosity<=120);\
		((($colorObj.luminosity*(240+$colorObj.saturation))+120)/240);\
		(($colorObj.luminosity+$colorObj.saturation)-((($colorObj.luminosity*$colorObj.saturation)+120)/240)))
	
	$n1:=(2*$colorObj.luminosity)-$n2
	
	$colorObj.r:=Round:C94(svg_saturate ($n1;$n2;$colorObj.hue+80);0)
	$colorObj.g:=Round:C94(svg_saturate ($n1;$n2;$colorObj.hue);0)
	$colorObj.b:=Round:C94(svg_saturate ($n1;$n2;$colorObj.hue-80);0)
	
End if 