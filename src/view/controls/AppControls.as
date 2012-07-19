package view.controls {
	import com.braitsch.evt.AirEvent;
	import com.braitsch.ui.btns.SimpleButton;
	import com.braitsch.ui.btns.SimpleButtonIcon;
	import com.braitsch.ui.theme;
	import com.greensock.TweenLite;

	import flash.desktop.NativeApplication;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class AppControls extends Sprite {
		
		private static var _timerOpen			:Timer = new Timer(1000, 1);
		private static var _timerClose			:Timer = new Timer(5000, 1);
		private static var _controls			:Sprite = new Sprite();
		private static var _controlsActive 		:Boolean = false;
		private static var _buttonClose			:SimpleButton = new SimpleButton(30, 30, theme.DEFAULT);
		private static var _buttonQuitApp		:SimpleButton = new SimpleButton(80, 30, theme.DEFAULT, 'Quit');
		private static var _buttonNormal		:SimpleButton = new SimpleButton(140, 30, theme.DEFAULT, 'Normal Mode');
		private static var _buttonFullscreen	:SimpleButton = new SimpleButton(140, 30, theme.DEFAULT, 'Fullscreen');
		
		public function AppControls()
		{
			drawControls();
			graphics.beginFill(0xff0000, 0);
			graphics.drawRect(0, 0, 1050, 80);
			graphics.endFill();
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_timerOpen.addEventListener(TimerEvent.TIMER_COMPLETE, openControls);
			_timerClose.addEventListener(TimerEvent.TIMER_COMPLETE, closeControls);
		}

		private function drawControls():void
		{
			var bkgd:Shape = new Shape();
				bkgd.alpha = .4;
				bkgd.graphics.beginBitmapFill(new LtGreyPattern());
				bkgd.graphics.drawRect(0, 0, App.WIDTH, 50);
				bkgd.graphics.endFill();
			var mask:Shape = new Shape();
				mask.graphics.beginFill(0xff0000);
				mask.graphics.drawRect(0, 0, App.WIDTH, 50);
				mask.graphics.endFill();
			_buttonClose.y = _buttonQuitApp.y = 10;
			_buttonFullscreen.y = _buttonNormal.y = 10;
			_buttonClose.x = App.WIDTH - _buttonClose.width - 10;
			_buttonQuitApp.x = _buttonClose.x - _buttonQuitApp.width - 10;
			_buttonNormal.x = _buttonQuitApp.x - _buttonNormal.width - 10;
			_buttonFullscreen.x = _buttonNormal.x - _buttonFullscreen.width - 10;
			_buttonClose.icon = new SimpleButtonIcon(CloseIcon);
			_controls.addChild(bkgd);
			_controls.addChild(_buttonClose);
			_controls.addChild(_buttonQuitApp);
			_controls.addChild(_buttonNormal);
			_controls.addChild(_buttonFullscreen);
			_controls.y = -_controls.height;
			addChild(mask);
			addChild(_controls);
			_controls.mask = mask;
			_controls.addEventListener(MouseEvent.CLICK, onControlClick);
		}

		private function onControlClick(e:MouseEvent):void
		{
			switch(e.target){
				case _buttonClose 		: closeControls(); 		break;
				case _buttonQuitApp 	: onQuitApp(); 			break;
				case _buttonNormal 		: onNormalMode(); 		break;
				case _buttonFullscreen 	: onFullscreenMode(); 	break;
			}
		}

		private function onMouseUp(e:MouseEvent):void
		{
			_timerOpen.stop();	
		}

		private function onMouseDown(e:MouseEvent):void
		{
			if (_controlsActive == false){
				_timerOpen.reset(); _timerOpen.start();
			}
		}
		
		private function openControls(e:TimerEvent):void
		{
			_timerClose.start();
			_controlsActive = true;
			TweenLite.to(_controls, .3, {y : 0});
		}
		
		private function closeControls(e:TimerEvent = null):void
		{
			_timerClose.stop(); _timerClose.reset();
			TweenLite.to(_controls, .3, {y : -_controls.height, onComplete:function():void{ _controlsActive = false; }});
		}

		private function onQuitApp():void
		{
			NativeApplication.nativeApplication.exit();
		}

		private function onNormalMode():void
		{
			_timerClose.reset(); _timerClose.start();
			App.engine.dispatchEvent(new AirEvent(AirEvent.DISPLAY_MODE_NORMAL));
		}
	
		private function onFullscreenMode():void
		{
			_timerClose.reset(); _timerClose.start();
			App.engine.dispatchEvent(new AirEvent(AirEvent.DISPLAY_MODE_FULLSCREEN));
		}
		
	}
	
}
