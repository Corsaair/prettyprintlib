/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print single line comment.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public final class CommentPrinter implements Printer
    {
        private var _delegate:Printer;
        
        public function CommentPrinter( delegate:Printer )
        {
            _delegate = delegate;
        }
        
        public function println( str:String ):void
        {
            if( str.length > 0 )
            {
                _delegate.println( "// " + str );
            }
            else
            {
                _delegate.println( "" );
            }
        }
    }
}