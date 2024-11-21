//%attributes = {"invisible":true}
If (False:C215)  // clipboard
	//___________________________________
	C_OBJECT:C1216(VP MOVE CELLS; $1)
	C_OBJECT:C1216(VP MOVE CELLS; $2)
	C_OBJECT:C1216(VP MOVE CELLS; $3)
	
End if 

If (False:C215)  // events
	//___________________________________
	C_TEXT:C284(VP ON EVENT; $1)
	C_TEXT:C284(VP ON EVENT; $2)
	C_OBJECT:C1216(VP ON EVENT; $3)
	C_LONGINT:C283(VP ON EVENT; $4)
End if 

If (False:C215)  // names
	//___________________________________
	C_OBJECT:C1216(VP ADD RANGE NAME; $1)
	C_TEXT:C284(VP ADD RANGE NAME; $2)
	C_OBJECT:C1216(VP ADD RANGE NAME; $3)
	
End if 

If (False:C215)  // ranges
	
	//___________________________________
	C_OBJECT:C1216(VP Combine ranges; $0)
	C_OBJECT:C1216(VP Combine ranges; ${1})
	
End if 

If (False:C215)  // rows & columns
	
	//___________________________________
	C_OBJECT:C1216(VP SET COLUMN ATTRIBUTES; $1)
	C_OBJECT:C1216(VP SET COLUMN ATTRIBUTES; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP SET ROW ATTRIBUTES; $1)
	C_OBJECT:C1216(VP SET ROW ATTRIBUTES; $2)
	
	//___________________________________
	C_COLLECTION:C1488(VP Get column attributes; $0)
	C_OBJECT:C1216(VP Get column attributes; $1)
	
End if 

If (False:C215)  // selection
	
	//___________________________________
	C_OBJECT:C1216(VP SHOW CELL; $1)
	C_LONGINT:C283(VP SHOW CELL; $2)
	C_LONGINT:C283(VP SHOW CELL; $3)
End if 


If (False:C215)  // spans
	
	//___________________________________
	C_OBJECT:C1216(VP Get spans; $0)
	C_OBJECT:C1216(VP Get spans; $1)
	
End if 

If (False:C215)  // stylesheet
	
	C_OBJECT:C1216(VP Object to font; $1)
	C_TEXT:C284(VP Object to font; $0)
	
	//___________________________________
	C_TEXT:C284(VP Font to object; $1)
	C_OBJECT:C1216(VP Font to object; $0)
	
	
End if 

If (False:C215)  // tables
	//___________________________________
	C_OBJECT:C1216(VP CREATE TABLE; $1)
	C_TEXT:C284(VP CREATE TABLE; $2)
	C_VARIANT:C1683(VP CREATE TABLE; $3)
	C_OBJECT:C1216(VP CREATE TABLE; $4)
	
	//___________________________________
	C_TEXT:C284(VP REMOVE TABLE; $1)
	C_TEXT:C284(VP REMOVE TABLE; $2)
	C_LONGINT:C283(VP REMOVE TABLE; $3)
	C_LONGINT:C283(VP REMOVE TABLE; $4)
	
	
	//___________________________________
	C_TEXT:C284(VP INSERT TABLE ROWS; $1)
	C_TEXT:C284(VP INSERT TABLE ROWS; $2)
	C_LONGINT:C283(VP INSERT TABLE ROWS; $3)
	C_LONGINT:C283(VP INSERT TABLE ROWS; $4)
	C_LONGINT:C283(VP INSERT TABLE ROWS; $5)
	C_LONGINT:C283(VP INSERT TABLE ROWS; $6)
	
	//___________________________________
	C_TEXT:C284(VP INSERT TABLE COLUMNS; $1)
	C_TEXT:C284(VP INSERT TABLE COLUMNS; $2)
	C_LONGINT:C283(VP INSERT TABLE COLUMNS; $3)
	C_LONGINT:C283(VP INSERT TABLE COLUMNS; $4)
	C_LONGINT:C283(VP INSERT TABLE COLUMNS; $5)
	C_LONGINT:C283(VP INSERT TABLE COLUMNS; $6)
	
	//___________________________________
	C_TEXT:C284(VP REMOVE TABLE COLUMNS; $1)
	C_TEXT:C284(VP REMOVE TABLE COLUMNS; $2)
	C_LONGINT:C283(VP REMOVE TABLE COLUMNS; $3)
	C_LONGINT:C283(VP REMOVE TABLE COLUMNS; $4)
	C_LONGINT:C283(VP REMOVE TABLE COLUMNS; $5)
	
	//___________________________________
	C_TEXT:C284(VP REMOVE TABLE ROWS; $1)
	C_TEXT:C284(VP REMOVE TABLE ROWS; $2)
	C_LONGINT:C283(VP REMOVE TABLE ROWS; $3)
	C_LONGINT:C283(VP REMOVE TABLE ROWS; $4)
	C_LONGINT:C283(VP REMOVE TABLE ROWS; $5)
	
	//___________________________________
	C_OBJECT:C1216(VP Get table range; $0)
	C_TEXT:C284(VP Get table range; $1)
	C_TEXT:C284(VP Get table range; $2)
	C_LONGINT:C283(VP Get table range; $3)
	C_LONGINT:C283(VP Get table range; $4)
	
	//___________________________________
	C_TEXT:C284(VP Find table; $0)
	C_OBJECT:C1216(VP Find table; $1)
	
	//___________________________________
	C_TEXT:C284(VP Get table column attributes; $1)
	C_TEXT:C284(VP Get table column attributes; $2)
	C_LONGINT:C283(VP Get table column attributes; $3)
	C_LONGINT:C283(VP Get table column attributes; $4)
	C_OBJECT:C1216(VP Get table column attributes; $0)
	
	//___________________________________
	C_TEXT:C284(VP SET TABLE COLUMN ATTRIBUTES; $1)
	C_TEXT:C284(VP SET TABLE COLUMN ATTRIBUTES; $2)
	C_LONGINT:C283(VP SET TABLE COLUMN ATTRIBUTES; $3)
	C_OBJECT:C1216(VP SET TABLE COLUMN ATTRIBUTES; $4)
	C_LONGINT:C283(VP SET TABLE COLUMN ATTRIBUTES; $5)
	
	//___________________________________
	C_TEXT:C284(VP Get table column index; $1)
	C_TEXT:C284(VP Get table column index; $2)
	C_TEXT:C284(VP Get table column index; $3)
	C_LONGINT:C283(VP Get table column index; $4)
	C_LONGINT:C283(VP Get table column index; $0)
	
	//___________________________________
	C_TEXT:C284(VP Get table dirty rows; $1)
	C_TEXT:C284(VP Get table dirty rows; $2)
	C_BOOLEAN:C305(VP Get table dirty rows; $3)
	C_LONGINT:C283(VP Get table dirty rows; $4)
	C_COLLECTION:C1488(VP Get table dirty rows; $0)
	
	//___________________________________
	C_TEXT:C284(VP SET TABLE THEME; $1)
	C_TEXT:C284(VP SET TABLE THEME; $2)
	C_OBJECT:C1216(VP SET TABLE THEME; $3)
	C_LONGINT:C283(VP SET TABLE THEME; $4)
	
	//___________________________________
	C_OBJECT:C1216(VP Get table theme; $0)
	C_TEXT:C284(VP Get table theme; $1)
	C_TEXT:C284(VP Get table theme; $2)
	C_LONGINT:C283(VP Get table theme; $3)
	
End if 

If (False:C215)  // utilities
	//___________________________________
	C_OBJECT:C1216(VP Convert from 4D View; $0)
	C_BLOB:C604(VP Convert from 4D View; $1)
	C_OBJECT:C1216(VP Convert from 4D View; $2)  //#TO_DO - Optional parameter to allow future conversion options (not managed yet)
	
	
	//___________________________________
	C_OBJECT:C1216(VP Convert to picture; $1)
	C_OBJECT:C1216(VP Convert to picture; $2)
	C_PICTURE:C286(VP Convert to picture; $0)
	
	//___________________________________
	C_TEXT:C284(vp_getCustomFunctions; $1)
	C_OBJECT:C1216(vp_getCustomFunctions; $0)
	
	//___________________________________
	C_OBJECT:C1216(VP Run offscreen area; $1)
	C_VARIANT:C1683(VP Run offscreen area; $0)
	
	//___________________________________
	C_OBJECT:C1216(VP Find; $0)
	C_OBJECT:C1216(VP Find; $1)
	C_TEXT:C284(VP Find; $2)
	C_OBJECT:C1216(VP Find; $3)
	C_TEXT:C284(VP Find; $4)
End if 

If (False:C215)  // values
	
	//___________________________________
	C_OBJECT:C1216(VP SET BOOLEAN VALUE; $1)
	C_BOOLEAN:C305(VP SET BOOLEAN VALUE; $2)
	C_TEXT:C284(VP SET BOOLEAN VALUE; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP SET DATE TIME VALUE; $1)
	C_DATE:C307(VP SET DATE TIME VALUE; $2)
	C_TIME:C306(VP SET DATE TIME VALUE; $3)
	C_TEXT:C284(VP SET DATE TIME VALUE; $4)
	
	//___________________________________
	C_OBJECT:C1216(VP SET DATE VALUE; $1)
	C_DATE:C307(VP SET DATE VALUE; $2)
	C_TEXT:C284(VP SET DATE VALUE; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP SET TIME VALUE; $1)
	C_TIME:C306(VP SET TIME VALUE; $2)
	C_TEXT:C284(VP SET TIME VALUE; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP SET NUM VALUE; $1)
	C_REAL:C285(VP SET NUM VALUE; $2)
	C_TEXT:C284(VP SET NUM VALUE; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP SET TEXT VALUE; $1)
	C_TEXT:C284(VP SET TEXT VALUE; $2)
	C_TEXT:C284(VP SET TEXT VALUE; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP SET FIELD; $1)
	C_POINTER:C301(VP SET FIELD; $2)
	C_TEXT:C284(VP SET FIELD; $3)
	
	//___________________________________
	C_TEXT:C284(VP Get formula; $0)
	C_OBJECT:C1216(VP Get formula; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP SET FORMULAS; $1)
	C_COLLECTION:C1488(VP SET FORMULAS; $2)
	
	//___________________________________
	C_COLLECTION:C1488(VP Get formulas; $0)
	C_OBJECT:C1216(VP Get formulas; $1)
	
End if 
