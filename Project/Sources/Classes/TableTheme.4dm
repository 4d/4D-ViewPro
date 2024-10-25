
property bandColumns : Boolean
property bandRows : Boolean

property highlightFirstColumn : Boolean
property highlightLastColumn : Boolean

property showFooter : Boolean

property theme : cs:C1710.TableThemeOptions

Function test()
	var $theme : cs:C1710.ViewPro.TableTheme
	var $border1; $border2; $border3; $border4; $border5; $border6 : cs:C1710.ViewPro.LineBorder
	
	$theme:=cs:C1710.TableTheme.new()
	
	$theme.bandColumns:=True:C214
	$theme.bandRows:=False:C215
	$theme.highlightFirstColumn:=True:C214
	$theme.highlightLastColumn:=False:C215
	
	$theme.theme:=cs:C1710.TableThemeOptions.new()
	
	
	
	var $s1 : cs:C1710.TableStyle
	$s1:=cs:C1710.TableStyle.new()
	
	
	var $s2 : cs:C1710.TableStyle
	$s2:=cs:C1710.TableStyle.new()
	
	$s2.foreColor:="yellow"
	$s2.backColor:="blue"
	$s2.textDecoration:=1
	$s2.borderLeft:=$border2
	$s2.borderRight:=$border1
	$s2.borderTop:=$border4
	$s2.borderBottom:=$border3
	$s2.borderHorizontal:=$border6
	$s2.borderVertical:=$border5
	