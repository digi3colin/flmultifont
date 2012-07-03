package {
	import com.fastframework.net.LoaderEvent;
	import doot.LoadAsset;

	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.core.utils.StringUtils;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderFactory;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class UnicodeEmbedTextField extends FASTEventDispatcher{
		public static const EVENT_READY:String = "EVENT_READY";
		public static const EVENT_CHANGE:String = "EVENT_CHANGE";
		public static const EVENT_LOAD_RANGE_START:String = "EVENT_LOAD_RANGE_START";
		public static const EVENT_LOAD_RANGE_READY : String = "EVENT_LOAD_RANGE_READY";
		public static const EVENT_LOAD_RANGE_CHANGE : String = "EVENT_LOAD_RANGE_CHANGE";

		private var text : String;
		private var fontShortName : String;
		private var loadAsset:LoadAsset;
		private var mcCmap:Sprite;
		
		private var cmap:BitmapData;

		public function UnicodeEmbedTextField(fontShortName:String) {
			//4 byte utf8 have 1FFFFF code point.
			//1FFFFF = 2097151 bits = 262144 bytes;
			//codepoint=0x4E12, codeRange=0x4E1, fontRange=0x4E
			//every fontRange has 16 code point = 16348
			this.fontShortName = fontShortName;
			loadAsset = new LoadAsset();
			loadAsset.when(LoadAsset.EVENT_READY,loadReady);

			var cmapLoader:ILoader = LoaderFactory.instance().getSWFLoader(mcCmap = new Sprite());
			cmapLoader.once(LoaderEvent.READY, onCmapLoaded);
			cmapLoader.load('cmap.png');
		}

		private function onCmapLoaded(e:Event):void{
			cmap = new BitmapData(mcCmap.width, mcCmap.height,false,0);
			cmap.draw(mcCmap);
			dispatchEvent(new Event(UnicodeEmbedTextField.EVENT_READY));
		}

		private function loadReady(e:Event):void{
			dispatchEvent(new Event(UnicodeEmbedTextField.EVENT_LOAD_RANGE_READY));
		}

		public function setText(text:String):void{
			var codePoints:Vector.<int> = StringUtils.toCharCode(text);
			this.text = text;

			for(var i:int=0;i<codePoints.length;i++){
				loadAsset.loadAsset('font/'+MultiFont.getFontSet(codePoints[i], 'script', 8));
			}
		}

		public function getHTMLText(size:int=12):String{
			if(loadAsset.getPendingCount()>0)return '...';

			//parse every char with specific font.
			var result:String = '';
			var codePoints:Vector.<int> = StringUtils.toCharCode(text);
			var count:int = codePoints.length;

			for(var i:int=0;i<count;i++){
				result += '<font face="'+MultiFont.getFontName(codePoints[i], 'script', cmap)+'" size="'+size+'">'+String.fromCharCode(codePoints[i])+'<font>';
			}
			return result;
		}
	}
}