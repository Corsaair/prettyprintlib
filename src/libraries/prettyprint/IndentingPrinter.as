/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print with indentation.
     * 
     * @playerversion Flash 9
     * @playerversion AIR 1.0
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public class IndentingPrinter implements Printer
    {
        private var _delegate:Printer;
        private var _currentIndent:String;
        private var _indent:uint;
        private var _indentIncrement:uint;
        
        public function IndentingPrinter( delegate:Printer,
                                          initialIndent:uint,
                                          indentIncrement:uint )
        {
            super();
            
            _delegate        = delegate;
            _indent          = initialIndent;
            _currentIndent   = _indentToString( initialIndent );
            _indentIncrement = indentIncrement;
        }
        
        private function _indentToString( indent:uint ):String
        {
            var str:String = "";
            
            for( var i:uint = 0; i < indent; ++i )
            {
                str += " ";
            }
            
            return str;
        }
        
        public function indent():void
        {
            _indent++;
            var newIndent:uint = _currentIndent.length + _indentIncrement;
            _currentIndent = _indentToString( newIndent );
        }
        
        public function unindent():void
        {
            if( _indent == 0 )
            {
                return;
            }
            _indent--;
            var newIndent:uint = _currentIndent.length - _indentIncrement;
            _currentIndent = _indentToString( newIndent );
        }
        
        public function println( str:String ):void
        {
            if( str.length > 0 )
            {
                str = _currentIndent + str;
            }
            
            _delegate.println( str );
        }
    }
}