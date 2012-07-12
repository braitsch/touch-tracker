package com.braitsch.ui.btns {
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	
	public class IconButton extends Sprite {
		
		private var _over		:Bitmap;
		private var _tooltip	:Tooltip;

		public function IconButton(off:Class, over:Class)
		{
			_over = new Bitmap(new over());
			_over.alpha = 0;
			addChild(new Bitmap(new off())); addChild(_over);
			enabled = true; this.mouseChildren = false;
		}
		
		public function set enabled(b:Boolean):void
		{
			if (b){
				this.alpha = 1;
				this.buttonMode = true;
				this.addEventListener(MouseEvent.ROLL_OUT, onButtonRollOut);
				this.addEventListener(MouseEvent.ROLL_OVER, onButtonRollOver);
			}	else{
				this.alpha = .5;
				this.buttonMode = false;
				this.removeEventListener(MouseEvent.ROLL_OUT, onButtonRollOut);
				this.removeEventListener(MouseEvent.ROLL_OVER, onButtonRollOver);
			}
		}
		
		public function get enabled():Boolean
		{
			return this.alpha == 1;
		}
		
		public function set tooltip(s:String):void
		{
			if (_tooltip == null){
				_tooltip = new Tooltip(s);
				_tooltip.button = this;
			}
		}
		
		private function onButtonRollOver(e:MouseEvent):void 
		{
			if (_tooltip) _tooltip.show();
			TweenLite.to(_over, .5, {alpha:1});
		}		
		
		private function onButtonRollOut(e:MouseEvent):void 
		{
			if (_tooltip) _tooltip.hide();
			TweenLite.to(_over, .3, {alpha:0});
		}
		
	}
	
}
