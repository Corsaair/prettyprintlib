/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{
	import flash.utils.ByteArray;

    /**
     * Print bytes into a table with ANSI colors.
     * 
     * @playerversion Flash 9
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public class BytesTableAnsiPrinter extends BytesTablePrinter
    {

    	public var colorASCII:String   = "";
    	public var colorLines:String   = "";
    	public var colorHex:String     = "";
    	public var colorHexAlt:String  = "";
    	public var colorHexHead:String = "";
    	public var colorHeader:String  = "";

    	public function BytesTableAnsiPrinter( hexgroup:uint = 2, columns:uint = 8, minPadding:uint = 0 )
    	{
    		super( hexgroup, columns, minPadding );
    	}

    	override protected function _printASCII( value:uint ):String
    	{
    		var str:String = super._printASCII( value );
    			str += colorASCII;

    		return str;
    	}

    	private function _getLength( a:String, before:String = "「", after:String = "」" ):uint
    	{
            a += before + after;
            
            var str:String = "";
            var re:RegExp = new RegExp( "(?P<word>.*?)" + "\\" + before + "(?P<ansi>.*?)" + "\\" + after , "g" );
            var match:*;
            
            while( match = re.exec( a ) )
            {
                str += match.word;
            }

            return str.length;
    	}

        override protected function _process( bytes:ByteArray ):void
        {
            bytes.position = 0;
            
            var copy:ByteArray = new ByteArray();
                copy.writeBytes( bytes );
            
            if( _printCharCode && _printAtEnd )
            {
                _table.columns += 1;
            }
            
            if( _printLines )
            {
                _table.minPadding = 0;
            }
            
            var ratio:uint   = _hexgroup / 2;
            var columns:uint = (_printCharCode && _printAtEnd) ? _table.columns-1: _table.columns;
            
            //pad with zero bytes
            while( ((copy.length / ratio) % columns) != 0 )
            {
                copy.writeByte( 0 );
            }
            copy.position = 0;
            
            var len:uint = copy.length / ratio;
            
            var row:Array;
            var row2:Array;
            var char:uint;
            var char2:uint;
            var char3:uint;
            var char4:uint;
            
            var sep:String;
            var seppad:String;
            var sepH:String;
            
            if( _printLines )
            {
                sep    = "|";
                sep   += colorLines;
                seppad = " ";
                sepH   = "-";
                sepH  += colorLines;
            }
            else
            {
                sep    = "";
                seppad = "";
                sepH   = " ";
            }
            
            var hex:String;
            var hexlen:uint;
            var seplen:uint;
            var sepend:uint;
            
            var strrep:String;
            
            //one cell content
            char = 0;
            hex = char.toString( 16 );
            hex = _padHex( hex, _hexgroup );
            if( _printHexHead )
            {
                hex = "0x" + hex;
            }
            hexlen = _getLength(hex);
            
            seplen = (_getLength(seppad) * 2) + _getLength(sep);
            sepend = _getLength(sep);
            
            var ext:uint = 0;
            if( _printCharCode && _printAtEnd )
            {
                ext = (columns * ratio) + seplen;
            }
            
            var line:String = "";
            while( _getLength(line) < (columns * (hexlen + _table.minPadding + seplen)) + sepend + ext )
            {
                line += sepH;
            }
            
            if( _printLines )
            {
                var header:Printer = _table.addSpannedRow();
                header.println( line + colorLines );
            }
            
            if( _printHeader )
            {
                row  = [];
                var leftspace:String = "";
                
                while( leftspace.length < _table.minPadding )
                {
                    leftspace += " ";
                }
                
                for( var k:uint = 0; k < columns; k++ )
                {
                    char = uint( (_hexgroup*k)/2 );
                    hex = leftspace + char.toString();
                    
                    row.push( hex + colorHeader );
                }
                
                if( _printCharCode && _printAtEnd )
                {
                    var mode:String = "ASCII";
                    
                    if( _printUnicode )
                    {
                        mode = "Unicode";
                    }
                    
                    if( _printUtf8 )
                    {
                        mode = "UTF-8";
                    }
                    
                    row.push( leftspace + mode + colorHeader );
                }
                
                _table.addRow( row, false, " ", sep, seppad );
                
                if( _printLines )
                {
                    var spliter:Printer = _table.addSpannedRow();
                    spliter.println( line + colorLines );
                }
            }
            
            //for( var i:uint = 0; i < (len/columns); i++ )
            while( copy.bytesAvailable > 0 )
            {
                row  = [];
                row2 = [];
                for( var j:uint = 0; j < columns; j++ )
                {
                    //trace( "i = " + i + ", j = " + j );
                    switch( ratio )
                    {
                        case 1:
                        char = uint( copy.readUnsignedByte() );
                        
                        strrep = _printASCII( char );
                        break;
                        
                        case 2:
                        char  = uint( copy.readUnsignedByte() );
                        char2 = uint( copy.readUnsignedByte() );
                        
                        strrep  = _printASCII( char );
                        strrep += _printASCII( char2 );
                        
                        char  = (char << 8) | char2;
                        
                        if( _printUnicode )
                        {
                            strrep = _printUNICODE( char );
                        }
                        
                        break;
                        
                        case 3:
                        char  = uint( copy.readUnsignedByte() );
                        char2 = uint( copy.readUnsignedByte() );
                        char3 = uint( copy.readUnsignedByte() );
                        
                        strrep  = _printASCII( char );
                        strrep += _printASCII( char2 );
                        strrep += _printASCII( char3 );
                        
                        char  = (char << 16) | (char2 << 8) | char3;
                        
                        if( _printUtf8 )
                        {
                            strrep = _printUTF8( char );
                        }
                        break;
                        
                        case 4:
                        char  = uint( copy.readUnsignedByte() );
                        char2 = uint( copy.readUnsignedByte() );
                        char3 = uint( copy.readUnsignedByte() );
                        char4 = uint( copy.readUnsignedByte() );
                        
                        strrep  = _printASCII( char );
                        strrep += _printASCII( char2 );
                        strrep += _printASCII( char3 );
                        strrep += _printASCII( char4 );
                        
                        char  = (char << 24) | (char2 << 16) | (char3 << 8) | char4;
                        break;
                    }
                    //i += ratio - 1;
                    //trace( "i = " + i );
                    
                    //trace( char.toString( 16 ) );
                    hex = char.toString( 16 );
                    hex = _padHex( hex, _hexgroup );
                    
                    if( _printHexHead )
                    {
                        hex = "0x" + colorHexHead + hex;
                    }

                    hex += (j%2 == 0)? colorHex: colorHexAlt;
                    
                    row.push( hex );
                    row2.push( strrep );
                }
                
                if( _printCharCode )
                {
                    if( _printAtEnd )
                    {
                        row.push( row2.join( "" ) );
                        _table.addRow( row, true, " ", sep, seppad );
                    }
                    else
                    {
                        _table.addRow( row, true, " ", sep, seppad );
                        _table.addRow( row2, true, " ", sep, seppad );
                    }
                }
                else
                {
                    _table.addRow( row, true, " ", sep, seppad );
                }
                
            }
            
            if( _printLines )
            {
                var footer:Printer = _table.addSpannedRow();
                footer.println( line + colorLines );
            }
            
        }

    }

}

