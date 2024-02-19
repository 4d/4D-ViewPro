//%attributes = {"invisible":true}
If (False:C215)  // clipboard
	//___________________________________
	C_OBJECT:C1216(VP MOVE CELLS; $1)
	C_OBJECT:C1216(VP MOVE CELLS; $2)
	C_OBJECT:C1216(VP MOVE CELLS; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP Copy to object; $0)
	C_OBJECT:C1216(VP Copy to object; $1)
	C_OBJECT:C1216(VP Copy to object; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP PASTE FROM OBJECT; $1)
	C_OBJECT:C1216(VP PASTE FROM OBJECT; $2)
	C_LONGINT:C283(VP PASTE FROM OBJECT; $3)
End if 

If (False:C215)  // data context
	//___________________________________
	C_TEXT:C284(VP SET DATA CONTEXT; $1)
	C_VARIANT:C1683(VP SET DATA CONTEXT; $2)
	C_VARIANT:C1683(VP SET DATA CONTEXT; $3)
	C_VARIANT:C1683(VP SET DATA CONTEXT; $4)
	
	//___________________________________
	C_VARIANT:C1683(VP Get data context; $0)
	C_TEXT:C284(VP Get data context; $1)
	C_LONGINT:C283(VP Get data context; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP SET BINDING PATH; $1)
	C_TEXT:C284(VP SET BINDING PATH; $2)
	
	//___________________________________
	C_TEXT:C284(VP Get binding path; $0)
	C_OBJECT:C1216(VP Get binding path; $1)
	
End if 

If (False:C215)  // document
	//___________________________________
	C_TEXT:C284(VP EXPORT DOCUMENT; $1)
	C_TEXT:C284(VP EXPORT DOCUMENT; $2)
	C_OBJECT:C1216(VP EXPORT DOCUMENT; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP Export to object; $0)
	C_TEXT:C284(VP Export to object; $1)
	C_OBJECT:C1216(VP Export to object; $2)
	
	//___________________________________
	C_TEXT:C284(VP EXPORT TO BLOB; $1)
	C_OBJECT:C1216(VP EXPORT TO BLOB; $2)
	
	//___________________________________
	C_TEXT:C284(VP IMPORT DOCUMENT; $1)
	C_TEXT:C284(VP IMPORT DOCUMENT; $2)
	C_OBJECT:C1216(VP IMPORT DOCUMENT; $3)
	
	//___________________________________
	C_TEXT:C284(VP IMPORT FROM OBJECT; $1)
	C_OBJECT:C1216(VP IMPORT FROM OBJECT; $2)
	
	//___________________________________
	C_TEXT:C284(VP IMPORT FROM BLOB; $1)
	C_OBJECT:C1216(VP IMPORT FROM BLOB; $2)
	C_OBJECT:C1216(VP IMPORT FROM BLOB; $3)
	
	//___________________________________
	C_TEXT:C284(VP NEW DOCUMENT; $1)
	
	//___________________________________
	C_TEXT:C284(VP REGISTER PDF FONTS; $1)
	C_COLLECTION:C1488(VP REGISTER PDF FONTS; $2)
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
	
	//___________________________________
	C_TEXT:C284(VP ADD FORMULA NAME; $1)
	C_TEXT:C284(VP ADD FORMULA NAME; $2)
	C_TEXT:C284(VP ADD FORMULA NAME; $3)
	C_OBJECT:C1216(VP ADD FORMULA NAME; $4)
	
	//___________________________________
	C_OBJECT:C1216(VP Get formula by name; $0)
	C_TEXT:C284(VP Get formula by name; $1)
	C_TEXT:C284(VP Get formula by name; $2)
	C_LONGINT:C283(VP Get formula by name; $3)
	
	//___________________________________
	C_COLLECTION:C1488(VP Get names; $0)
	C_TEXT:C284(VP Get names; $1)
	C_LONGINT:C283(VP Get names; $2)
	
	//___________________________________
	C_TEXT:C284(VP REMOVE NAME; $1)
	C_TEXT:C284(VP REMOVE NAME; $2)
	C_LONGINT:C283(VP REMOVE NAME; $3)
	
	
End if 

If (False:C215)  // printing
	//___________________________________
	C_TEXT:C284(VP PRINT; $1)
	C_LONGINT:C283(VP PRINT; $2)
	
	//___________________________________
	C_TEXT:C284(VP SET SHOW PRINT LINES; $1)
	C_BOOLEAN:C305(VP SET SHOW PRINT LINES; $2)
	C_LONGINT:C283(VP SET SHOW PRINT LINES; $3)
	
	//___________________________________
	C_BOOLEAN:C305(VP Get show print lines; $0)
	C_TEXT:C284(VP Get show print lines; $1)
	C_LONGINT:C283(VP Get show print lines; $2)
	
	//___________________________________
	C_TEXT:C284(VP SET PRINT INFO; $1)
	C_OBJECT:C1216(VP SET PRINT INFO; $2)
	C_LONGINT:C283(VP SET PRINT INFO; $3)
	
	//___________________________________
	C_TEXT:C284(VP Get print info; $1)
	C_LONGINT:C283(VP Get print info; $2)
	C_OBJECT:C1216(VP Get print info; $0)
	
End if 

If (False:C215)  // ranges
	
	//___________________________________
	C_OBJECT:C1216(VP Column; $0)
	C_TEXT:C284(VP Column; $1)
	C_LONGINT:C283(VP Column; $2)
	C_LONGINT:C283(VP Column; $3)
	C_LONGINT:C283(VP Column; $4)
	
	//___________________________________
	C_OBJECT:C1216(VP Row; $0)
	C_TEXT:C284(VP Row; $1)
	C_LONGINT:C283(VP Row; $2)
	C_LONGINT:C283(VP Row; $3)
	C_LONGINT:C283(VP Row; $4)
	
	//___________________________________
	C_OBJECT:C1216(VP All; $0)
	C_TEXT:C284(VP All; $1)
	C_LONGINT:C283(VP All; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP Name; $0)
	C_TEXT:C284(VP Name; $1)
	C_TEXT:C284(VP Name; $2)
	C_LONGINT:C283(VP Name; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP Combine ranges; $0)
	C_OBJECT:C1216(VP Combine ranges; ${1})
	
End if 

If (False:C215)  // rows & columns
	//___________________________________
	C_LONGINT:C283(VP Get column count; $0)
	C_TEXT:C284(VP Get column count; $1)
	C_LONGINT:C283(VP Get column count; $2)
	
	//___________________________________
	C_LONGINT:C283(VP Get row count; $0)
	C_TEXT:C284(VP Get row count; $1)
	C_LONGINT:C283(VP Get row count; $2)
	
	//___________________________________
	C_TEXT:C284(VP SET ROW COUNT; $1)
	C_LONGINT:C283(VP SET ROW COUNT; $2)
	C_LONGINT:C283(VP SET ROW COUNT; $3)
	
	//___________________________________
	C_TEXT:C284(VP SET COLUMN COUNT; $1)
	C_LONGINT:C283(VP SET COLUMN COUNT; $2)
	C_LONGINT:C283(VP SET COLUMN COUNT; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP SET COLUMN ATTRIBUTES; $1)
	C_OBJECT:C1216(VP SET COLUMN ATTRIBUTES; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP SET ROW ATTRIBUTES; $1)
	C_OBJECT:C1216(VP SET ROW ATTRIBUTES; $2)
	
	//___________________________________
	C_COLLECTION:C1488(VP Get column attributes; $0)
	C_OBJECT:C1216(VP Get column attributes; $1)
	
	//___________________________________
	C_COLLECTION:C1488(VP Get row attributes; $0)
	C_OBJECT:C1216(VP Get row attributes; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP DELETE COLUMNS; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP DELETE ROWS; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP INSERT COLUMNS; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP INSERT ROWS; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP COLUMN AUTOFIT; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP ROW AUTOFIT; $1)
	
	//___________________________________
	C_TEXT:C284(VP SET FROZEN PANES; $1)
	C_OBJECT:C1216(VP SET FROZEN PANES; $2)
	C_LONGINT:C283(VP SET FROZEN PANES; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP Get frozen panes; $0)
	C_TEXT:C284(VP Get frozen panes; $1)
	C_LONGINT:C283(VP Get frozen panes; $2)
	
End if 

If (False:C215)  // selection
	
	//___________________________________
	C_OBJECT:C1216(VP SET ACTIVE CELL; $1)
	
	//___________________________________
	C_TEXT:C284(VP Get selection; $1)
	C_LONGINT:C283(VP Get selection; $2)
	C_OBJECT:C1216(VP Get selection; $0)
	
	//___________________________________
	C_OBJECT:C1216(VP SET SELECTION; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP ADD SELECTION; $1)
	
	//___________________________________
	C_TEXT:C284(VP RESET SELECTION; $1)
	C_LONGINT:C283(VP RESET SELECTION; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP SHOW CELL; $1)
	C_LONGINT:C283(VP SHOW CELL; $2)
	C_LONGINT:C283(VP SHOW CELL; $3)
End if 

If (False:C215)  // sheets
	//___________________________________
	C_TEXT:C284(VP SET SHEET COUNT; $1)
	C_LONGINT:C283(VP SET SHEET COUNT; $2)
	
	//___________________________________
	C_TEXT:C284(VP SET CURRENT SHEET; $1)
	C_LONGINT:C283(VP SET CURRENT SHEET; $2)
	
	//___________________________________
	C_TEXT:C284(VP SET START SHEET; $1)
	C_LONGINT:C283(VP SET START SHEET; $2)
	
	//___________________________________
	C_LONGINT:C283(VP Get sheet index; $0)
	C_TEXT:C284(VP Get sheet index; $1)
	C_TEXT:C284(VP Get sheet index; $2)
	
	//___________________________________
End if 

If (False:C215)  // spans
	//___________________________________
	C_OBJECT:C1216(VP ADD SPAN; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP REMOVE SPAN; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP Get spans; $0)
	C_OBJECT:C1216(VP Get spans; $1)
	
End if 

If (False:C215)  // stylesheet
	//___________________________________
	C_TEXT:C284(VP ADD STYLESHEET; $1)
	C_TEXT:C284(VP ADD STYLESHEET; $2)
	C_OBJECT:C1216(VP ADD STYLESHEET; $3)
	C_LONGINT:C283(VP ADD STYLESHEET; $4)
	
	//___________________________________
	C_TEXT:C284(VP REMOVE STYLESHEET; $1)
	C_TEXT:C284(VP REMOVE STYLESHEET; $2)
	C_LONGINT:C283(VP REMOVE STYLESHEET; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP Get stylesheet; $0)
	C_TEXT:C284(VP Get stylesheet; $1)
	C_TEXT:C284(VP Get stylesheet; $2)
	C_LONGINT:C283(VP Get stylesheet; $3)
	
	//___________________________________
	C_COLLECTION:C1488(VP Get stylesheets; $0)
	C_TEXT:C284(VP Get stylesheets; $1)
	C_LONGINT:C283(VP Get stylesheets; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP Object to font; $1)
	C_TEXT:C284(VP Object to font; $0)
	
	//___________________________________
	C_TEXT:C284(VP Font to object; $1)
	C_OBJECT:C1216(VP Font to object; $0)
	
	//___________________________________
	C_TEXT:C284(VP SET DEFAULT STYLE; $1)
	C_OBJECT:C1216(VP SET DEFAULT STYLE; $2)
	C_LONGINT:C283(VP SET DEFAULT STYLE; $3)
	
	//___________________________________
	C_OBJECT:C1216(VP Get default style; $0)
	C_TEXT:C284(VP Get default style; $1)
	C_LONGINT:C283(VP Get default style; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP SET CELL STYLE; $1)
	C_OBJECT:C1216(VP SET CELL STYLE; $2)
	
	//___________________________________
	C_OBJECT:C1216(VP Get cell style; $0)
	C_OBJECT:C1216(VP Get cell style; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP SET BORDER; $1)
	C_OBJECT:C1216(VP SET BORDER; $2)
	C_OBJECT:C1216(VP SET BORDER; $3)
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
	C_COLLECTION:C1488(VP Get tables; $0)
	C_TEXT:C284(VP Get tables; $1)
	C_LONGINT:C283(VP Get tables; $2)
	
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
	C_OBJECT:C1216(VP RESIZE TABLE; $1)
	C_TEXT:C284(VP RESIZE TABLE; $2)
	
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
	C_TEXT:C284(VP FLUSH COMMANDS; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP Convert to picture; $1)
	C_OBJECT:C1216(VP Convert to picture; $2)
	C_PICTURE:C286(VP Convert to picture; $0)
	
	//___________________________________
	C_OBJECT:C1216(VP SET ALLOWED METHODS; $1)
	
	//___________________________________
	C_COLLECTION:C1488(vp_getAllowedMethods; $0)
	
	//___________________________________
	C_TEXT:C284(vp_getCustomFunctions; $1)
	C_OBJECT:C1216(vp_getCustomFunctions; $0)
	
	//___________________________________
	C_TEXT:C284(VP RECOMPUTE FORMULAS; $1)
	
	//___________________________________
	C_TEXT:C284(VP SUSPEND COMPUTING; $1)
	
	//___________________________________
	C_TEXT:C284(VP RESUME COMPUTING; $1)
	
	//___________________________________
	C_OBJECT:C1216(VP Run offscreen area; $1)
	C_VARIANT:C1683(VP Run offscreen area; $0)
	
	//___________________________________
	C_OBJECT:C1216(VP Copy; $0)
	C_TEXT:C284(VP Copy; $1)
	
	//___________________________________
	C_TEXT:C284(VP PASTE; $1)
	C_OBJECT:C1216(VP PASTE; $2)
	C_LONGINT:C283(VP PASTE; $3)
	
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
