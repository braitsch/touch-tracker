package com.braitsch.ui.btns {
	import com.braitsch.txt.TextField;
	import com.greensock.TweenLite;

	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;

	public class SimpleButton extends Sprite {

		private var _width			:uint;
		private var _height			:uint;
		private var _over			:Shape = new Shape();
		private var _bkgd			:Shape = new Shape();
		private var _stroke			:Shape = new Shape();
		private var _mtrx			:Matrix = new Matrix();
		private var _label			:TextField;
		private var _icon			:SimpleButtonIcon;
		private var _corner			:uint = 5;
		private var _theme			:Object;

		public function SimpleButton(width:uint, height:uint, theme:Object, label:String = '')
		{
			setup(width, height);
			_theme = theme;
			drawBkgd();
			drawOver();
			drawStroke();
			addLabel(label);
			this.enabled = true;
		}
		
		public function set icon(b:SimpleButtonIcon):void
		{
			_icon = b;
			_icon.x = _width / 2 - _icon.width / 2;
			_icon.y = _height / 2 - _icon.height / 2;
			addChild(_icon);			
		}
		
		public function get icon():SimpleButtonIcon
		{
			return _icon;
		}
		
		public function set label(s:String):void
		{
			_label.text = s;
			_label.x = _width / 2 - _label.width / 2;
			_label.y = _height / 2 - _label.height / 2 + 1; 
		}
		
		public function get label():String
		{
			return _label.text;
		}
		
		private function setup(w:uint, h:uint):void
		{
			_width = w; _height = h;
			_mtrx.createGradientBox(w, h, Math.PI / 2);
		}

		private function drawBkgd():void
		{
			_bkgd.graphics.beginGradientFill(GradientType.LINEAR, [_theme.c1, _theme.c2], [1, 1], [80, 255], _mtrx);
			_bkgd.graphics.drawRoundRect(0, 0, _width, _height, _corner);
			_bkgd.graphics.endFill();
			addChild(_bkgd);
		}

		private function drawOver():void
		{
			_over.graphics.beginGradientFill(GradientType.LINEAR, [_theme.c2, _theme.c1], [1, 1], [0, 170], _mtrx);
			_over.graphics.drawRoundRect(0, 0, _width, _height, _corner);
			_over.graphics.endFill();
			_over.alpha = 0;
			addChild(_over);
		}

		private function drawStroke():void
		{
			_stroke.graphics.lineStyle(2, _theme.stroke, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND);
			_stroke.graphics.drawRoundRect(0, 0, _width, _height, _corner);
			addChild(_stroke);
		}
		
		private function addLabel(s:String):void
		{
			_label = new TextField(DroidSerifBold);
			_label.size = 14;
			_label.color = _theme.text;
			_label.mouseEnabled = false;
			_label.mouseChildren = false;
			if (_theme.glow) _label.filters = [new GlowFilter(_theme.glow, 1, 6, 6, 2, BitmapFilterQuality.HIGH)];
			this.label = s;
			addChild(_label);
		}
		
		public function set enabled(b:Boolean):void
		{
			if (b){
				alpha = 1;
				buttonMode = true;
				addEventListener(MouseEvent.ROLL_OUT, onRollOut);
				addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			}	else{
				alpha = .5;
				buttonMode = false;
				removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
				removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			}			
		}	
		
		public function get enabled():Boolean
		{
			return alpha == 1;
		}				
		
		private function onRollOver(e:MouseEvent):void
		{
			TweenLite.to(_over, .3, {alpha:1});
		}	
			
		private function onRollOut(e:MouseEvent):void
		{
			TweenLite.to(_over, .3, {alpha:0});
		}
		
	}
	
}
