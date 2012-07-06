package
{
	import mx.core.FontAsset;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;
	import flash.utils.describeType;

	public class script_04080 extends Sprite
	{
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_04080", unicodeRange="U+4080,U+4081,U+4082,U+4083,U+4084,U+4085,U+4086,U+4087,U+4088,U+4089,U+408A,U+408B,U+408C,U+408D,U+408E,U+408F")] // chars="䂀䂁䂂䂃䂄䂅䂆䂇䂈䂉䂊䂋䂌䂍䂎䂏"
		public  var script_04080:Class;
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_04090", unicodeRange="U+4090,U+4091,U+4092,U+4093,U+4094,U+4095,U+4096,U+4097,U+4098,U+4099,U+409A,U+409B,U+409C,U+409D,U+409E,U+409F")] // chars="䂐䂑䂒䂓䂔䂕䂖䂗䂘䂙䂚䂛䂜䂝䂞䂟"
		public  var script_04090:Class;
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_040a0", unicodeRange="U+40A0,U+40A1,U+40A2,U+40A3,U+40A4,U+40A5,U+40A6,U+40A7,U+40A8,U+40A9,U+40AA,U+40AB,U+40AC,U+40AD,U+40AE,U+40AF")] // chars="䂠䂡䂢䂣䂤䂥䂦䂧䂨䂩䂪䂫䂬䂭䂮䂯"
		public  var script_040a0:Class;
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_040b0", unicodeRange="U+40B0,U+40B1,U+40B2,U+40B3,U+40B4,U+40B5,U+40B6,U+40B7,U+40B8,U+40B9,U+40BA,U+40BB,U+40BC,U+40BD,U+40BE,U+40BF")] // chars="䂰䂱䂲䂳䂴䂵䂶䂷䂸䂹䂺䂻䂼䂽䂾䂿"
		public  var script_040b0:Class;
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_040c0", unicodeRange="U+40C0,U+40C1,U+40C2,U+40C3,U+40C4,U+40C5,U+40C6,U+40C7,U+40C8,U+40C9,U+40CA,U+40CB,U+40CC,U+40CD,U+40CE,U+40CF")] // chars="䃀䃁䃂䃃䃄䃅䃆䃇䃈䃉䃊䃋䃌䃍䃎䃏"
		public  var script_040c0:Class;
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_040d0", unicodeRange="U+40D0,U+40D1,U+40D2,U+40D3,U+40D4,U+40D5,U+40D6,U+40D7,U+40D8,U+40D9,U+40DA,U+40DB,U+40DC,U+40DD,U+40DE,U+40DF")] // chars="䃐䃑䃒䃓䃔䃕䃖䃗䃘䃙䃚䃛䃜䃝䃞䃟"
		public  var script_040d0:Class;
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_040e0", unicodeRange="U+40E0,U+40E1,U+40E2,U+40E3,U+40E4,U+40E5,U+40E6,U+40E7,U+40E8,U+40E9,U+40EA,U+40EB,U+40EC,U+40ED,U+40EE,U+40EF")] // chars="䃠䃡䃢䃣䃤䃥䃦䃧䃨䃩䃪䃫䃬䃭䃮䃯"
		public  var script_040e0:Class;
		[Embed(source="script_han0.otf", mimeType="application/x-font-truetype", fontName="script_040f0", unicodeRange="U+40F0,U+40F1,U+40F2,U+40F3,U+40F4,U+40F5,U+40F6,U+40F7,U+40F8,U+40F9,U+40FA,U+40FB,U+40FC,U+40FD,U+40FE,U+40FF")] // chars="䃰䃱䃲䃳䃴䃵䃶䃷䃸䃹䃺䃻䃼䃽䃾䃿"
		public  var script_040f0:Class;

		public function script_04080()
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