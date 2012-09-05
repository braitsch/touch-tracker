package com.braitsch.ui.modal {

	import com.braitsch.txt.TextField;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;

	public class ModalTitle extends Sprite {
		
		private var _mask				:Shape = new Shape();
		private var _width				:Number;
		private var _title				:TextField = new TextField(DroidSerifBold);
		private static var _pattern		:ModalTitlePattern = new ModalTitlePattern();
		
		public function ModalTitle()
		{
			_title.align = 'center';
			_title.color = 0xffffff;
			addChild(_title); addChild(_mask); this.mask = _mask;
			this.filters = [new GlowFilter(0x000000, .3, 3, 3)];
		}
		
		public function set text(s:String):void 
		{ 
			_title.text = s;
			_title.y = _pattern.height / 2 - _title.height / 2;
			_width = _pattern.width * (Math.ceil(_title.width / _pattern.width) + 4);
			_title.label.width = _width;
			draw();
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginBitmapFill(_pattern);
			graphics.drawRect(0, 0, _width, _pattern.height);
			graphics.endFill();	
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000, .5);
			_mask.graphics.drawRect(4, 0, _width - 8, _pattern.height);
			_mask.graphics.endFill();	
		}
		
	}
	
}
