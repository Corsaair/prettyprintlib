/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package libraries.prettyprint
{

    /**
     * Print with ANSI colors.
     * 
     * @playerversion Flash 9
     * @playerversion AVM 0.4
     * @langversion 3.0
     */
    public final class AnsiPrinter implements Printer
    {
        private var _delegate:Printer;

        private var _printAnsi:Boolean;
        private var _color:String;
        
        public function AnsiPrinter( delegate:Printer, color:String = "" )
        {
            _delegate  = delegate;
            _color     = color;
            _printAnsi = true;
        }
        
        private function _cleanupANSI( a:String, before:String = "「", after:String = "」" ):String
        {
            a += before + after;
            
            var str:String = "";
            var re:RegExp = new RegExp( "(?P<word>.*?)" + "\\" + before + "(?P<ansi>.*?)" + "\\" + after , "g" );
            var match:*;
            
            while( match = re.exec( a ) )
            {
                str += match.word;
            }
            
            return str;
        }

        private function _removeANSI( ansi:String, before:String = "「", after:String = "」" ):String
        {
            if( ansi.indexOf( "\n" ) > -1 )
            {
                var lines:Array = ansi.split( "\n" );
                var i:uint;
                var len:uint = lines.length;
                for( i = 0; i < len; i++ )
                {
                    lines[i] = _cleanupANSI( lines[i] );
                }
                return lines.join( "\n" );
            }
            else
            {
                return _cleanupANSI( ansi );
            }
        }

        public function println( str:String ):void
        {

            //encoding.ansi.AnsiString
            var C:Class;
            var ansi:String = "";
            
            try
            {
                C = getClassByName( "encoding.ansi.AnsiString" );
            }
            catch( e:Error )
            {
                //don't throw
            }
            
            if( C )
            {
                var astr:* = new C( str + _color );
                if( _printAnsi )
                {
                    ansi = astr.toString();
                }
                else
                {
                    ansi = astr.valueOf();
                }
            }
            else
            {
                ansi = _removeANSI( str );
            }
            
            
            _delegate.println( ansi );
        }
    }
}
