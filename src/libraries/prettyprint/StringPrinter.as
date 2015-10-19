/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{
	
    /**
     * Accumulates strings into a <code>String</code> without printing them.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public final class StringPrinter implements Printer
    {
        private var _str:String;
        private var _separator:String;
        
        public function StringPrinter( str:String = "", separator:String = "\n" )
        {
            super();
            _str       = str;
            _separator = separator;
        }
        
        public function println( str:String ):void
        {
            _str += str + _separator;
        }

        public function toString():String
        {
        	return _str;
        }
    }
}
