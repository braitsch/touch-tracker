package com.braitsch.ui.forms {
	import fl.text.TLFTextField;

	import model.AppEngine;

	import com.braitsch.evt.UIEvent;

	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;

	public class Form extends Sprite {

		private var _width		:uint;
		private var _height		:uint;
		private var _mtrx		:Matrix = new Matrix();
		private var _inputs		:Vector.<FormField> = new Vector.<FormField>();
		private var _bkgd		:Shape = new Shape();
		private var _labelWidth	:uint = 80;
		
		public static const	itemHeight	:uint = 28;		
		public static const	stroke		:uint = 0xDADADA;
		public static const	padding		:uint = 5;
		public static const glowFilter	:GlowFilter = new GlowFilter(0xffffff, 1, 6, 6, 2, BitmapFilterQuality.HIGH);

		public function Form(w:uint)
		{
			_width = w;
			this.filters = [glowFilter];
			addChild(_bkgd);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function setField(n:uint, s:String):void
		{
			_inputs[n].field.text = s;
		}
		
		public function getField(n:uint):String
		{
			return _inputs[n].field.text;	
		}

		public function getInput(n:uint):*
		{
			return _inputs[n].field;
		}		
		
		public function set labelWidth(n:uint):void
		{
			_labelWidth = n;
		}
		
		public function validate():Boolean
		{
			for (var i:int = 0; i < _inputs.length; i++){
				if (_inputs[i].field.text == '') {
					AppEngine.dispatch(new UIEvent(UIEvent.SHOW_ALERT, 'Please fill in all required fields'));
					return false;
				}
			}
			return true;
		}		
		
		public function set fields(a:Array):void
		{
			for (var i:uint = 0; i < a.length; i++){
				var l:FormLabel = new FormLabel(_labelWidth, a[i].label);
					l.y = padding + ((itemHeight + padding) * i);
				addChild(l);
				var e:Boolean = a[i].enabled == undefined ? true : a[i].enabled;
				var p:Boolean = a[i].pass == undefined ? false : a[i].pass;
				var w:uint = _width - _labelWidth - (padding * 2);
				var t:FormField = new FormField(w, e, p);
					t.y = padding + ((itemHeight + padding) * i);
					t.x = _labelWidth + (padding * 2);
				addChild(t);
				_inputs.push(t);
			}
			_height = (_inputs.length * itemHeight) + (padding * (_inputs.length + 1));
			_mtrx.createGradientBox(_width, _height, Math.PI / 2);
			drawOutlines();
			drawBackground();
			addTabAndKeyListeners();
		}

		private function addTabAndKeyListeners():void
		{
			for (var i:int = 0; i < _inputs.length; i++) {
				var f:* = _inputs[i].field;
				if (f.selectable == false) return;
				if (f is TextField){
					f.tabIndex = i;
					f.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				}	else{
					f.getChildAt(1).tabIndex = i;
					f.getChildAt(1).addEventListener(KeyboardEvent.KEY_UP, onKeyUp);	
				}
				f.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
			}	
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (this.stage && e.keyCode == 13) dispatchEvent(new UIEvent(UIEvent.ENTER_KEY));
		}		
		
		private function onFocusIn(e:FocusEvent):void
		{
			if (e.target is TextField){
				e.target.setSelection(0, e.target.length);
			}	else if (e.target is Sprite){
				e.target.parent.setSelection(0, e.target.parent.length);
			}
		}
		
		private function onAddedToStage(e:Event):void 
		{
			var n:TLFTextField = _inputs[0].field as TLFTextField;
			if (n.selectable){
				n.setSelection(0, n.length);
				n.textFlow.interactionManager.setFocus();			
			}
		}			

		private function drawBackground():void
		{
			_bkgd.alpha = .3;
			_bkgd.graphics.beginGradientFill(GradientType.LINEAR, [0xffffff, 0x999999], [1, 1], [0, 255], _mtrx);
			_bkgd.graphics.drawRect(0, 0, _width, _height);
			_bkgd.graphics.endFill();				
		}
		
		private function drawOutlines():void
		{
			graphics.lineStyle(1, stroke, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
			graphics.beginFill(0xffffff);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			graphics.moveTo(_labelWidth + padding, 0);
			graphics.lineTo(_labelWidth + padding, _height);				
		}
		
	}
	
}
import com.braitsch.ui.forms.Form;
import com.braitsch.ui.forms.FormFieldText;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

class FormLabel extends Sprite {

	private var _view		:FormFieldText = new FormFieldText();
	private var _bkgd		:Shape = new Shape();
	
	public function FormLabel(w:uint, s:String)
	{
		_view.text = s;
		_view.x = Form.padding;
		_view.label.autoSize = TextFieldAutoSize.LEFT;
		_view.graphics.beginFill(0xffffff);
		_view.graphics.lineStyle(1, Form.stroke, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
		_view.graphics.drawRect(0, 0, w, Form.itemHeight);
		_view.graphics.endFill();		
		_bkgd.alpha = .1;
		_bkgd.graphics.beginBitmapFill(new DiagonalPattern());
		_bkgd.graphics.drawRect(0, 0, w, Form.itemHeight);
		_bkgd.graphics.endFill();
		_view.addChild(_bkgd);
		_view.filters = [Form.glowFilter];
		addChild(_view);
	}
	
}

class FormField extends Sprite {

	private var _view:*;
	private var _bkgd		:Shape;

	public function FormField(w:uint, enabled:Boolean = true, pass:Boolean = false)
	{
		if (pass == false){
			_view = new FormFieldText();
		}	else{
			_view = new FormFieldPass();
			_view.label.displayAsPassword = true;
		}
		_view.label.text = '';
		_view.label.width = w;
		_view.selectable = enabled;
		_view.label.type = enabled ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		_view.filters = [Form.glowFilter];
		addChild(_view);
		drawBackground(w, enabled);
	}
	
	public function get field():*
	{
		return _view.label;
	}
	
	private function drawBackground(w:uint, b:Boolean):void
	{
		_view.graphics.beginFill(0xffffff);
		if (b == false){
			_bkgd = new Shape();
			_bkgd.alpha = .1;
			_bkgd.graphics.beginBitmapFill(new DiagonalPattern());
			_bkgd.graphics.drawRect(0, 0, w - Form.padding, Form.itemHeight);
			_bkgd.graphics.endFill();
			_view.addChildAt(_bkgd, 0);
		}
		_view.graphics.lineStyle(1, Form.stroke, 1, true, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.MITER);
		_view.graphics.drawRect(0, 0, w - Form.padding, Form.itemHeight);
		_view.graphics.endFill();		
	}
	
}
