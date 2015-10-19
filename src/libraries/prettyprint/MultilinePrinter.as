/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print single line to multiple lines.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public final class MultilinePrinter implements Printer
    {
        private var _delegate:Printer;
        
        public function MultilinePrinter( delegate:Printer )
        {
            _delegate = delegate;
        }
        
        public function println( str:String ):void
        {
            var lines:Array = str.split( "\n" );

            for( var i:uint = 0; i < lines.length; i++ )
            {
            	_delegate.println( lines[i] );
            }
        }
    }
}
