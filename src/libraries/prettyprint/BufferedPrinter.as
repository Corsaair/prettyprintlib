/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Accumulates strings into a buffer without printing them.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public class BufferedPrinter implements Printer
    {
        private var _buffer:Array;
        private var _newline:String;

        public function BufferedPrinter( newline:String = "\n" )
        {
            super();
            _buffer = [];
            _newline = newline;
        }
        
        public function println( str:String ):void
        {
            _buffer.push( str );
        }
        
        public function toString():String
        {
            var str:String = "";
                str += _buffer.join( _newline );
            
            return str;
        }
    }
}