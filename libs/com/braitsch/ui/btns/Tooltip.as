package com.braitsch.ui.btns {
	import com.braitsch.txt.TextField;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class Tooltip extends Sprite {

		private static var _timeout		:int = 500;
		private static var _disabled	:Boolean;
		private static var _dropBox		:DropShadowFilter = new DropShadowFilter(3, 90, 0, .5);
		private static var _glowLabel	:GlowFilter = new GlowFilter(0xffffff, 1, 2, 2, 3, 3);
		
		private var _text				:TextField = TextField(DroidSerifBold);
		private var _timer				:Timer = new Timer(_timeout, 1);
		private var _button				:Sprite;
	
		public function Tooltip(label:String)
		{
			draw(label);
			_timer.addEventListener(TimerEvent.TIMER, onTimeout);
		}
		
		public function set button(s:Sprite):void
		{
			_button = s;
		}	
		
		public function show():void
		{
			if (_disabled == false) startTimeout();
		}
		
		public function hide():void
		{
			_timer.stop();
			if (this.stage) stage.removeChild(this);
		}
		
		private function startTimeout():void
		{
			_timer.reset();
			_timer.start();
		}	
		
		private function onTimeout(e:TimerEvent):void
		{
			var p:Point = _button.parent.localToGlobal(new Point(_button.x, _button.y));
			this.x = p.x; this.y = p.y - 20; 
			_button.stage.addChild(this);
		}						
		
		private function draw(s:String):void
		{
			addChild(_text);
			_text.mouseEnabled = false;
			_text.mouseChildren = false;
			_text.label.autoSize = 'center';
			_text.label.y = -16;
			_text.text = s;
			_text.filters = [_glowLabel];
			var w:uint = _text.label.width + 10;
			_text.graphics.beginFill(0xE6E6E6);
			_text.graphics.drawRoundRect(-w/2, -20, w, 20, 3);
			_text.graphics.drawTriangles(Vector.<Number>([-7,0, 7,0, 0,6]));
			_text.graphics.endFill();
			_text.filters = [_dropBox];
		}

	}
	
}
