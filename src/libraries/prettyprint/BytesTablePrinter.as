/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{
    import flash.utils.ByteArray;

    /**
     * Print bytes into a table.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public class BytesTablePrinter
    {
        protected var _table:TablePrinter;
        protected var _bytes:ByteArray;
        
        protected var _hexgroup:uint;
        
        protected var _printCharCode:Boolean;
        protected var _padCharCode:Boolean;
        protected var _printAtEnd:Boolean;
        protected var _printHeader:Boolean;
        protected var _printLines:Boolean;
        protected var _printHexHead:Boolean;
        protected var _printUnicode:Boolean;
        protected var _printUtf8:Boolean;
        
        public function BytesTablePrinter( hexgroup:uint = 2, columns:uint = 8, minPadding:uint = 0 )
        {
            _table         = new TablePrinter( columns, minPadding );
            
            if( (hexgroup % 2 != 0) || (hexgroup > 8) )
            {
                hexgroup = 2;
            }
            
            _hexgroup      = hexgroup;
            _printCharCode = false;
            _padCharCode   = false;
            _printAtEnd    = false;
            _printHeader   = false;
            _printLines    = false;
            _printHexHead  = false;
            _printUnicode  = false;
            _printUtf8     = false;
        }
        
        protected function _isPrintableASCII( c:String, index:uint = 0 ):Boolean
        {
            if( index > 0 )
            {
                c = c.charAt( index ) ;
            }
            
            return ( c.charCodeAt( 0 ) >= 0x20 ) && ( c.charCodeAt( 0 ) <= 0x7e ) ;
        }
        
        protected function _padHex( hex:String, max:uint ):String
        {
            while( hex.length < max )
            {
                hex = "0" + hex;
            }
            
            return hex;
        }
        
        protected function _printASCII( value:uint ):String
        {
            var c:String = String.fromCharCode( value );
            var str:String = "";
            
            if( _isPrintableASCII( c ) )
            {
                if( !_printAtEnd && _padCharCode ) { str += " "; }
                str += c;
            }
            else
            {
                if( !_printAtEnd && _padCharCode ) { str += "."; }
                str += ".";
            }
            
            //str += "「C! 」";

            return str;
        }
        
        protected function _printUNICODE( value:int ):String
        {
            var c:String = String.fromCharCode( value );
            var str:String = "";
            
            if( value > 255 )
            {
                if( !_printAtEnd && _padCharCode ) { str += ""; }
                str += c;
            }
            else if( _isPrintableASCII( c ) )
            {
                if( !_printAtEnd && _padCharCode ) { str += " "; }
                str += c;
            }
            else
            {
                if( !_printAtEnd && _padCharCode ) { str += ""; }
                str += ".";
            }
            
            return str;
        }
        
        protected function _printUTF8( value:int ):String
        {
            var b:ByteArray = new ByteArray();
                b.writeByte( (value & 0xff0000 ) >> 16  );
                b.writeByte( (value & 0x00ff00 ) >> 8 );
                b.writeByte( (value & 0x0000ff ) );
                b.position = 0;
                
            var c:String = b.readUTFBytes( 3 );
            var str:String = "";
            
            if( value > 255 )
            {
                if( !_printAtEnd && _padCharCode ) { str += ""; }
                str += c;
            }
            else
            {
                if( !_printAtEnd && _padCharCode ) { str += ""; }
                str += ".";
            }
            
            return str;
        }
        
        protected function _process( bytes:ByteArray ):void
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
                //sep += "「B! 」";
                seppad = " ";
                sepH   = "-";
                //sepH += "「B! 」";
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
            hexlen = hex.length;
            
            seplen = (seppad.length * 2) + sep.length;
            sepend = sep.length;
            
            var ext:uint = 0;
            if( _printCharCode && _printAtEnd )
            {
                ext = (columns * ratio) + seplen;
            }
            
            var line:String = "";
            while( line.length < (columns * (hexlen + _table.minPadding + seplen)) + sepend + ext )
            {
                line += sepH;
            }
            
            if( _printLines )
            {
                var header:Printer = _table.addSpannedRow();
                header.println( line );
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
                    
                    row.push( hex );
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
                    
                    row.push( leftspace + mode );
                }
                
                _table.addRow( row, false, " ", sep, seppad );
                
                if( _printLines )
                {
                    var spliter:Printer = _table.addSpannedRow();
                    spliter.println( line );
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
                        hex = "0x" + hex;
                    }

                    //hex += "「G! 」";
                    
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
                footer.println( line );
            }
            
        }
        
        
        public function get printCharCode():Boolean { return _printCharCode; }
        public function set printCharCode( value:Boolean ):void { _printCharCode = value; }
        
        public function get padCharCode():Boolean { return _padCharCode; }
        public function set padCharCode( value:Boolean ):void { _padCharCode = value; }
        
        public function get printAtEnd():Boolean { return _printAtEnd; }
        public function set printAtEnd( value:Boolean ):void { _printAtEnd = value; }
        
        public function get printHeader():Boolean { return _printHeader; }
        public function set printHeader( value:Boolean ):void { _printHeader = value; }
        
        public function get printLines():Boolean { return _printLines; }
        public function set printLines( value:Boolean ):void { _printLines = value; }
        
        public function get printHexHead():Boolean { return _printHexHead; }
        public function set printHexHead( value:Boolean ):void { _printHexHead = value; }
        
        public function get printUnicode():Boolean { return _printUnicode; }
        public function set printUnicode( value:Boolean ):void { _printUnicode = value; }
        
        public function get printUtf8():Boolean { return _printUtf8; }
        public function set printUtf8( value:Boolean ):void { _printUtf8 = value; }
        
        public function addBytes( bytes:ByteArray ):void
        {
            _bytes = bytes;
        }
        
        public function print( printer:Printer ):void
        {
            if( _bytes )
            {
                _process( _bytes );
                _table.print( printer );
            }
            else
            {
                throw new Error( "bytes not defined" );
            }
        }
        
        public function toString():String
        {
            return "";
        }
    }
}