/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print a <code>Row</code> inside a Table.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     * 
     * @see TablePrinter
     */
    public final class RowPrinter implements Row
    {
        private var _cells:Array;
        private var _padLeft:Boolean;
        private var _padChar:String;
        
        private var _separator:String;
        private var _separatorPadChar:String;
        
        public function RowPrinter( cells:Array,
                                    padLeft:Boolean = false, padChar:String = " ",
                                    separator:String = "", separatorPadChar:String = " " )
        {
            super();
            
            _cells            = cells;
            _padLeft          = padLeft;
            _padChar          = padChar;
            _separator        = separator;
            
            if( _separator == "" )
            {
                separatorPadChar = "";
            }
            _separatorPadChar = separatorPadChar;
        }
        
        private function _pad( s:String, minLength:uint, char:String = " ", left:Boolean = false ):String
        {
            while( _getLength(s) < minLength )
            {
                if( !left )
                {
                    s += char;
                }
                else
                {
                    s = char + s;
                }
            }
            
            return s;
        }
        
        private function _getLength( a:String, before:String = "「", after:String = "」" ):uint
        {
            if( a == null ) {return 0;}

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

        private function _getRowItem( i:uint ):String
        {
            if( _cells[i] === null ) { return null; }
            
            try
            {
                return _cells[i].toString();
            }
            catch( e:* )
            {
                //trace( _cells[0].toString() );
                //trace( i );
                //trace( _cells[i] );
                throw e;
            }
            
            return null;
        }
        
        public function measure( colWidths:Array, minPadding:uint ):void
        {
            for( var i:uint = 0; i < _cells.length; ++i )
            {
                //colWidths[i] = Math.max( colWidths[i], _getRowItem(i).length + minPadding );
                colWidths[i] = Math.max( colWidths[i], _getLength(_getRowItem(i)) + minPadding );
            }
        }
        
        public function print( printer:Printer, colWidths:Array ):void
        {
            var str:String = "";
            
            for( var i:uint = 0; i < _cells.length; ++i )
            {
                //str += _pad( _getRowItem(i), colWidths[i], _padChar, _padLeft );
                if( i > 0 ) { str += _separatorPadChar; }
                str += _separator + _separatorPadChar + _pad( _getRowItem(i), colWidths[i], _padChar, _padLeft );
            }
            str += _separatorPadChar + _separator;
            
            printer.println( str );
        }
    }
}