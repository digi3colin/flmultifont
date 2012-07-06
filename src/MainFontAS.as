package {
	import doot.MultiFontText;
	import doot.model.encoder.PNGEncoder;

	import com.fastframework.core.utils.StringUtils;
	import com.fastframework.view.ButtonClip;
	import com.fastframework.view.events.ButtonClipEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.text.TextField;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class MainFontAS extends Sprite {
		private var txtOutput:TextField;
		private var txtInput:TextField;
		private var btnExec : ButtonClip;
		private var fontSetNames : Vector.<String>;

		public function MainFontAS() {
			btnExec = new ButtonClip(this['btn_exec']);
			txtInput = this['txt_input'];
			txtOutput = this['txt_output'];

			btnExec.when(ButtonClipEvent.CLICK,exec);
		}
		
		private function exec(e:Event):void{
			onTableLoaded(e);
		}

		private var range:Array=[];
		private function onTableLoaded(e:Event):void{
			fontSetNames = new Vector.<String>();
			var xData:XML = UnicodeTable.instance().xData;
			var xItems:XMLList = xData.children();
			var i:int;

			var cmap:BitmapData = new BitmapData(256,256,false,0xFFFFFF);

			for(i=0;i<xItems.length();i++){
//			for(i=0;i<1;i++){
				var xRange:XML = xItems[i] as XML;
				var scriptName:String = xRange.attribute('script');
				var text:String = String(xRange.children()[0]);
				text = text.replace(/U\+/gi, "");
				var ranges:Array = text.split(',');
				for(var j:int=0;j<ranges.length;j++){
					var strRange:Array = String(ranges[j]).split('-');
					var start:int = parseInt(strRange[0],16);

					if(strRange.length>1){
						var end:int = parseInt(strRange[1],16);
						
						for(var k:int=start;k<=end;k++){
							cmap.setPixel(k&0x00FF,k>>8 , UnicodeScriptsTable.instance().getCodeByScript(scriptName));
							range[k] = scriptName;
						}
						continue;
					}
					range[start]=scriptName;
					cmap.setPixel(k>>8, y, UnicodeScriptsTable.instance().getCodeByScript(scriptName));
				}
			}

			drawSubset(cmap);
			setupClickMap(cmap);

			var startPoint:int = 0x00000;
			var fontPerSet:int = 4;

			for(i=startPoint; i<0x0FFFF; i+=fontPerSet*16){
				makeFile(i,fontPerSet,"script");
			}
//			makeFile(0x4180,fontPerSet,"script");

			var file:File = File.documentsDirectory;
			file = file.resolvePath("fontMaker/cmap.png");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(PNGEncoder.encode(bmpCMap.bitmapData, {}));
			fileStream.close();

			makeBuild();
		}

		private function drawSubset(cmap:BitmapData):void{
			var i:int;
			var table:Vector.<int>;
			var codePoint:int;

			table = UnicodeTable.instance().HAN1;
			UnicodeScriptsTable.instance().addScript('Han1',UnicodeScriptsTable.instance().getCodeByScript('Han')|0x1);

			for(i=0;i<table.length;i++){
				codePoint = table[i];
				cmap.setPixel(codePoint&0x00FF,codePoint>>8, UnicodeScriptsTable.instance().getCodeByScript('Han1'));
			}

			table = UnicodeTable.instance().NOT_LETTER;
			UnicodeScriptsTable.instance().addScript('NotLetter',0xFFFFFF);
			for(i=0;i<table.length;i++){
				codePoint = table[i];
 				cmap.setPixel(codePoint&0x00FF,codePoint>>8, UnicodeScriptsTable.instance().getCodeByScript('NotLetter'));
			}
		}

		private var mcCMap:Sprite;
		private var bmpCMap:Bitmap;
		private var mcCursor:Sprite;
		
		private var model:MultiFontText;
		private function setupClickMap(cmap:BitmapData):void{
			model = new MultiFontText('script');
			
			//make cmap clickable
			mcCMap = new Sprite();
			mcCMap.scaleX = mcCMap.scaleY = 2;
			mcCMap.x = 20;
			mcCMap.y = 20;
			mcCMap.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			mcCMap.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);

			bmpCMap = new Bitmap(cmap);
			mcCMap.addChild(bmpCMap);

			this.addChild(mcCMap);
			
			mcCursor = new Sprite();
			mcCursor.graphics.beginFill(0xFFFFFF, 0.5);
			mcCursor.graphics.drawRect(0, 0, 32, 2);
			mcCursor.mouseEnabled = false;
			this.addChild(mcCursor);
		}

		private function onStopDrag(event : MouseEvent) : void {
			mcCMap.removeEventListener(MouseEvent.MOUSE_MOVE, onCMapClick);
		}

		private function onStartDrag(event : MouseEvent) : void {
			mcCMap.addEventListener(MouseEvent.MOUSE_MOVE, onCMapClick);
		}

		private function onCMapClick(event : MouseEvent) : void {
			var charCode:int = (event.localY<<8)|event.localX;
			txtOutput.text = (String.fromCharCode(charCode));
			trace(
				model.getFontSet(charCode, 'script',8),
				model.getFontName(charCode,'script',bmpCMap.bitmapData),
				charCode,"0x"+StringUtils.fillPrefixZero(charCode.toString(16),5));

			var snapCharCode:int = charCode&0xFFFFF0;//round 16 char;
			
			var pt:Point = mcCMap.localToGlobal(new Point(snapCharCode&0xFF,snapCharCode>>8));

			mcCursor.x = pt.x;
			mcCursor.y = pt.y;
		}

		private function makeFile(startPoint:int,fontsPerSet:int=0x10,fontName:String="body"):void{
//			var sFontStartPoint:String 	= StringUtils.fillPrefixZero(startPoint.toString(16),5);
//			var lastCodePoint:int = startPoint+fontsPerSet-1;
			//allow scripts:
			var allowScripts:Array = ['Han','Latin'];

			var fontSetName:String = model.getFontSet(startPoint, fontName,fontsPerSet).split('.swf')[0];

			var sourceFontFile:Array = [];

			sourceFontFile['Latin0']	 			= fontName+'_latin0.otf';
			sourceFontFile['Han0']		 			= fontName+'_han0.otf';
			sourceFontFile['Han1'] 					= fontName+'_han1.ttf';

			var sResult:Array=[];
			sResult.push('package{');
			sResult.push('import mx.core.FontAsset;');
			sResult.push('import flash.display.Sprite;');
			sResult.push('import flash.system.Security;');
			sResult.push('import flash.text.Font;');
			sResult.push('import flash.utils.describeType;');
			sResult.push('public class '+fontSetName.toUpperCase()+' extends Sprite{');

			for(var i:int=startPoint;i<(startPoint+(fontsPerSet*16));i+=16){
				// if block is not in allow list, skip it
				var allowScriptsFound:Boolean = false;
				if(allowScriptsFound==false){
					for(var k:int=0;k<allowScripts.length;k++){
						allowScriptsFound = (allowScripts[k]== UnicodeScriptsTable.instance().getScriptByCode(model.getCharCodeScriptCode(i, bmpCMap.bitmapData)&0xFFFFF0));
						if(allowScriptsFound)break;
					}
				}
				if(allowScriptsFound==false)continue;

				//look for how many subset;
				var subsetCount:int = 0;
				var j:int;
				for(j=i;j<(i+16);j++){
					//0xFFFFFF is no font. no subset
					if(model.getCharCodeScriptCode(j,bmpCMap.bitmapData)==0xFFFFFF)continue;
					subsetCount = Math.max(model.getCharCodeScriptCode(j,bmpCMap.bitmapData)&0xF,subsetCount);
				}

				//check any char to embed
				var needEmbed:Boolean=false;
				for(j=i;j<(i+16);j++){
					//0xFFFFFF is no font. no subset
					needEmbed = (needEmbed || (model.getCharCodeScriptCode(j,bmpCMap.bitmapData)!=0xFFFFFF));
				}
				if(needEmbed==false)continue;

				var strChars:Array = [];
				//create the font list
				for(var l:int=0;l<=subsetCount;l++){
					var snap:int = i&0xFFFF0|l;
					var fontId:String = fontName+'_'+StringUtils.fillPrefixZero(snap.toString(16),5);

					strChars = [];
					for(j=i;j<(i+16);j++){
						//if char is no font, no need to embed
						if(model.getCharCodeScriptCode(j,bmpCMap.bitmapData)==0xFFFFFF)continue;
						strChars.push('U+'+StringUtils.fillPrefixZero(j.toString(16),4));
					}
					sResult.push('[Embed(source="'+sourceFontFile[range[i]+l]+'", mimeType="application/x-font-truetype", fontName="'+fontId+'", unicodeRange="'+strChars.join(",")+'")]');
					sResult.push('public  var '+fontId+':Class;');
				}
			}
			sResult.push('public function '+fontSetName.toUpperCase()+'(){');
			sResult.push('FontAsset;');
			sResult.push('Security.allowDomain("*");');
			sResult.push('var xml:XML = describeType(this);');
			sResult.push('for (var i:uint = 0; i < xml.variable.length(); i++)');
			sResult.push('{Font.registerFont(this[xml.variable[i].@name]);}}}}');

			txtOutput.text = sResult.join('\n');

			//if script allow not found, do not export ffl
			if(sResult.length<=13)return;

			trace(startPoint.toString(16));

			var file:File = File.documentsDirectory;
			file = file.resolvePath("fontMaker/"+fontSetName.toUpperCase()+'.as');
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(sResult.join('\n'));
			fileStream.close();

			fontSetNames.push(fontSetName);
		}
		
		private function makeBuild():void{
			var sResult:Array = [];
			sResult.push('<project>');
			sResult.push('<target name="default">');
			for(var i:int=0;i<fontSetNames.length;i++){
				sResult.push('<fdt.launch.application projectname="FontMaker" mainclass="'+fontSetNames[i].toUpperCase()+'.as" target="../bin/'+fontSetNames[i]+'.swf"/>');
			}
			sResult.push('</target>');
			sResult.push('</project>');

			var file:File = File.documentsDirectory;
			file = file.resolvePath("fontMaker/build.xml");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(sResult.join('\n'));
			fileStream.close();
		}
	}
}
