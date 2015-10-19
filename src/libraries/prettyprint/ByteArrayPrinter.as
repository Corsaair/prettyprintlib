/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{
    import flash.utils.ByteArray;

    /**
     * Accumulates strings into a <code>ByteArray</code> without printing them.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public final class ByteArrayPrinter implements Printer
    {
        private var _bytes:ByteArray;
        private var _separator:String;
        
        public function ByteArrayPrinter( bytes:ByteArray, separator:String = "\n" )
        {
            super();
            _bytes     = bytes;
            _separator = separator;
        }
        
        public function println( str:String ):void
        {
            _bytes.writeUTFBytes( str + _separator );
        }
    }
}