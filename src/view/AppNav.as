package view {
	import evt.AppEvent;

	import com.braitsch.ui.btns.LabelButton;
	import com.braitsch.ui.theme;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	public class AppNav extends Sprite {
		
		private static var _btns	:Sprite = new Sprite();
		private static var _btn1	:LabelButton = new LabelButton(90, 30, 'Gesture', theme.DEFAULT);
		private static var _btn2	:LabelButton = new LabelButton(90, 30, 'Console', theme.DEFAULT);
		private static var _btn3	:LabelButton = new LabelButton(90, 30, 'Circles', theme.DEFAULT);
		
		public function AppNav()
		{
			_btn2.x = _btn1.x + _btn1.width + 10;
			_btn3.x = _btn2.x + _btn2.width + 10;
			_btns.y = 10;
			_btns.addChild(_btn1);
			_btns.addChild(_btn2);
			_btns.addChild(_btn3);
			addChild(_btns);
			_btn1.addEventListener(MouseEvent.CLICK, toggleMode);
			_btn2.addEventListener(MouseEvent.CLICK, showConsole);
			_btn3.addEventListener(MouseEvent.CLICK, showCircles);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function toggleMode(e:MouseEvent):void
		{
			if (_btn1.label == 'Gesture'){
				_btn1.label = 'Touch';
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT; 				
			}	else if (_btn1.label == 'Touch'){
				_btn1.label = 'Gesture';
				Multitouch.inputMode = MultitouchInputMode.GESTURE; 				
			}
		}

		private function showCircles(e:MouseEvent):void
		{
			this.dispatchEvent(new AppEvent(AppEvent.SHOW_CIRCLES));
		}

		private function showConsole(e:MouseEvent):void
		{
			this.dispatchEvent(new AppEvent(AppEvent.SHOW_CONSOLE));
		}
		
		private function onAddedToStage(e:Event):void
		{
			onStageResize(e);
			stage.addEventListener(Event.RESIZE, onStageResize);
		}

		private function onStageResize(e:Event):void
		{
			_btns.x = stage.stageWidth - _btns.width - 10;
			this.graphics.clear();
			this.graphics.beginFill(0x000000, .3);
			this.graphics.drawRect(0, 0, stage.stageWidth, 50);
		}
				
	}
	
}
