package
{
	import mx.core.FontAsset;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;
	import flash.utils.describeType;

	public class script_00080 extends Sprite
	{
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_00080", unicodeRange="U+0080,U+0081,U+0082,U+0083,U+0084,U+0085,U+0086,U+0087,U+0088,U+0089,U+008A,U+008B,U+008C,U+008D,U+008E,U+008F")] // chars=""
		public  var script_00080:Class;
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_00090", unicodeRange="U+0090,U+0091,U+0092,U+0093,U+0094,U+0095,U+0096,U+0097,U+0098,U+0099,U+009A,U+009B,U+009C,U+009D,U+009E,U+009F")] // chars=""
		public  var script_00090:Class;
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_000a0", unicodeRange="U+00A0,U+00A1,U+00A2,U+00A3,U+00A4,U+00A5,U+00A6,U+00A7,U+00A8,U+00A9,U+00AA,U+00AB,U+00AC,U+00AD,U+00AE,U+00AF")] // chars=" ¡¢£¤¥¦§¨©ª«¬­®¯"
		public  var script_000a0:Class;
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_000b0", unicodeRange="U+00B0,U+00B1,U+00B2,U+00B3,U+00B4,U+00B5,U+00B6,U+00B7,U+00B8,U+00B9,U+00BA,U+00BB,U+00BC,U+00BD,U+00BE,U+00BF")] // chars="°±²³´µ¶·¸¹º»¼½¾¿"
		public  var script_000b0:Class;
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_000c0", unicodeRange="U+00C0,U+00C1,U+00C2,U+00C3,U+00C4,U+00C5,U+00C6,U+00C7,U+00C8,U+00C9,U+00CA,U+00CB,U+00CC,U+00CD,U+00CE,U+00CF")] // chars="ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏ"
		public  var script_000c0:Class;
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_000d0", unicodeRange="U+00D0,U+00D1,U+00D2,U+00D3,U+00D4,U+00D5,U+00D6,U+00D7,U+00D8,U+00D9,U+00DA,U+00DB,U+00DC,U+00DD,U+00DE,U+00DF")] // chars="ÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞß"
		public  var script_000d0:Class;
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_000e0", unicodeRange="U+00E0,U+00E1,U+00E2,U+00E3,U+00E4,U+00E5,U+00E6,U+00E7,U+00E8,U+00E9,U+00EA,U+00EB,U+00EC,U+00ED,U+00EE,U+00EF")] // chars="àáâãäåæçèéêëìíîï"
		public  var script_000e0:Class;
		[Embed(source="script_latin0.otf", mimeType="application/x-font-truetype", fontName="script_000f0", unicodeRange="U+00F0,U+00F1,U+00F2,U+00F3,U+00F4,U+00F5,U+00F6,U+00F7,U+00F8,U+00F9,U+00FA,U+00FB,U+00FC,U+00FD,U+00FE,U+00FF")] // chars="ðñòóôõö÷øùúûüýþÿ"
		public  var script_000f0:Class;

		public function script_00080()
		{
			FontAsset;
			Security.allowDomain("*");
			var xml:XML = describeType(this);
			for (var i:uint = 0; i < xml.variable.length(); i++)
			{
				Font.registerFont(this[xml.variable[i].@name]);
			}
		}
	}
}