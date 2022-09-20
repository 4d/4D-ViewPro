//%attributes = {"invisible":true,"preemptive":"capable"}
C_REAL:C285($Px;$1;$Py;$2)
C_REAL:C285($Ax;$3;$Ay;$4)
C_REAL:C285($Bx;$5;$By;$6)

C_OBJECT:C1216($0)

$Px:=$1
$Py:=$2
$Ax:=$3
$Ay:=$4
$Bx:=$5
$By:=$6

C_REAL:C285($cDir;$ordOrig)

$cDir:=($By-$Ay)/($Bx-$Ax)

$ordOrig:=$Ay-($cDir*$Ax)

$0:=New object:C1471

$0.x:=($Py-$ordOrig)/$cDir
$0.y:=($cDir*$0.x)+$ordOrig