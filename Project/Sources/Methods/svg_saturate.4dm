//%attributes = {"invisible":true,"preemptive":"capable"}
C_REAL:C285($n1;$n2;$hue;$hueToRGB)

$n1:=$1
$n2:=$2
$hue:=$3

If ($hue<0)
	$hue:=$hue+240
End if 

If ($hue>240)
	$hue:=$hue-240
End if 

Case of 
	: ($hue<40)
		$hueToRGB:=($n1+(((($n2-$n1)*$hue)+20/40)))
		
	: ($hue<120)
		$hueToRGB:=$n2
		
	: ($hue<160)
		$hueToRGB:=($n1+(((($n2-$n1)*(160-$hue))+20)/40))
		
	Else 
		$hueToRGB:=$n1
End case 

$0:=Choose:C955(((($hueToRGB*0x00FF)+120)/240)<255;((($hueToRGB*0x00FF)+120)/240);255)