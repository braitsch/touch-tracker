package com.braitsch.ui.modal {
	import model.AppEngine;

	import com.braitsch.evt.UIEvent;
	import com.braitsch.txt.TextField;
	import com.braitsch.ui.btns.IconButton;
	import com.braitsch.ui.forms.FormButton;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filters.GlowFilter;
	import flash.geom.Point;


	public class ModalWindow extends Sprite {

		private var _width					:uint;
		private var _height					:uint;
		private var _windowBkgd				:Shape = new Shape();
		private var _windowTitle			:ModalTitle = new ModalTitle();
		private var _closeButton			:IconButton;
		private var _windowMessage			:TextField;
		private var _okButton				:FormButton;
		private var _noButton				:FormButton;
		
		private static var _file			:File = File.desktopDirectory;
		private static var _glow			:GlowFilter = new GlowFilter(0x000000, .5, 20, 20, 2, 2);		
		private static var _bkgdPattern		:BitmapData = new LtGreyPattern();
		private static var _resizeOffset	:Point = new Point();
		
		public static const	CONTENT_PADDING	:uint = 25;

		public function ModalWindow()
		{
			this.focusRect = false;
			_windowBkgd.filters = [_glow];
			_windowTitle.x = 15;
			addChild(_windowTitle);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);				
		}
		
		protected function set resizeOffset(p:Point):void
		{
			_resizeOffset = p;
		}
	
		protected function set title(s:String):void
		{
			_windowTitle.text = s;
		}
		
		protected function set message(s:String):void
		{
			if (_windowMessage == null) {
				_windowMessage = new TextField(DroidSerifBold);
				_windowMessage.y = 75;
				_windowMessage.size = 12;
				_windowMessage.color = TextField.GREY;
			 	_windowMessage.x = CONTENT_PADDING;
			 	_windowMessage.label.width = this.width - (CONTENT_PADDING * 2);		 		
		 		addChild(_windowMessage);
		 	}
		 	_windowMessage.text = s;
		}
		
		protected function get messageTF():TextField
		{
			return _windowMessage;
		}
		
		protected function onAddedToStage(e:Event):void 
		{ 
			onStageResize(e);
			stage.focus = this;
			stage.addEventListener(Event.RESIZE, onStageResize);
			stage.addEventListener(UIEvent.ENTER_KEY, onEnterKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		protected function onRemovedFromStage(e:Event):void
		{
			stage.removeEventListener(Event.RESIZE, onStageResize);
			stage.removeEventListener(UIEvent.ENTER_KEY, onEnterKey);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}			
		
		protected function drawBackground(w:uint, h:uint):void
		{
			_width = w; _height = h;
			_windowBkgd.graphics.clear();
			_windowBkgd.graphics.beginFill(0xFFFFFF);
			_windowBkgd.graphics.drawRect(0, 0, _width, _height);
			_windowBkgd.graphics.endFill();
			_windowBkgd.graphics.beginBitmapFill(_bkgdPattern);
			_windowBkgd.graphics.drawRect(4, 4, _width-8, _height-8);
			_windowBkgd.graphics.endFill();
			addChildAt(_windowBkgd, 0);
		}	
		
		protected function onOkButton():void { }
		protected function onNoButton():void { }
		
		protected function onCloseClick(e:MouseEvent):void 
		{
			AppEngine.dispatch(new UIEvent(UIEvent.CLOSE_WINDOW));
		}
		
		protected function get okButton():FormButton { return _okButton; }
		protected function get noButton():FormButton { return _noButton; }		
		
		protected function addOkButton(s:String = 'OK', x:uint = 0, y:uint = 0):void
		{
			_okButton = new FormButton(s);
			_okButton.x = x || _width - _okButton.width - CONTENT_PADDING;
			_okButton.y = y || _height - _okButton.height - CONTENT_PADDING;
			_okButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{ onOkButton(); } );
			addChild(_okButton);
		}
		
		protected function addNoButton(s:String = 'Cancel', x:uint = 0, y:uint = 0):void
		{
			_noButton = new FormButton(s);
			_noButton.x = x || _width - (_noButton.width * 2) - CONTENT_PADDING - 10;
			_noButton.y = y || _height - _noButton.height - CONTENT_PADDING;
			_noButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{ onNoButton(); } );				
			addChild(_noButton);			
		}
		
		protected function addCloseButton():void
		{
			_closeButton = new IconButton(ModalCloseOff, ModalCloseOver);
			_closeButton.y = - _closeButton.height/2 + 6;
			_closeButton.x = _width - _closeButton.width/2 - 6;
			_closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			addChild(_closeButton);
		}		

		protected function browseForFile($msg:String):void
		{
			_file.browseForOpen($msg);	
			_file.addEventListener(Event.SELECT, onBrowseSelection);			
		}

		protected function browseForDirectory($msg:String):void 
		{
			_file.browseForDirectory($msg);	
			_file.addEventListener(Event.SELECT, onBrowseSelection);			
		}

		private function onBrowseSelection(e:Event):void 
		{
			dispatchEvent(new UIEvent(UIEvent.FILE_BROWSER_SELECTION, e.target as File));
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (this.stage && e.keyCode == 13) onOkButton();
		}
		
		private function onEnterKey(e:UIEvent):void 
		{ 
			onOkButton();
		}
		
		private function onStageResize(e:Event):void
		{
			this.x = uint((stage.stageWidth / 2) - (this.width / 2) + _resizeOffset.x);
			this.y = uint((stage.stageHeight / 2) - (this.height / 2) + _resizeOffset.y);
		}

		override public function get width():Number { return _width; }

	}
	
}
