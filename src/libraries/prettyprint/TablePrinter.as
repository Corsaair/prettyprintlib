/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print tables.
     * 
     * @playerversion Flash 10
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public final class TablePrinter
    {
        private var _columns:uint;
        private var _minPadding:uint;
        private var _rows:Vector.<Row>;
        
        public function TablePrinter( columns:uint, minPadding:uint )
        {
            _columns    = columns;
            _minPadding = minPadding;
            _rows       = new Vector.<Row>();
        }
        
        public function get columns():uint { return _columns; }
        public function set columns( value:uint ):void { _columns = value; }
        
        public function get minPadding():uint { return _minPadding; }
        public function set minPadding( value:uint ):void { _minPadding = value; }
        
        public function addRow( data:Array,
                                padLeft:Boolean = false, padChar:String = " ",
                                separator:String = "", separatorPadChar:String = " " ) : void
        {
            if( data.length != _columns )
            {
                throw new Error( "Invalid row" );
            }
            
            _rows.push( new RowPrinter( data, padLeft, padChar, separator, separatorPadChar ) );
        }
        
        public function addSpannedRow():Printer
        {
            var printer:SpannedRowPrinter = new SpannedRowPrinter();
            
            _rows.push( printer );
            
            return printer;
        }
        
        public function print( printer:Printer ):void
        {
            var colWidths:Array = new Array( _columns );
            var i:uint;
            var row:Row;
            
            for( i = 0; i < _columns; ++i )
            {
                colWidths[i] = 0;
            }
            
            for each( row in _rows )
            {
                row.measure( colWidths, _minPadding );
            }
            
            for each( row in _rows )
            {
                row.print( printer, colWidths );
            }
        }
        
        public function toString():String
        {
            return "";
        }
    }
}