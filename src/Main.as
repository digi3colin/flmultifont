package {
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
	public class Main extends Sprite {
		private var txtOutput:TextField;
		private var txtInput:TextField;
		private var btnExec:ButtonClip;
	
		public function Main() {
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
			var fontPerSet:int = 8;

			for(i=startPoint; i<0x0FFFF; i+=fontPerSet*16){
				makeFile(i,fontPerSet,"script");
			}
//			makeFile(0x4180,fontPerSet,"script");

			var file:File = File.documentsDirectory;
			file = file.resolvePath("font/cmap.png");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(PNGEncoder.encode(bmpCMap.bitmapData, {}));
			fileStream.close();
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
		private function setupClickMap(cmap:BitmapData):void{
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
				MultiFont.getFontSet(charCode, 'script',8),
				MultiFont.getFontName(charCode,'script',bmpCMap.bitmapData),
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

			var fontSetName:String = MultiFont.getFontSet(startPoint, fontName,fontsPerSet);

			var sourceFontFile:Array = [];

			sourceFontFile['Latin0']	 			= fontName+'_latin0.otf';
			sourceFontFile['Han0']		 			= fontName+'_han0.otf';
			sourceFontFile['Han1'] 					= fontName+'_han1.ttf';

			var sResult:Array=[];
			sResult.push('<?xml version="1.0" encoding="utf-8"?>');
			sResult.push('<library name="'+fontSetName.split('.swf')[0]+'" output="bin\\swf\\font" format="0" static="false">');

			for(var i:int=startPoint;i<(startPoint+(fontsPerSet*16));i+=16){
				// if block is not in allow list, skip it
				var allowScriptsFound:Boolean = false;
				if(allowScriptsFound==false){
					for(var k:int=0;k<allowScripts.length;k++){
						allowScriptsFound = (allowScripts[k]== UnicodeScriptsTable.instance().getScriptByCode(MultiFont.getCharCodeScriptCode(i, bmpCMap.bitmapData)&0xFFFFF0));
						if(allowScriptsFound)break;
					}
				}
				if(allowScriptsFound==false)continue;

				//look for how many subset;
				var subsetCount:int = 0;
				var j:int;
				for(j=i;j<(i+16);j++){
					//0xFFFFFF is no font. no subset
					if(MultiFont.getCharCodeScriptCode(j,bmpCMap.bitmapData)==0xFFFFFF)continue;
					subsetCount = Math.max(MultiFont.getCharCodeScriptCode(j,bmpCMap.bitmapData)&0xF,subsetCount);
				}

				//check any char to embed
				var needEmbed:Boolean=false;
				for(j=i;j<(i+16);j++){
					//0xFFFFFF is no font. no subset
					needEmbed = (needEmbed || (MultiFont.getCharCodeScriptCode(j,bmpCMap.bitmapData)!=0xFFFFFF));
				}
				if(needEmbed==false)continue;

				//create the font list
				for(var l:int=0;l<=subsetCount;l++){
					var snap:int = i&0xFFFF0|l;
					var fontId:String = fontName+'_'+StringUtils.fillPrefixZero(snap.toString(16),5);
					
					sResult.push('<font id="'+fontId+'" family="Arial" style="0" cs="" type="1" path="'+sourceFontFile[range[i]+l]+'" ascff="false" autoId="false">');				
					var strChars:String = '';
					for(j=i;j<(i+16);j++){
						//if char is no font, no need to embed
						if(MultiFont.getCharCodeScriptCode(j,bmpCMap.bitmapData)==0xFFFFFF)continue;
						strChars += 'U+'+StringUtils.fillPrefixZero(j.toString(16),5);
					}
					sResult.push('<include chars="'+strChars+'"/>');
					sResult.push('</font>');
				}
			}
			sResult.push('</library>');

			txtOutput.text = sResult.join('\n');

			//if script allow not found, do not export ffl
			if(sResult.length<=3)return;

			trace(startPoint.toString(16));

			var file:File = File.documentsDirectory;
			file = file.resolvePath("font/"+fontSetName.split('.swf')[0]+'.ffl');
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(sResult.join('\n'));
			fileStream.close();
		}
	}
}
