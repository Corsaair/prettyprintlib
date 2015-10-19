/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print to standard output.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public final class TracePrinter implements Printer
    {
        public function TracePrinter()
        {
            super();
        }
        
        public function println( str:String ):void
        {
            trace( str );
        }
    }
}