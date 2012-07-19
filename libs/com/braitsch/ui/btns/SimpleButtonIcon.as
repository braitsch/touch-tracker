package com.braitsch.ui.btns {
	import com.greensock.TweenLite;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SimpleButtonIcon extends Sprite {
		
		private var _over		:*;
		private var _tooltip	:Tooltip;
		
		public function SimpleButtonIcon(base:Class, over:Class = null)
		{
			attachBase(new base());
			if (over) attachOver(new over());
			this.buttonMode = true
			this.mouseChildren = false;
		}
		
		private function attachBase(o:Object):void
		{
			if (o is Sprite){
				addChild(o as Sprite); 
			}	else if (o is BitmapData){
				addChild(new Bitmap(o as BitmapData)); 
			}	else{
				trace("SimpleButtonIcon.attachBase(o) Invalid Class :", o);
			}
		}
		
		private function attachOver(o:Object):void
		{
			if (o is Sprite){
				addChild(o as Sprite); 
			}	else if (o is BitmapData){
				addChild(new Bitmap(o as BitmapData)); 
			}	else{
				trace("SimpleButtonIcon.attachOver(o) Invalid Class :", o);
			}
			_over.alpha = 0;
			addChild(_over);
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
			if (_over) TweenLite.to(_over, .5, {alpha:1});
		}		
		
		private function onButtonRollOut(e:MouseEvent):void 
		{
			if (_tooltip) _tooltip.hide();
			if (_over) TweenLite.to(_over, .3, {alpha:0});
		}		
		
	}
	
}
