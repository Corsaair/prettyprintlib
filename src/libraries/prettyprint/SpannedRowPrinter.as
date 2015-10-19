/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print a spanned row into a table.
     * 
     * @playerversion Flash 10
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     * 
     * @see TablePrinter
     */
    public final class SpannedRowPrinter implements Row, Printer
    {
        private var _lines:Vector.<String>;
        
        public function SpannedRowPrinter()
        {
            super();
            _lines = new Vector.<String>();
        }
        
        public function measure( colWidths:Array, minPadding:uint ):void
        {
            //nothing
        }
        
        public function print( printer:Printer, colWidths:Array ):void
        {
            for each( var line:String in _lines )
            {
                printer.println( line );
            }
        }
        
        public function println( str:String ):void
        {
            _lines.push( str );
        }
    }
}