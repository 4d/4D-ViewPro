//%attributes = {"invisible":true}
/*
***TRY*** ( component )
 -> component (Text)
________________________________________________________
*/
// Project method : TRY
// ID[0D905E8F790C46B59B505B1A340AB759]
// Created #18-5-2017 by Vincent de Lachaux
// ----------------------------------------------------

C_OBJECT:C1216(err)

CLEAR VARIABLE:C89(ERROR)
CLEAR VARIABLE:C89(ERROR METHOD)
CLEAR VARIABLE:C89(ERROR LINE)
CLEAR VARIABLE:C89(ERROR FORMULA)

CLEAR VARIABLE:C89(err)
err:=New object:C1471

err_component:="4DVP"

// Don't catch errors in dev mode
ON ERR CALL:C155(Choose:C955(Is compiled mode:C492; "err_CATCH"; ""))

