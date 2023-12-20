//%attributes = {"invisible":true}
// Project method : TRY
// ID[0D905E8F790C46B59B505B1A340AB759]
// Created #18-5-2017 by Vincent de Lachaux
// ----------------------------------------------------
var err : Object

CLEAR VARIABLE:C89(ERROR)
CLEAR VARIABLE:C89(ERROR METHOD)
CLEAR VARIABLE:C89(ERROR LINE)
CLEAR VARIABLE:C89(ERROR FORMULA)

CLEAR VARIABLE:C89(err)
err:={}

err_component:="4DVP"

// Don't catch errors in dev mode
ON ERR CALL:C155(Is compiled mode:C492 ? Formula:C1597(err_CATCH).source : "")

