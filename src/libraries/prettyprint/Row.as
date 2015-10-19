/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * The Row interface.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public interface Row
    {

        /**
         * 
         * 
         * @playerversion Flash 9
         * @playerversion AIR 1.0
         * @playerversion AVM 0.4
         * @langversion 3.0
         */
        function measure( colWidths:Array, minPadding:uint ):void;

        /**
         * 
         * 
         * @playerversion Flash 9
         * @playerversion AIR 1.0
         * @playerversion AVM 0.4
         * @langversion 3.0
         */
        function print( printer:Printer, colWidths:Array ):void;
    }
}