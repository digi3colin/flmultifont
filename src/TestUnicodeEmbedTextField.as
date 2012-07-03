package {
	import doot.ResolveLink;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class TestUnicodeEmbedTextField extends Sprite {
		private var txt:TextField;
		private var utf:UnicodeEmbedTextField;

		public function TestUnicodeEmbedTextField() {
			txt = this['txt_output'];
			txt.embedFonts = true;
			ResolveLink.instance().setup(this, '');
			
			utf= new UnicodeEmbedTextField('script');
			utf.once(UnicodeEmbedTextField.EVENT_READY, start);
			utf.when(UnicodeEmbedTextField.EVENT_LOAD_RANGE_READY, fontLoaded);

		}

		private function start(e:Event):void{
//			var str:String  = '一丁丂七丄丅丆万丈三上下丌不与丏';//4e00-4e0f (19968-19983)
			var char:String = '1234567Hello WorldMoët發現鰂邨埗经典完结漫画';

			utf.setText(char);		
		}

		private function fontLoaded(e:Event):void{
//			trace(utf.getHTMLText());
			txt.htmlText = utf.getHTMLText(20);
//			trace(TextField(this['txt']).text);
		}
	}
}
