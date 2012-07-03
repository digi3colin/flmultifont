package {
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	//ref: http://en.wikipedia.org/wiki/Scripts_in_Unicode
	public class UnicodeScriptsTable {
		public static var ins:UnicodeScriptsTable;
		public static function instance():UnicodeScriptsTable{
			return ins || new UnicodeScriptsTable();
		}
		
		private var script:Array = [];
		private var code:Array = [];
		public function UnicodeScriptsTable(){
			if(ins!=null)return;
			ins = this;
			script["Arabic"]             = 0x011000;
			script["Armenian"]           = 0x012000;
			script["Balinese"]           = 0x013000;
			script["Bamum"]              = 0x014000;
			script["Batak"]              = 0x015000;
			script["Bengali"]            = 0x016000;
			script["Bopomofo"]           = 0x017000;
			script["Braille"]            = 0x018000;
			script["Buginese"]           = 0x019000;
			script["Buhid"]              = 0x01a000;
			script["CanadianAboriginal"] = 0x01b000;
			script["Cham"]               = 0x01c000;
			script["Cherokee"]           = 0x01d000;
			script["Common"]             = 0x01e000;
			script["Coptic"]             = 0x01f000;
			script["Cyrillic"]           = 0x021000;
			script["Devanagari"]         = 0x022000;
			script["Ethiopic"]           = 0x023000;
			script["Georgian"]           = 0x024000;
			script["Glagolitic"]         = 0x025000;
			script["Greek"]              = 0x026000;
			script["Gujarati"]           = 0x027000;
			script["Gurmukhi"]           = 0x028000;
			script["Han"]                = 0x029000;
			script["Hangul"]             = 0x02a000;
			script["Hanunoo"]            = 0x02b000;
			script["Hebrew"]             = 0x02c000;
			script["Hiragana"]           = 0x02d000;
			script["Inherited"]          = 0x02e000;
			script["Javanese"]           = 0x02f000;
			script["Kannada"]            = 0x031000;
			script["Katakana"]           = 0x022000;
			script["KayahLi"]            = 0x033000;
			script["Khmer"]              = 0x034000;
			script["Lao"]                = 0x035000;
			script["Latin"]              = 0x036000;
			script["Lepcha"]             = 0x037000;
			script["Limbu"]              = 0x038000;
			script["Lisu"]               = 0x039000;
			script["Malayalam"]          = 0x03a000;
			script["Mandaic"]            = 0x03b000;
			script["MeeteiMayek"]        = 0x03c000;
			script["Mongolian"]          = 0x03d000;
			script["Myanmar"]            = 0x03e000;
			script["NewTaiLue"]          = 0x03f000;
			script["Nko"]                = 0x041000;
			script["Ogham"]              = 0x042000;
			script["OlChiki"]            = 0x043000;
			script["Oriya"]              = 0x044000;
			script["PhagsPa"]            = 0x045000;
			script["Rejang"]             = 0x046000;
			script["Runic"]              = 0x047000;
			script["Samaritan"]          = 0x048000;
			script["Saurashtra"]         = 0x049000;
			script["Sinhala"]            = 0x04a000;
			script["Sundanese"]          = 0x04b000;
			script["SylotiNagri"]        = 0x04c000;
			script["Syriac"]             = 0x04d000;
			script["Tagalog"]            = 0x04e000;
			script["Tagbanwa"]           = 0x04f000;
			script["TaiLe"]              = 0x051000;
			script["TaiTham"]            = 0x052000;
			script["TaiViet"]            = 0x053000;
			script["Tamil"]              = 0x054000;
			script["Telugu"]             = 0x055000;
			script["Thaana"]             = 0x056000;
			script["Thai"]               = 0x057000;
			script["Tibetan"]            = 0x058000;
			script["Tifinagh"]           = 0x059000;
			script["Vai"]                = 0x05a000;
			script["Yi"]                 = 0x05b000;

			code[0x011000]="Arabic"            ;
			code[0x012000]="Armenian"          ;
			code[0x013000]="Balinese"          ;
			code[0x014000]="Bamum"             ;
			code[0x015000]="Batak"             ;
			code[0x016000]="Bengali"           ;
			code[0x017000]="Bopomofo"          ;
			code[0x018000]="Braille"           ;
			code[0x019000]="Buginese"          ;
			code[0x01a000]="Buhid"             ;
			code[0x01b000]="CanadianAboriginal";
			code[0x01c000]="Cham"              ;
			code[0x01d000]="Cherokee"          ;
			code[0x01e000]="Common"            ;
			code[0x01f000]="Coptic"            ;
			code[0x021000]="Cyrillic"          ;
			code[0x022000]="Devanagari"        ;
			code[0x023000]="Ethiopic"          ;
			code[0x024000]="Georgian"          ;
			code[0x025000]="Glagolitic"        ;
			code[0x026000]="Greek"             ;
			code[0x027000]="Gujarati"          ;
			code[0x028000]="Gurmukhi"          ;
			code[0x029000]="Han"               ;
			code[0x02a000]="Hangul"            ;
			code[0x02b000]="Hanunoo"           ;
			code[0x02c000]="Hebrew"            ;
			code[0x02d000]="Hiragana"          ;
			code[0x02e000]="Inherited"         ;
			code[0x02f000]="Javanese"          ;
			code[0x031000]="Kannada"           ;
			code[0x022000]="Katakana"          ;
			code[0x033000]="KayahLi"           ;
			code[0x034000]="Khmer"             ;
			code[0x035000]="Lao"               ;
			code[0x036000]="Latin"             ;
			code[0x037000]="Lepcha"            ;
			code[0x038000]="Limbu"             ;
			code[0x039000]="Lisu"              ;
			code[0x03a000]="Malayalam"         ;
			code[0x03b000]="Mandaic"           ;
			code[0x03c000]="MeeteiMayek"       ;
			code[0x03d000]="Mongolian"         ;
			code[0x03e000]="Myanmar"           ;
			code[0x03f000]="NewTaiLue"         ;
			code[0x041000]="Nko"               ;
			code[0x042000]="Ogham"             ;
			code[0x043000]="OlChiki"           ;
			code[0x044000]="Oriya"             ;
			code[0x045000]="PhagsPa"           ;
			code[0x046000]="Rejang"            ;
			code[0x047000]="Runic"             ;
			code[0x048000]="Samaritan"         ;
			code[0x049000]="Saurashtra"        ;
			code[0x04a000]="Sinhala"           ;
			code[0x04b000]="Sundanese"         ;
			code[0x04c000]="SylotiNagri"       ;
			code[0x04d000]="Syriac"            ;
			code[0x04e000]="Tagalog"           ;
			code[0x04f000]="Tagbanwa"          ;
			code[0x051000]="TaiLe"             ;
			code[0x052000]="TaiTham"           ;
			code[0x053000]="TaiViet"           ;
			code[0x054000]="Tamil"             ;
			code[0x055000]="Telugu"            ;
			code[0x056000]="Thaana"            ;
			code[0x057000]="Thai"              ;
			code[0x058000]="Tibetan"           ;
			code[0x059000]="Tifinagh"          ;
			code[0x05a000]="Vai"               ;
			code[0x05b000]="Yi"                ;
		}

		public function addScript(scriptName:String,codeId:int):void{
			script[scriptName] = codeId;
			code[codeId] = scriptName;
		}

		public function getCodeByScript(scriptName : String) : uint {
			return script[scriptName];
		}
		
		public function getScriptByCode(codeId:int):String{
			return code[codeId];
		}
	}
}
