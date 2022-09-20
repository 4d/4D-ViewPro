Class constructor()
	
Function putshort($val : Integer)
	var $index : Integer
	$index:=This:C1470.writeIndex
	INTEGER TO BLOB:C548($val; _ttf_; Macintosh byte ordering:K22:2; $index)
	This:C1470.writeIndex:=$index
	
Function putchar($val : Integer)
	var $index : Integer
	$index:=This:C1470.writeIndex
	TEXT TO BLOB:C554(Char:C90($val); _ttf_; Mac text without length:K22:10; $index)
	This:C1470.writeIndex:=$index
	
Function putlong($val : Integer)
	var $index : Integer
	$index:=This:C1470.writeIndex
	LONGINT TO BLOB:C550($val; _ttf_; Macintosh byte ordering:K22:2; $index)
	This:C1470.writeIndex:=$index
	
Function getushort()->$value : Integer
	var $val1; $index : Integer
	$index:=This:C1470.readIndex
	$val1:=_ttc_{$index}*256
	$value:=$val1+_ttc_{$index+1}
	This:C1470.readIndex:=This:C1470.readIndex+2
	
Function getlong()->$value : Integer
	var $index : Integer
	$index:=This:C1470.readIndex
	$value:=BLOB to longint:C551(_ttc_; Macintosh byte ordering:K22:2; $index)
	This:C1470.readIndex:=$index
	
Function filecheck()->$checksum : Integer
	var $size; $index; $i : Integer
	$size:=BLOB size:C605(_ttf_)/4
	$index:=0
	$checksum:=0
	For ($i; 1; $size)
		$checksum:=$checksum+BLOB to longint:C551(_ttf_; Macintosh byte ordering:K22:2; $index)
	End for 
	
Function copytable($offset : Integer; $length : Integer)
	COPY BLOB:C558(_ttc_; _ttf_; $offset; This:C1470.writeIndex; $length)
	This:C1470.readIndex:=$offset+$length
	This:C1470.writeIndex:=This:C1470.writeIndex+$length
	
	If (($length%0x0001)#0)
		This:C1470.putchar(0)
	End if 
	
	If (($length & 0x0002)#0)
		This:C1470.putshort(0)
	End if 
	
Function handlefont($offset : Integer)
	var $i; $head; $tag; $headpos; $pos; $cnt; $checksum : Integer
	
	SET BLOB SIZE:C606(_ttf_; 0)
	This:C1470.writeIndex:=0
	
	This:C1470.readIndex:=$offset
	This:C1470.putlong(This:C1470.getlong())
	$cnt:=This:C1470.getushort()
	This:C1470.putshort($cnt)
	This:C1470.putshort(This:C1470.getushort())
	This:C1470.putshort(This:C1470.getushort())
	This:C1470.putshort(This:C1470.getushort())
	
	ARRAY LONGINT:C221($offsets; $cnt)
	ARRAY LONGINT:C221($lengths; $cnt)
	
	$head:=-1
	
	For ($i; 0; $cnt-1)
		$tag:=This:C1470.getlong()
		If ($tag=0x68656164)
			$head:=$i
		End if 
		This:C1470.putlong($tag)
		This:C1470.putlong(This:C1470.getlong())
		$offsets{$i}:=This:C1470.getlong()
		$lengths{$i}:=This:C1470.getlong()
		This:C1470.putlong($offsets{$i})
		This:C1470.putlong($lengths{$i})
	End for 
	
	$headpos:=-1
	For ($i; 0; $cnt-1)
		$pos:=This:C1470.writeIndex
		This:C1470.copytable($offsets{$i}; $lengths{$i})
		If ($i=$head)
			This:C1470.writeIndex:=$pos+8
			$headpos:=$pos
			This:C1470.putlong(0)
		End if 
		This:C1470.writeIndex:=12+($i*16)+8
		This:C1470.putlong($pos)
		This:C1470.writeIndex:=BLOB size:C605(_ttf_)
	End for 
	
	If ($headpos#-1)
		$checksum:=This:C1470.filecheck()
		$checksum:=0xB1B0AFBA-$checksum
		This:C1470.writeIndex:=$headpos+8
		This:C1470.putlong($checksum)
	End if 
	
Function extractTTF($fileName : Text; $index : Integer)->$blob : Blob
	var $i; $version; $cnt : Integer
	
	SET BLOB SIZE:C606(_ttc_; 0)
	SET BLOB SIZE:C606(_ttf_; 0)
	DOCUMENT TO BLOB:C525($fileName; _ttc_)
	This:C1470.readIndex:=0
	This:C1470.writeIndex:=0
	
	$version:=This:C1470.getlong()
	If ($version=0x74746366)
		$version:=This:C1470.getlong()
		If (($version=0x00010000) | ($version=0x00020000))
			$cnt:=This:C1470.getlong()
			
			ARRAY LONGINT:C221($offsets; $cnt)
			
			For ($i; 0; $cnt-1)
				$offsets{$i}:=This:C1470.getlong()
			End for 
			
			This:C1470.handlefont($offsets{$index})
			$blob:=_ttf_
			SET BLOB SIZE:C606(_ttf_; 0)
			SET BLOB SIZE:C606(_ttc_; 0)
		End if 
	End if 
	