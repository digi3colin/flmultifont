package {
	import doot.MultiFontText;
	import flash.text.AntiAliasType;
	import doot.ResolveLink;
	import com.fastframework.view.ButtonClip;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class MainLoad extends Sprite {
		private var txtOutput:TextField;
		private var txtInput:TextField;
		private var btnExec:ButtonClip;
		private var utf:MultiFontText;

		public function MainLoad() {
			ResolveLink.instance().setup(this, '');
			
			btnExec = new ButtonClip(this['btn_exec']);
			txtInput = this['txt_input'];
			txtOutput = this['txt_output'];
			txtOutput.embedFonts = true;
			
			utf = new MultiFontText('body');
			utf.when(MultiFontText.EVENT_LOAD_RANGE_READY, fontLoaded);			

			btnExec.when(ButtonClipEvent.CLICK,exec);
			
			trace(0xFF);
		}

		private function exec(e:Event):void{

			var str:String  = '';
/*			for(var i:int=0x2F;i<0x5F;i++){
				str+=String.fromCharCode(i);
			}*/
			str+='埗A';
			utf.setText(str);
		}
		
		private function fontLoaded(e:Event):void{
			txtOutput.antiAliasType = AntiAliasType.ADVANCED;
			txtOutput.htmlText = utf.getHTMLText();
		}
	}
}
