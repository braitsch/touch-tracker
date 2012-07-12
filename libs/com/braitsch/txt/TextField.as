package com.braitsch.txt {
	import fl.text.TLFTextField;

	import flash.display.Sprite;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class TextField extends Sprite {
		
		private var _text	:*;
		private var _frmt	:TextFormat = new TextFormat();
		
		public static const GREY	:uint	= 0x666666;
		public static const WHITE	:uint	= 0xffffff;

		public function TextField(font:Class = null)
		{
			_text = font ? new font() : new HelveticaNeue();
			addChild(_text);
			this.selectable = false;
			this.label.width = 300;
			this.label.wordWrap = false;
			this.label.type = TextFieldType.INPUT;
		}
		
		public function get label():TLFTextField 
		{
			return _text.label_txt;
		}
		
		public function set text(s:String):void
		{
			_text.label_txt.htmlText = s;
		}
		
		public function set size(n:uint):void
		{
			_frmt.size = n;
			this.label.setTextFormat(_frmt);				
		}
		
		public function set color(n:uint):void
		{
			_frmt.color = n;
			this.label.setTextFormat(_frmt);	
		}
		
		public function set align(s:String):void
		{
			_frmt.align = s;
			this.label.autoSize = s;
			this.label.setTextFormat(_frmt);
		}
		
		public function set selectable(b:Boolean):void
		{
			this.label.selectable = b;
			this.label.mouseEnabled = b;
			this.label.mouseChildren = b;
		}
		
	}
	
}
