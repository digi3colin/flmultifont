package {
	import com.fastframework.core.utils.StringUtils;
	import com.fastframework.net.ILoader;
	import com.fastframework.net.LoaderEvent;
	import com.fastframework.net.LoaderFactory;
	import com.fastframework.view.ButtonClip;
	import com.fastframework.view.events.ButtonClipEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class MainTestCharacter extends Sprite {
		private var txtOutput:TextField;
		private var txtInput:TextField;
		private var btnExec:ButtonClip;
		private var keyLang:Array=[];

		public function MainTestCharacter() {
			keyLang['Uppercase'] 			= 0xFF0000;
			keyLang['Lowercase'] 			= 0xCC0000;
			keyLang['Numerals'] 			= 0x990000;
			keyLang['Punctuation'] 			= 0x660000;
			keyLang['Latin'] 				= 0x330000;
			keyLang['Japanese'] 			= 0xFFFF00;
			keyLang['Hangul'] 				= 0xCCCC00;
			keyLang['TraditionalChinese'] 	= 0x00FF00;
			keyLang['SimplifiedChinese'] 	= 0x00CC00;
			keyLang['Thai'] 				= 0x000099;
			keyLang['Devanagari'] 			= 0x000066;
			keyLang['Greek'] 				= 0xFF9900;
			keyLang['Cyrillic'] 			= 0xFF6600;
			keyLang['Armenian'] 			= 0xFF3300;
			keyLang['Arabic'] 				= 0x0000FF;
			keyLang['Hebrew'] 				= 0x0000CC;

			btnExec = new ButtonClip(this['btn_exec']);
			txtInput = this['txt_input'];
			txtOutput = this['txt_output'];

			btnExec.when(ButtonClipEvent.CLICK,exec);
			

			trace(Math.sqrt(0xE01EF));
			var str:String = "鰂魚埗𨳒攰";
			txtOutput.text = str;
			var codePoints:Vector.<int> = StringUtils.toCharCode(str);
			for(var i:int=0;i<codePoints.length;i++){
				trace(String.fromCharCode(codePoints[i])+','+codePoints[i]+','+codePoints[i].toString(16));
			}
		}

		
		private function exec(e:Event):void{
			var loader:ILoader = LoaderFactory.instance().getXMLLoader();
			loader.once(LoaderEvent.READY, onTableLoaded);
			loader.load('flash-unicode-table.xml');
		}

		private var range:Array=[];
		private var bmpCMap:Bitmap;
		private var mcCMap:Sprite;

		private function onTableLoaded(e:Event):void{
			var xData:XML = ILoader(e.target).getContext();
			var xItems:XMLList = xData.children();
			var i:int;

			var cmap:BitmapData = new BitmapData(256,256,false,0xFFFFFF);

			for(i=0;i<xItems.length();i++){
//			for(i=0;i<1;i++){
				var xRange:XML = ((xItems[i] as XML).children()[0] as XML);
				var lang:String = xRange.attribute('lang');
				var text:String = String(xRange.children()[0]);
				text = text.replace(/U\+/gi, "");
				var ranges:Array = text.split(',');
				for(var j:int=0;j<ranges.length;j++){
					var strRange:Array = String(ranges[j]).split('-');
					var start:int = parseInt(strRange[0],16);

					if(strRange.length>1){
						var end:int = parseInt(strRange[1],16);
						
						for(var k:int=start;k<=end;k++){
							cmap.setPixel(k&0x00FF,k>>8 , keyLang[lang]);
							range[k] = lang;
						}
						continue;
					}
					range[start]=lang;
					cmap.setPixel(k>>8, y, keyLang[lang]);
				}
			}

			//make cmap clickable
			mcCMap = new Sprite();
			mcCMap.x = 20;
			mcCMap.y = 20;
			mcCMap.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			mcCMap.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);

			bmpCMap = new Bitmap(cmap);
			mcCMap.addChild(bmpCMap);

			this.addChild(mcCMap);
		}
		private function onStopDrag(event : MouseEvent) : void {
			mcCMap.removeEventListener(MouseEvent.MOUSE_MOVE, onCMapClick);
		}

		private function onStartDrag(event : MouseEvent) : void {
			mcCMap.addEventListener(MouseEvent.MOUSE_MOVE, onCMapClick);
		}

		private function onCMapClick(event : MouseEvent) : void {
			var charCode:int = (event.localY<<8)|event.localX;
			txtOutput.text = String.fromCharCode(charCode);
			trace(event.localX,event.localY,charCode);
		}
		

	}
}
