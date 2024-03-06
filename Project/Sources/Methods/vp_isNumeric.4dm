//%attributes = {"invisible":true}
#DECLARE($num) : Boolean

return (Value type:C1509($num)=Is real:K8:4) | \
(Value type:C1509($num)=Is integer:K8:5) | \
(Value type:C1509($num)=Is integer 64 bits:K8:25) | \
(Value type:C1509($num)=Is longint:K8:6)

