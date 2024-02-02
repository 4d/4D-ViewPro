var $e; $ƒ : Object

$e:=FORM Event:C1606
$ƒ:=Form:C1466

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		FEATURES
		
		WA SET PREFERENCE:C1041(*; "ViewProArea"; WA enable contextual menu:K62:6; True:C214)
		WA SET PREFERENCE:C1041(*; "ViewProArea"; WA enable Web inspector:K62:7; True:C214)
		
		$ƒ.vp:=cs:C1710._vp.new("ViewProArea")
		
		var $functions : Object
		$functions:={}
		
		// Hello World example
		$functions.helloWorld:={\
			formula: Formula:C1597("Hello World")\
			}
		
		// Define "myAddition" function
		$functions.myAddition:={\
			formula: Formula:C1597($1+$2); \
			summary: "My addition"; \
			parameters: [\
			{name: "num1"; type: Is integer:K8:5}; \
			{name: "num2"; type: Is integer:K8:5}\
			]}
		
		// Define the "mySum" function from a cell range
		$functions.mySum:={\
			formula: Formula:C1597(Copy parameters:C1790.flat(3).sum()); \
			summary: "My sum"; \
			parameters: [\
			{name: "array"; type: Is collection:K8:32}\
			]}
		
		// Define the "myParameters" function 
		$functions.myParameters:={\
			formula: Formula:C1597(JSON Stringify:C1217(Copy parameters:C1790)); \
			summary: "Display all parameters as JSON"; \
			minParams: 0; \
			maxParams: MAXINT:K35:1; \
			parameters: []}
		
		// Define the "myObject" function 
		$functions.myObject:={\
			formula: Formula:C1597(_myObject); \
			summary: "Get univeral response"; \
			parameters: [\
			{name: "object"; type: Is object:K8:27}\
			]}
		
		$ƒ.vp.setCustomFunctions($functions)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		//WA OPEN WEB INSPECTOR(*; "ViewProArea")
		$ƒ.workbook:=$ƒ.workbook || cs:C1710._workbook.new($ƒ.vp.area)
		
		OBJECT SET VALUE:C1742("hScrollbar"; $ƒ.workbook.options.showHorizontalScrollbar)
		OBJECT SET VALUE:C1742("vScrollbar"; $ƒ.workbook.options.showVerticalScrollbar)
		
		//______________________________________________________
	Else 
		
		// A "Case of" statement should never omit "Else"
		//______________________________________________________
End case 