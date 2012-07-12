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

	public class LabelButton extends Sprite {

		private static const	WHITE		:uint = 0xffffff;
		private static const	DK_GREY		:uint = 0x888888;
		private static const	STROKE		:uint = 0xC0C0C0;
		public static const 	GLOW		:GlowFilter = new GlowFilter(0xffffff, 1, 6, 6, 2, BitmapFilterQuality.HIGH);				
		
		private var _width		:uint;
		private var _height		:uint;
		private var _over		:Shape = new Shape();
		private var _bkgd		:Shape = new Shape();
		private var _mtrx		:Matrix = new Matrix();
		private var _label		:TextField;
		private var _icon		:LabelButtonIcon;

		public function LabelButton(width:uint, height:uint, label:String)
		{
			setup(width, height);
			drawBkgd();
			drawOver();
			drawStroke();
			addLabel(label);
			this.enabled = true;
		}
		
		public function set icon(b:LabelButtonIcon):void
		{
			_icon = b;
			_icon.x = 25;
			_icon.y = _height / 2;
			addChild(_icon);			
		}
		
		public function get icon():LabelButtonIcon
		{
			return _icon;
		}
		
		public function set label(s:String):void
		{
			_label.text = s;
			_label.x = _width / 2 - _label.width / 2;
			_label.y = _height / 2 - _label.height / 2 + 1; 
		}
		
		private function setup(w:uint, h:uint):void
		{
			_width = w; _height = h;
			_mtrx.createGradientBox(w, h, Math.PI / 2);
		}

		private function drawBkgd():void
		{
			_bkgd.graphics.beginGradientFill(GradientType.LINEAR, [WHITE, DK_GREY], [.3, .3], [80, 255], _mtrx);
			_bkgd.graphics.drawRect(0, 0, _width, _height);
			_bkgd.graphics.endFill();
			addChild(_bkgd);
		}

		private function drawOver():void
		{
			_over.graphics.beginGradientFill(GradientType.LINEAR, [DK_GREY, WHITE], [.3, .3], [0, 170], _mtrx);
			_over.graphics.drawRect(0, 0, _width, _height);
			_over.graphics.endFill();
			_over.alpha = 0;
			addChild(_over);
		}

		private function drawStroke():void
		{
			graphics.lineStyle(1, STROKE, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
			graphics.drawRect(0, 0, _width, _height);
		}		
		
		private function addLabel(s:String):void
		{
			_label = new TextField(DroidSerifBold);
			_label.size = 12;
			_label.color = TextField.GREY;
			_label.filters = [GLOW];
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
			TweenLite.to(_bkgd, .3, {alpha:0});
		}	
			
		private function onRollOut(e:MouseEvent):void
		{
			TweenLite.to(_over, .3, {alpha:0});
			TweenLite.to(_bkgd, .3, {alpha:1});
		}
		
	}
	
}
