package {
	import com.fastframework.core.utils.StringUtils;

	import flash.display.BitmapData;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class MultiFont {
		public static function getFontSet(charCode:int,fontName:String,fontCount:int=16):String{
			//unicode code point
			var codeCount:int = fontCount<<4;
			var snap:int = Math.floor(charCode/codeCount)*codeCount;
			return fontName+'_'+StringUtils.fillPrefixZero(snap.toString(16), 5)+'.swf';
		}

		public static function getFontName(charCode : int, fontName : String,cmap:BitmapData=null) : String {
			//search code map, if charCode fall in cat 1, use xxxx1
			var subset:int = (cmap==null)?0:cmap.getPixel(charCode&0xFF,charCode>>8)&0xF;
			if(subset==0xF)return 'no_font';
			var snap:int = charCode&0xFFFF0|subset;

			return fontName+'_'+StringUtils.fillPrefixZero(snap.toString(16),5);
		}

		public static function getCharCodeScriptCode(charCode : int, cmap:BitmapData) : int {
			return cmap.getPixel(charCode&0xFF,charCode>>8);
		}

	}
}
